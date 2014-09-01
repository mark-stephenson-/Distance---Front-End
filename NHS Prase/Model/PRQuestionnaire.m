//
//  PRQuestionnaire.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionnaire.h"

#import "PRQuestion.h"
#import "PRQuestionOptions.h"
#import "PRQuestionStatement.h"


@implementation PRQuestionnaire

+(instancetype)prototypeQuestionnaire
{
    static PRQuestionnaire *prototype = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prototype = [[PRQuestionnaire alloc] init];
        
        NSArray *agreeOptions = @[@{@"title":@"Strongly Disagree"},
                                  @{@"title":@"Disagree"},
                                  @{@"title":@"Neither Agree or Disagree"},
                                  @{@"title":@"Agree"},
                                  @{@"title":@"Strongly Agree"}];
        
        PRQuestionOptions *agree = [PRQuestionOptions questionWithTitle:@"I knew what the different roles of the people caring for me were"];
        agree.options = agreeOptions;
        agree.showsNA = YES;
        
        PRQuestionOptions *extent = [PRQuestionOptions questionWithTitle:@"Were you involved as much as you wanted to be in decisions about your care and treatment?"];
        extent.options = @[@{@"title":@"Yes, definitely"},
                           @{@"title":@"Yes, to some extent"},
                           @{@"title":@"No"}];
        
        PRQuestionStatement *statement = [PRQuestionStatement questionWithTitle:@"Other aspets of the ward made it uncomfortable for me:"];
        statement.statement = @"Please add a concern, something good or a note to articulate as appropriate:";
        
        prototype.questions = @[agree, extent, statement];
    });
    
    return prototype;
}

@end
