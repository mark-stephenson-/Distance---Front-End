//
//  PRRecordSummaryViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRRecordSummaryViewController.h"
#import "PRSelectionViewController.h"

#import "PRQuestionnaireCompleteCell.h"
#import "PRBasicDataCompleteCell.h"
#import "PRTimeSelectCell.h"

#import "PRRecord.h"
#import "PRQuestion.h"

@interface PRRecordSummaryViewController ()

@end

@implementation PRRecordSummaryViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // check the number of questions and update the value if necessry
    NSInteger answered = [self.record answeredQuestions];
    NSInteger total = self.record.questions.count;
    
    [self setFormValue:@[@(answered), @(total)]
            forFormKey:@"Questionnaire"];
    
    // check if basic data is complete and update the value if necessary
    NSDictionary *basicDataInfo = self.record.basicDataDictionary;
    BOOL basicDataComplete = basicDataInfo.count == 7 && ![basicDataInfo.allValues containsObject:[NSNull null]];
    
    [self setFormValue:@(basicDataComplete) forFormKey:@"BasicData"];
    
    NSTimeInterval totalPatient = self.record.timeTracked.doubleValue + self.record.timeAdditionalPatient.doubleValue;
    NSTimeInterval totalQuestionnaire = self.record.timeTracked.doubleValue + self.record.timeAdditionalQuestionnaire.doubleValue;
    [self setFormValue:@(totalPatient) forFormKey:@"PatientTime"];
    [self setFormValue:@(totalQuestionnaire) forFormKey:@"QuestionnaireTime"];
    
    // re-generate the cells so the Questionnaire incomplete selectionvc has the correct list
    [self reloadForm];
}

-(NSArray *)generateCellInfo
{
    // Generate the basic data cell
    
    NSDictionary *basicDataInfo = self.record.basicDataDictionary;
    BOOL basicDataComplete = basicDataInfo.count == 7;
    
    NSMutableDictionary *basicDataCell = [PRBasicDataCompleteCell cellInfoWithTitle:TDLocalizedStringWithDefaultValue(@"summary.question.basic-data-label", nil, nil, @"Basic Data:", @"The label identifiying that the basic has not been completed. Shown on the summary screen.")
                                                                        buttonTitle:TDLocalizedStringWithDefaultValue(@"summary.question.basic-data-button", nil, nil, @"Complete Basic Data", @"The button title allowing the user to jump to the basic data screen. Shown on the summary screen.")
                                                                        buttonImage:nil
                                                                             target:self
                                                                           selector:@selector(goToBasicData:)
                                                                              value:@(basicDataComplete)
                                                                             andKey:@"BasicData"];
    
    basicDataCell[@"reuseIdentifier"] = @"BasicDataCell";

    // Generate the questionnaire cell
    NSInteger answered = [self.record answeredQuestions];
    NSInteger total = self.record.questions.count;
    
    NSMutableDictionary *unansweredQuestions = [NSMutableDictionary dictionaryWithCapacity:total - answered];
    
    if (answered < total) {
        for (int q = 0; q < total; q++) {
            PRQuestion *thisQuestion = self.record.questions[q];
            if (thisQuestion.answerID == nil || [thisQuestion.answerID isKindOfClass:[NSNull class]]) {
                NSString *formatHeader = [NSString localizedStringWithFormat:TDLocalizedStringWithDefaultValue(@"summary.question.summary-label", nil, nil, @"Question %d", @"The label identifiying the number of unanswered PMOS question. Shown on the summary screen."), q + 1];
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
    
    // generate the time cells
    
    NSMutableDictionary *patientTimeCell = [PRTimeSelectCell cellInfoWithTitle:TDLocalizedStringWithDefaultValue(@"summary.question.patient-time-label", nil, nil, @"Time spent with Patient", @"Title label for how long the volunteer has spent with the patient.")
                                                                         value:self.record.timeTracked
                                                                        andKey:@"PatientTime"];
    patientTimeCell[@"reuseIdentifier"] = @"TimeSelectCell";
    
    NSMutableDictionary *questionnaireTimeCell = [PRTimeSelectCell cellInfoWithTitle:TDLocalizedStringWithDefaultValue(@"summary.question.questionnaire-time-label", nil, nil, @"Time spent on Questionnaire", @"Title label for how long the volunteer has spent completing the questionnaire.")
                                                                               value:self.record.timeTracked
                                                                              andKey:@"QuestionnaireTime"];
    questionnaireTimeCell[@"reuseIdentifier"] = @"TimeSelectCell";
    
    
    return @[@[basicDataCell, questionnaireCell, patientTimeCell, questionnaireTimeCell]];
}

-(void)selectionCell:(TDSelectCell *)cell requestsPresentationOfSelectionViewController:(TDSelectionViewController *)selectionVC
{
    if ([cell isKindOfClass:[PRQuestionnaireCompleteCell class]]) {
        
        PRSelectionViewController *prSelection = (PRSelectionViewController *) selectionVC;
        [prSelection setSelectedKeys:[NSMutableSet set]];
        
        // force load the view to configure its subclasses
        UIView *view = prSelection.view;
        prSelection.titleLabel.text = @"Incomplete Questions";
        prSelection.subTitleLabel.text = @"Please complete as many questions as possible. Tap a question to answer to it.";
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:prSelection animated:YES completion:nil];
        }];
    }
}

-(void)goToBasicData:(id) sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BasicDataRequest" object:nil];
}

-(void)cellValueChanged:(TDCell *)cell
{
    if ([cell.key isEqualToString:@"PatientTime"]) {
        NSTimeInterval difference = ((NSNumber *)cell.value).doubleValue - self.record.timeTracked.doubleValue;
        self.record.timeAdditionalPatient = @(difference);
    }
    
    if ([cell.key isEqualToString:@"QuestionnaireTime"]) {
        NSTimeInterval difference = ((NSNumber *)cell.value).doubleValue - self.record.timeTracked.doubleValue;
        self.record.timeAdditionalQuestionnaire = @(difference);
    }
    
    [super cellValueChanged:cell];
}

@end
