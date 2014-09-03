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

#import <UIKit/UIKit.h>

#import "PRTheme.h"

@implementation PRQuestionnaire

+(instancetype)prototypeQuestionnaire
{
    static PRQuestionnaire *prototype = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prototype = [[PRQuestionnaire alloc] init];
        
        
        UIImage *cross = [UIImage imageNamed:@"cross"];
        UIImage *tick = [UIImage imageNamed:@"tick"];
        
        UIColor *positiveColour = [[PRTheme sharedTheme] positiveColor];
        UIColor *negativeColour = [[PRTheme sharedTheme] negativeColor];
        UIColor *neutralColour = [[PRTheme sharedTheme] neutralColor];
        UIColor *mainColour = [[PRTheme sharedTheme] mainColor];
        
        NSArray *agreeOptions = @[@{@"title":@"Strongly Disagree", @"image":cross, @"image2":cross, @"imageTint": negativeColour},
                                  @{@"title":@"Disagree", @"image":cross, @"imageTint": negativeColour},
                                  @{@"title":@"Neither Agree or Disagree", @"image":[UIImage imageNamed:@"dash"], @"imageTint": mainColour},
                                  @{@"title":@"Agree", @"image":tick, @"imageTint": positiveColour},
                                  @{@"title":@"Strongly Agree", @"image":tick, @"image2":tick, @"imageTint": positiveColour}];
        
        PRQuestionOptions *agree = [PRQuestionOptions questionWithTitle:@"I knew what the different roles of the people caring for me were"];
        agree.options = agreeOptions;
        agree.showsNA = YES;
        
        PRQuestionOptions *extent = [PRQuestionOptions questionWithTitle:@"Were you involved as much as you wanted to be in decisions about your care and treatment?"];
        extent.options = @[@{@"title":@"Yes, definitely",  @"image":tick, @"image2":tick, @"imageTint": positiveColour},
                           @{@"title":@"Yes, to some extent", @"image":tick, @"imageTint": positiveColour},
                           @{@"title":@"No", @"image":cross, @"imageTint": negativeColour}];
        
        PRQuestionStatement *statement = [PRQuestionStatement questionWithTitle:@"Other aspets of the ward made it uncomfortable for me:"];
        statement.statement = @"Please add a concern, something good or a note to articulate as appropriate:";
        
        prototype.questions = @[agree, extent, statement];
    });
    
    return prototype;
}

@end
