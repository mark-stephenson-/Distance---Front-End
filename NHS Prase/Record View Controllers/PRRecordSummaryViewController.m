//
//  PRRecordSummaryViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRRecordSummaryViewController.h"
#import "PRQuestionnaireCompleteCell.h"
#import "PRSelectionViewController.h"

#import "PRRecord.h"
#import "PRQuestion.h"

@interface PRRecordSummaryViewController ()

@end

@implementation PRRecordSummaryViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSInteger answered = [self.record answeredQuestions];
    NSInteger total = self.record.questions.count;

    [self setFormValue:@[@(answered), @(total)]
            forFormKey:@"Questionnaire"];
}

-(NSArray *)generateCellInfo
{
    NSInteger answered = [self.record answeredQuestions];
    NSInteger total = self.record.questions.count;
    
    NSMutableDictionary *unansweredQuestions = [NSMutableDictionary dictionaryWithCapacity:total - answered];
    
    if (answered < total) {
        for (int q = 0; q < total; q++) {
            PRQuestion *thisQuestion = self.record.questions[q];
            if (![thisQuestion.answerID isNonNullString]) {
                NSString *formatHeader = [NSString localizedStringWithFormat:TDLocalizedStringWithDefaultValue(@"summary.question.summary_label", nil, nil, @"Question %d", @"The label identifiying an unanswered PMOS question on the summary screen."), q + 1];
                unansweredQuestions[@(q)] = formatHeader;
            }
        }
    }
    
    NSMutableDictionary *questionnaireCell = [PRQuestionnaireCompleteCell cellInfoWithTitle:@"Questionnaire:"
                                                                                placeholder:nil
                                                                                    options:unansweredQuestions
                                                                                    details:nil
                                                                                    inOrder:@[[unansweredQuestions.allKeys sortedArrayUsingSelector:@selector(compare:)]]
                                                                                      value:@[@(answered), @(total)]
                                                                                     andKey:@"Questionnaire"];
    questionnaireCell[@"reuseIdentifier"] = @"QuestionnaireCompleteCell";
    questionnaireCell[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    questionnaireCell[@"userInfo"][@"selectionDelegate"] = self;
    
    return @[@[questionnaireCell]];
}

-(void)selectionCell:(TDSelectCell *)cell requestsPresentationOfSelectionViewController:(TDSelectionViewController *)selectionVC
{
    if ([cell isKindOfClass:[PRQuestionnaireCompleteCell class]]) {
        
        PRSelectionViewController *prSelection = (PRSelectionViewController *) selectionVC;
        
        // force load the view to configure its subclasses
        UIView *view = prSelection.view;
        prSelection.titleLabel.text = @"Incomplete Questions";
        prSelection.subTitleLabel.text = @"Please complete as many questions as possible. Tap a question to answer to it.";
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:prSelection animated:YES completion:nil];
        }];
    }
}

@end
