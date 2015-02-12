//
//  PRAPIManager.h
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TheDistanceKit/TheDistanceKit_API.h>

@class PRRecord;

@interface PRAPIManager : TDAPIManager

-(void)getTrustHierarchyWithCompletion:(void (^)(SEL selector, BOOL success, NSArray *errors)) completion;
-(void)getQuestionHierarchyWithCompletion:(void (^)(SEL selector, BOOL success, NSArray *errors)) completion;
-(void)getLocalizationsWithCompletion:(void (^)(SEL selector, BOOL success, NSArray *errors)) completion;

-(void)submitRecord:(PRRecord *) record withCompletion:(void (^)(BOOL success, NSError *error)) completion;

@end
