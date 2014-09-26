//
//  PRAPIManager.m
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRAPIManager.h"

#import <AFNetworking/AFNetworking.h>

#import "PRTrust.h"
#import "PRHospital.h"
#import "PRWard.h"

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
            NSLog(@"Got trust Hierarchy.");
        } else {
            NSLog(@"Failed to get trust Hierarchy: %@", errors);
        }
    }];
}

-(void)getQuestionHierarchy
{
    
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
                     @"answer-type":@"PRPMOSAnswerType",
                     @"option": @"PRAnswerOption"};
    }
    
    return nodeInfo[node] != nil ? nodeInfo[node] : node;
}

-(NSString *)TDCEntityKeyForTDCKey:(NSString *) tdcKey forEntityNamed:(NSString *) entityName
{
    if ([entityName isEqualToString:@"PRQuestion"]) {
        if ([tdcKey isEqualToString:@"id"]) {
            return @"questionID";
        }
    }
    
    if ([entityName isEqualToString:@"PRAnswerOption"]) {
        if ([tdcKey isEqualToString:@"id"]) {
            return @"answerID";
        }
    }
    
    return tdcKey;
}


-(NSString *)TDCKeyForEntityKeyPath:(NSString *) entityKeyPath forEntityNamed:(NSString *) entityName
{
    
    if ([entityName isEqualToString:@"PRQuestion"]) {
        if ([entityKeyPath isEqualToString:@"questionID"]) {
            return @"id";
        }
    }
    
    if ([entityName isEqualToString:@"PRAnswerOption"]) {
        if ([entityKeyPath isEqualToString:@"answerID"]) {
            return @"id";
        }
    }
    
    return entityKeyPath;
}

@end
