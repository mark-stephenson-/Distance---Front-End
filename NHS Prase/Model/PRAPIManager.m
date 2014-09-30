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
#import "PRQuestion.h"
#import "PRRecord.h"

#import "PRNote.h"
#import "PRConcern.h"

#define PR_COLLECTION_TOKEN @"26e72f9ad86c8ef4802bc5cdaccf58cf"
#define PR_API_KEY @"a7ceffb72de96b5c17f3d70a76853348"

@implementation PRAPIManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }
    
    return self;
}

-(void)setBaseURL:(NSURL *)baseURL
{
    [super setBaseURL:baseURL];
    
    // configure the request serializer to have the correct credentials to access the store
    AFJSONRequestSerializer *jsonRequestSerializer = (AFJSONRequestSerializer *) sessionManager.requestSerializer;
    [jsonRequestSerializer setValue:PR_COLLECTION_TOKEN forHTTPHeaderField:@"Collection-Token"];
    [jsonRequestSerializer setAuthorizationHeaderFieldWithUsername:PR_API_KEY password:@"password"];
}

#pragma mark - Prase Methods

-(void)getTrustHierarchyWithCompletion:(void (^)(SEL selector, BOOL success, NSArray *errors)) completion
{
    [self TDCGetCommitAndLinkRelatedObjectsOfNodes:@[@"trust", @"hospital", @"ward"] withCompletion:^(BOOL success, NSArray *errors) {
        completion(_cmd, success, errors);
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

-(void)submitRecord:(PRRecord *)record withCompletion:(void (^)(BOOL, NSError *))completion
{
    // convert record to json
    NSMutableDictionary *jsonRecord = [NSMutableDictionary dictionary];
    
    if ([record.basicData isKindOfClass:[NSDictionary class]]) {
        
        // ensure all basic data keys are included even in the data is incomplete
        NSMutableDictionary *fullBasicData = [NSMutableDictionary dictionaryWithCapacity:7];
        NSArray *basicDataKeys = @[@"DOB", @"Gender", @"Ethnicity", @"Language", @"Admitted", @"InpatientCount", @"OngoingTreatment"];
        
        for (NSString *key in basicDataKeys) {
            id value = record.basicDataDictionary[key];
            
            if ([value isKindOfClass:[NSDate class]]) {
                value = [dateFormatter stringFromDate:value];
            }
            
            fullBasicData[key] = value ? : [NSNull null];
        }
        
        jsonRecord[@"basicData"] = fullBasicData;
    } else {
        NSError *serialisationError = [NSError errorWithDomain:TDAPIErrorDomain
                                                          code:kTDCAPIErrorUnexpectedRequest
                                                      userInfo:@{NSLocalizedDescriptionKey: @"Internal App Error Occured.",
                                                                 NSLocalizedFailureReasonErrorKey: @"Cannot submit a record with a non-dictionary basic data."}];
        completion(NO, serialisationError);
        return;
    }
    
    // format in standard ISO date format
    jsonRecord[@"startDate"] = [dateFormatter stringFromDate:record.startDate] ? : [NSNull null];
    
    // submitted in seconds
    jsonRecord[@"totalTimePatient"] = @(record.timeAdditionalPatient.longLongValue + record.timeTracked.longLongValue);
    jsonRecord[@"totalTimeQuestionnaire"] = @(record.timeAdditionalQuestionnaire.longLongValue + record.timeTracked.longLongValue);
    
    // the id will uniquely identify the ward, hospital and trust in TheCore
    jsonRecord[@"ward"] = record.ward.id ? : [NSNull null];
    
    // create the questions entry
    NSMutableArray *questionsEntry = [NSMutableArray arrayWithCapacity:record.questions.count];
    for (int q = 0; q < record.questions.count; q++) {
        PRQuestion *question = record.questions[q];
        NSDictionary *entry = [self serializeQuestion:question];
        [questionsEntry addObject:entry];
    }
    jsonRecord[@"pmos"] = questionsEntry;
    
    // serialize the notes, good notes and concerns
    NSMutableArray *noteEntries = [NSMutableArray arrayWithCapacity:record.notes.count];
    for (PRNote *note in record.notes) {
        NSDictionary *noteEntry = [self serializeNote:note];
        [noteEntries addObject:noteEntry];
    }
    
    NSMutableArray *goodEntries = [NSMutableArray arrayWithCapacity:record.goodNotes.count];
    for (PRNote *note in record.goodNotes) {
        NSDictionary *noteEntry = [self serializeNote:note];
        [goodEntries addObject:noteEntry];
    }
    
    NSMutableArray *concernEntries = [NSMutableArray arrayWithCapacity:record.concerns.count];
    for (PRConcern *concern in record.concerns) {
        NSDictionary *noteEntry = [self serializeConcern:concern];
        [noteEntries addObject:noteEntry];
    }
    
    jsonRecord[@"notes"] = noteEntries;
    jsonRecord[@"goodNotes"] = goodEntries;
    jsonRecord[@"concerns"] = concernEntries;
    jsonRecord[@"user"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"user"] ? : [NSNull null];
    
    NSLog(@"POSTING: %@", jsonRecord);
    
    // post to the server
    [sessionManager POST:@"api/submit"
              parameters:jsonRecord
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     
                     NSLog(@"Survey submitted.");
                     
                     if (completion != nil) {
                         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             completion(YES, nil);
                         }];
                         
                     }
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     
                     [self logErrorFromSelector:_cmd withFormat:@"Cannot submit survey.\nFailing Task: %@\nError: %@", task, error];
                     
                     if (completion) {
                         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             completion(NO, error);
                         }];
                     }
                 }];
}

-(NSDictionary *)serializeQuestion:(PRQuestion *) question
{
    NSMutableDictionary *thisEntry = [NSMutableDictionary dictionaryWithCapacity:5];
    thisEntry[@"questionID"] = question.pmosQuestion ? question.pmosQuestion.questionID : [NSNull null];
    thisEntry[@"answerID"] = question.answerID ? : [NSNull null];
    
    thisEntry[@"note"] = question.note ? [self serializeNote:question.note] : [NSNull null];
    thisEntry[@"somethingGood"] = question.goodNote ? [self serializeNote:question.goodNote] : [NSNull null];
    thisEntry[@"concern"] = question.concern ? [self serializeConcern:question.concern] : [NSNull null];
    
    return thisEntry;
}

-(NSDictionary *)serializeNote:(PRNote *) note
{
    NSMutableDictionary *thisEntry = [NSMutableDictionary dictionaryWithCapacity:1];
    
    thisEntry[@"text"] = [note.text isNonNullString] ? note.text : [NSNull null];
    
    return thisEntry;
}

-(NSDictionary *)serializeConcern:(PRConcern *) concern
{
    NSMutableDictionary *thisEntry = [NSMutableDictionary dictionaryWithCapacity:8];
    
    thisEntry[@"ward"] = concern.ward;

    thisEntry[@"whatNote"] = concern.whatNote ? [self serializeNote:concern.whatNote] : [NSNull null];
    thisEntry[@"whyNote"] = concern.whyNote ? [self serializeNote:concern.whyNote] : [NSNull null];
    thisEntry[@"preventNote"] = concern.preventNote ? [self serializeNote:concern.preventNote] : [NSNull null];
    
    PRQuestion *seriousQuestion = concern.seriousQuestion;
    thisEntry[@"seriousQuestion"] = seriousQuestion.pmosQuestion ? seriousQuestion.pmosQuestion.questionID : [NSNull null];
    thisEntry[@"seriousAnswer"] = seriousQuestion.answerID ? : [NSNull null];
    
    PRQuestion *preventQuestion = concern.preventQuestion;
    thisEntry[@"preventQuestion"] = preventQuestion.pmosQuestion ? preventQuestion.pmosQuestion.questionID : [NSNull null];
    thisEntry[@"preventAnswer"] = preventQuestion.answerID ? : [NSNull null];
    
    return thisEntry;
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
