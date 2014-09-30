//
//  PRAPIManager.h
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TheDistanceKit/TheDistanceKit.h>

@class PRRecord;

@interface PRAPIManager : TDAPIManager

-(void)getTrustHierarchy;
-(void)getQuestionHierarchy;
-(void)getLocalizations;

-(void)submitRecord:(PRRecord *) record withCompletion:(void (^)(BOOL success, NSError *error)) completion;

@end
