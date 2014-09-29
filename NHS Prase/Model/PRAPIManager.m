//
//  PRAPIManager.m
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRAPIManager.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <AFNetworking/AFNetworking.h>

#import "PRTrust.h"
#import "PRHospital.h"
#import "PRWard.h"

#import "PRPMOS.h"
#import "PRPMOSQuestion.h"

#define PR_COLLECTION_TOKEN @"26e72f9ad86c8ef4802bc5cdaccf58cf"
#define PR_API_KEY @"a7ceffb72de96b5c17f3d70a76853348"

@implementation PRAPIManager

-(void)setBaseURL:(NSURL *)baseURL
{
    [super setBaseURL:baseURL];
    
    // configure the request serializer to have the correct credentials to access the store
    AFJSONRequestSerializer *jsonRequestSerializer = (AFJSONRequestSerializer *) sessionManager.requestSerializer;
    [jsonRequestSerializer setValue:PR_COLLECTION_TOKEN forHTTPHeaderField:@"Collection-Token"];
    [jsonRequestSerializer setAuthorizationHeaderFieldWithUsername:PR_API_KEY password:@"password"];
}

#pragma mark - Prase Methods

-(void)getTrustHierarchy
{
    [self TDCGetCommitAndLinkRelatedObjectsOfNodes:@[@"trust", @"hospital", @"ward"] withCompletion:^(BOOL success, NSArray *errors) {
        if (success) {
            NSLog(@"Got trusts, hospitals and wards.");
        } else {
            NSLog(@"Failed to get trusts, hospitals and wards: %@", errors);
        }
    }];
}

-(void)getQuestionHierarchy
{
    [self TDCGetCommitAndLinkRelatedObjectsOfNodes:@[@"question", @"answer-type", @"option"] withCompletion:^(BOOL success, NSArray *errors) {
        if (success) {
            NSLog(@"Got questions");
            // link in the PMOS questions from the question set
            
            [self getPMOSHierarchy];
            
            
        } else {
            NSLog(@"Failed to get questions: %@", errors);
        }
    }];
}

-(void)getPMOSHierarchy
{
    [sessionManager GET:@"api/hierarchy" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // This isn't on the main thread.
        NSManagedObjectContext *hierarchyContext = [NSManagedObjectContext MR_context];
        [hierarchyContext MR_setWorkingName:@"GET Hierarchy"];
        
        // create the only PMOS object
        PRPMOS *currentPmos = [PRPMOS MR_findFirstInContext:hierarchyContext];
        
        if (currentPmos == nil) {
            currentPmos = [PRPMOS MR_createInContext:hierarchyContext];
        }
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSDictionary *root = [(NSArray *)responseObject firstObject];
            
            // check for update
            
            NSArray *questionBranches = root[@"branches"];
            
            // load all the questions into memory
            
            NSArray *questions = [PRPMOSQuestion MR_findAllInContext:hierarchyContext];
            
            NSEntityDescription *pmosQuestionEntity = [(PRPMOSQuestion *)[questions firstObject] entity];
            
            NSMutableOrderedSet *questionSet = [NSMutableOrderedSet orderedSetWithCapacity:questionBranches.count];
            for (int q = 0; q < questionBranches.count; q++) {
                NSDictionary *questionInfo = questionBranches[q];
                
                id identifier = [self safeValueForEntityDescription:pmosQuestionEntity withKeypath:@"id" andProposedValue:questionInfo[@"id"]];
                PRPMOSQuestion *thisQuestion = [[questions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"questionID == %@", identifier]] firstObject];
                
                [questionSet addObject:thisQuestion];
            }
            
            currentPmos.questions = [NSOrderedSet orderedSetWithOrderedSet:questionSet];
            
            // called from background thread but will complete on main thread
            [hierarchyContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *commitError) {
                
                if (commitError != nil) {
                    NSError *coreDataError = [[self class] createCommitDownloadErrorForSavingError:commitError];
                    NSLog(@"Failed to get hierarchy: %@", coreDataError);
                } else {
                    NSLog(@"Completed hierarchy sync.");
                }
            }];
        } else {
            NSError *error = [[self class] createUnexpectedReponseErrorForRequest:task.currentRequest];
            [self logErrorFromSelector:_cmd withFormat:@"Unable to get hierarchy.\nFailingTask: %@\nError: %@", task, error];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self logErrorFromSelector:_cmd withFormat:@"Unable to get hierarchy.\nFailingTask: %@\nError: %@", task, error];
    }];
}

-(NSArray *)customLocalizationTables
{
    return @[@"PMOSQuestions"];
}

-(void)getLocalizations
{
    [self TDCGetLocalizationsToTableNamed:@"PMOSQuestions" withCompletion:^(BOOL success, NSArray *errors) {
        NSLog(@"Translations Completed with errors: %@", errors);
    }];
}

#pragma mark - TDAPIManager SubClass Methods

-(NSString *)TDCEntityNameForNode:(NSObject *) node
{
    static NSDictionary *nodeInfo = nil;
    
    if (nodeInfo == nil) {
        nodeInfo = @{@"trust": @"PRTrust",
                     @"hospital":@"PRHospital",
                     @"ward":@"PRWard",
                     @"question":@"PRPMOSQuestion",
                     @"answer-type":@"PRAnswerSet",
                     @"option": @"PRAnswerOption",
                     };
    }
    
    return nodeInfo[node] != nil ? nodeInfo[node] : node;
}



-(NSDictionary *)translations
{
    static NSDictionary *translations = nil;
    
    if (translations == nil) {
        translations = @{@"PRPMOSQuestion": @{@"id": @"questionID",
                                              @"answertypes": @"answerSets",
                                              @"question":@"localizationID"},
                         @"PRAnswerOption": @{@"id": @"answerID",
                                              @"tint": @"imageTintIdentifier",
                                              @"text": @"localizationID"}};
    }
    
    return translations;
}

-(NSDictionary *)reverseTranslations
{
    static NSDictionary *reverseTranslations = nil;
    
    if (reverseTranslations == nil) {
        NSDictionary *translations = [self translations];
        
        NSMutableDictionary *tempReverse = [NSMutableDictionary dictionaryWithCapacity:translations.count];
        for (NSString *class in translations.allKeys) {
            
            NSMutableDictionary *classDict = translations[class];
            NSMutableDictionary *tempClassDict = [NSMutableDictionary dictionaryWithCapacity:classDict.count];
            for (NSString *tdcKey in classDict.allKeys) {
                NSString *entityKey = classDict[tdcKey];
                tempClassDict[entityKey] = tdcKey;
            }
            
            tempReverse[class] = tempClassDict;
        }
        
        reverseTranslations = tempReverse;
    }
    
    return reverseTranslations;
}

-(NSString *)TDCEntityKeyForTDCKey:(NSString *) tdcKey forEntityNamed:(NSString *) entityName
{
    return ((NSDictionary *)[self translations][entityName])[tdcKey] ? : tdcKey;
}

-(NSString *)TDCKeyForEntityKeyPath:(NSString *) entityKeyPath forEntityNamed:(NSString *) entityName
{
    return ((NSDictionary *)[self reverseTranslations][entityName])[entityKeyPath] ? : entityKeyPath;
}

@end
