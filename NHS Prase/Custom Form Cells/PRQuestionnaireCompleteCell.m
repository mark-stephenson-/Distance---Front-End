//
//  PRButtonSelectCell.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionnaireCompleteCell.h"
#import "PRTheme.h"

@implementation PRQuestionnaireCompleteCell

-(BOOL)select
{
     return YES;
}

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSArray class]]) {
        
        NSArray *totals = (NSArray *) value;
        
        if (totals.count == 2) {
            if ([totals[0] isKindOfClass:[NSNumber class]] && [totals[1] isKindOfClass:[NSNumber class]]) {
                answered = [(NSNumber *)totals[0] intValue];
                total = [(NSNumber *)totals[1] intValue];
            }
        }
        
        [self refreshViews];
    }
}

-(id)value
{
    return @[@(answered), @(total)];
}

// configure the views based on whether all questions are answered or not.
-(void)refreshViews
{
    if (total > 0 && answered == total) {

        summaryLabel.text = TDLocalizedStringWithDefaultValue(@"summary.questionnaire-complete", nil, nil, @"Complete", @"Label shown when the user has answered all the PMOS questions.");
        
        summaryLabel.textColor = [[PRTheme sharedTheme] positiveColor];
        self.button.hidden = YES;
    } else {

        summaryLabel.text = [NSString localizedStringWithFormat:TDLocalizedStringWithDefaultValue(@"summary.questionnaire-summary", nil, nil, @"%d of %d questions answered", @"Summary of how many questions the user has answered. 1$: number of answered questions. 2$: total number of questions."), answered, total];
        
        summaryLabel.textColor = [[PRTheme sharedTheme] negativeColor];
        self.button.hidden = NO;
    }
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    [super selectionViewControllerRequestsDismissal:selectionVC];
    
    NSNumber *questionNumber = (NSNumber *) selectedKey;
    
    if (questionNumber != nil) {
        // post a notification to jump to the incomplete question.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QuestionRequest" object:nil userInfo:@{@"questionNumber": questionNumber}];
    }
}

-(void)buttonTapped:(id)sender
{
    [super select];
}

@end
