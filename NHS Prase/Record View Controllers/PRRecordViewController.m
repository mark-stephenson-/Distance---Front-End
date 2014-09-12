//
//  PRRecordViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRRecordViewController.h"

#import "PRRecordSummaryViewController.h"
#import "PRBasicDataFormViewController.h"
#import "PRQuestionaireViewController.h"

#import "PRRecord.h"

#import "PRTheme.h"
#import "PRButton.h"
#import "PRQuestion.h"


// iOS 8 Deprecation
#define ALERT_GO_HOME 111
#define ALERT_GO_TITLE 222
#define ALERT_SUBMIT 333

@interface PRRecordViewController ()

@end

@implementation PRRecordViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    PRQuestionaireViewController *qvc = tabController.viewControllers[1];
    qvc.questions = [self.record.questions array];
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    if (isLastSection) {
        // explicitly add a string to be picked up in gen strings
        TDLocalizedStringWithDefaultValue(@"button.submit", nil, nil, @"Submit", @"Default button title to complete a task, such as adding a concern or submitting a record.");
        nextButton.TDLocalizedStringKey = @"button.submit";
        [nextButton setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        nextButton.TDLocalizedStringKey = @"button.next";
        [nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] neutralColor]];
    }
    
    [self applyThemeToView:footerView];
}

-(void)segmentChanged:(id)sender
{
    [super segmentChanged:sender];
    
    if ([tabController.selectedViewController isKindOfClass:[PRRecordSummaryViewController class]]) {
        [self configureSummary];
    }
}

-(void)refreshFooterView
{
    [super refreshFooterView];
    
    if ([tabController.selectedViewController isKindOfClass:[PRQuestionaireViewController class]]) {
        
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) tabController.selectedViewController;
        NSInteger currentQuestion = qvc.currentQuestion;
        
        progressLabel.hidden = NO;
        progressLabel.text = [NSString stringWithFormat:@"Question %ld of %ld", currentQuestion + 1, self.record.questions.count];
    } else {
        progressLabel.hidden = YES;
    }
}

-(void)configureSummary
{
    PRRecordSummaryViewController *summary = [tabController.viewControllers lastObject];
    
    PRBasicDataFormViewController *basicData = [tabController.viewControllers firstObject];

    BOOL basicDataComplete = YES;
    
    for (NSArray *section in basicData.cellInfo) {
        for (NSDictionary *qInfo in section) {
            if (qInfo[@"value"] == nil) {
                basicDataComplete = NO;
            }
        }
    }
    
    if (basicDataComplete) {
        summary.basicDataButton.backgroundColor = [[PRTheme sharedTheme] positiveColor];
        [summary.basicDataButton setTitle:@"Complete" forState:UIControlStateNormal];
        [summary.basicDataButton setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    } else {
        summary.basicDataButton.backgroundColor = [[PRTheme sharedTheme] negativeColor];
        [summary.basicDataButton setTitle:@"Incomplete" forState:UIControlStateNormal];
        [summary.basicDataButton setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    }
    
    NSInteger answered = 0;
    
    for (PRQuestion *thisQuestion in self.record.questions) {
        if (thisQuestion.answerID != nil) {
            answered++;
        }
    }
    
    NSInteger total = self.record.questions.count;
    
    summary.questionnaireLabel.text = [NSString stringWithFormat:@"%ld of %ld questions answered.", answered, total];
    summary.questionnaireLabel.textColor = (answered == total) ? [[PRTheme sharedTheme] positiveColor] : [[PRTheme sharedTheme] negativeColor];
}

#pragma mark - Navigation

/// Overrides parent's method to navigate between questions of a PRQuestionnairViewController or begin the submission process.
-(void)goNext:(id)sender
{
    UIViewController *currentVC = tabController.selectedViewController;
    
    if ([currentVC isKindOfClass:[PRQuestionaireViewController class]]) {
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) currentVC;
        
        if ([qvc canGoToNextQuestion]) {
            [qvc goToNextQuestion];
            [self refreshFooterView];
            return;
        }
    }
    
    if ([currentVC isKindOfClass:[PRRecordSummaryViewController class]]) {
        
        [self showAlertWithTitle:@"Submit Record"
                         message:@"Please ensure you have answered all the questions before submitting this record."
                     buttonTitle:@"Submit"
                buttonCompletion:^(NSNumber *buttonIndex, UIAlertAction *action) {
                    [self continueSubmit];
                } cancelTitle:@"Cancel"
                        alertTag:ALERT_SUBMIT];
        return;
    }
    
    [super goNext:sender];
}

/// Overrides parent's method to navigate between questions of a PRQuestionnairViewController
-(void)goPrevious:(id)sender
{
    UIViewController *currentVC = tabController.selectedViewController;
    
    if ([currentVC isKindOfClass:[PRQuestionaireViewController class]]) {
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) currentVC;
        
        if ([qvc canGoToPreviousQuestion]) {
            [qvc goToPreviousQuestion];
            [self refreshFooterView];
            return;
        }
    }
    
    [super goPrevious:sender];
}

-(void)goHome:(id)sender
{
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.error-title", nil, nil, @"Cancel Record", @"Alert title to cancel a record and return to the home or title screen.");
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.cancel.error-message", nil, nil, @"Returning to the title screen will delete any entered data. Are you sure you want to continue?", @"Alert message shown when returning to the app's title screen") ;
    NSString *buttonTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.button-title", nil, nil, @"Cancel Record", @"Button title to cancel a record.");
    NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.cancel-title", nil, nil, @"Continue", @"Button title to continue creating a record when prompted about cancelling a record.");
 
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 buttonTitle:buttonTitle
            buttonCompletion:^(NSNumber *buttonIndex, UIAlertAction *action) {
                [self continueHome];
            }
                 cancelTitle:cancelTitle
                    alertTag:ALERT_GO_HOME];
}

-(void)continueHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)continueSubmit
{
    [self continueHome];
}

@end
