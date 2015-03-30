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
#import "PRCommentsSummaryViewController.h"
#import "PRDateSelectCell.h"

#import "PRRecord.h"
#import "PRWard.h"

#import "PRTheme.h"
#import "PRQuestion.h"


#import "PRAPIManager.h"

#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "MBProgressHUD.h"

@interface PRRecordViewController ()

@end

@implementation PRRecordViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    segmentTitles = @[@"Basic Data", @"Questionnaire", @"Comments", @"Summary"];
    
    PRQuestionaireViewController *qvc = tabController.viewControllers[1];
    qvc.questions = [self.record.questions array];
    
    PRCommentsSummaryViewController *commentsVC = [tabController.viewControllers objectAtIndex:tabController.viewControllers.count - 2];
    commentsVC.record = self.record;
    
    PRRecordSummaryViewController *summary = [tabController.viewControllers lastObject];
    summary.record = self.record;
    
    // Configure for time tracking. Do this on viewDidLoad as unloading will only occur when this view is popped, i.e. when the record is cancelled.
    trackingDate = self.record.startDate;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleQuestionRequest:) name:@"QuestionRequest" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleBasicDataRequest:) name:@"BasicDataRequest" object:nil];
    
    // listen for foreground / background notifications to save the time variables
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetTracking) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commitTracking) name:UIApplicationWillResignActiveNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setNeedsLayout];
}

-(void)resetTracking
{
    // reset the tracking from date
    trackingDate = [NSDate date];
    NSLog(@"reset tracking from time to %@", trackingDate);
}

-(void)commitTracking
{
    // append the tracked time for this stint and assign to the record
    NSDate *now = [NSDate date];
    NSTimeInterval tracked = [now timeIntervalSinceDate:trackingDate];
    self.record.timeTracked = @(self.record.timeTracked.floatValue + tracked);
    NSLog(@"Appended %f for a total time of %d", tracked, self.record.timeTracked.intValue);
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QuestionRequest" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BasicDataRequest" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PresentSettings"]) {
        [containerView layoutSubviews];
    } else if ([segue.identifier isEqualToString:@"ShowIncomplete"]) {
        PRIncompleteViewController *incompleteVC = (PRIncompleteViewController *) segue.destinationViewController;
        
        incompleteVC.delegate = self;
        incompleteVC.title = TDLocalizedStringWithDefaultValue(@"incomplete.title", nil, nil, @"Questionnaire Incomplete", @"Title for the modal screen prompting the user for a reason why the questionnaire has not been completed.");
        incompleteVC.subtitle = TDLocalizedStringWithDefaultValue(@"incomplete.message", nil, nil, @"Please provide a brief explanation for why this questionnaire could not be completed.", @"Subtitle for the modal screen prompting the user for a reason why the questionnaire has not been completed.");
    }
}

-(void)handleQuestionRequest:(NSNotification *) note
{
    NSNumber *questionNumber = note.userInfo[@"questionNumber"];
    
    if (questionNumber != nil) {
        
        PRQuestionaireViewController *qvc = tabController.viewControllers[1];
        if ([qvc isKindOfClass:[PRQuestionaireViewController class]]) {
            [qvc setCurrentQuestion:questionNumber.integerValue];
        }
        [self selectSegment:1];
//        [visibleSelector setSelectedSegmentIndex:1];
//        [self segmentChanged:self];
    }
}

-(void)handleBasicDataRequest:(NSNotification *) note
{
    [self selectSegment:0];
//    [visibleSelector setSelectedSegmentIndex:0];
//    [self segmentChanged:self];
}

-(void)setRecord:(PRRecord *)record
{
    _record = record;
    
    PRRecordSummaryViewController *summary = [tabController.viewControllers lastObject];
    if ([summary isKindOfClass:[PRRecordSummaryViewController class]]) {
        summary.record = self.record;
    }
}

-(void)selectSegment:(NSInteger)segment
{
    NSUInteger oldSegment = tabController.selectedIndex;
    
    if (oldSegment == 0) {
        // set the basic data of the record based on the entered cell info before changing view controllers as the summary screen is configured in viewWillAppear, and the data model needs to be complete before that is called
        [self.view endEditing:YES];
        
        NSMutableDictionary *enteredBasicData = [NSMutableDictionary dictionaryWithCapacity:7];
        
        PRBasicDataFormViewController *bdVC = [tabController.viewControllers firstObject];
        NSArray *infoDictionaries = bdVC.cellInfo[0]; // get the info in the first section
        
        for (int i = 0; i < infoDictionaries.count; i++) {
            NSDictionary *cellInfo = infoDictionaries[i];
            id value = cellInfo[@"value"];
            id key = cellInfo[@"key"];
            
            if (value != nil && key != nil) {
                
                if ([key isEqualToString:@"Age"] && [value isKindOfClass:[NSString class]]) {
                    enteredBasicData[key] = @([(NSString *)value integerValue]);
                } else {
                    enteredBasicData[key] = value;
                }
            }
        }
        
        BOOL invalidDateEntered = NO;
        NSIndexPath *invalidDatePath = nil;
        
        for (NSDictionary *info in infoDictionaries) {
            NSString *className = NSStringFromClass(info[@"class"]);
            if ([className isEqualToString:@"PRDateSelectCell"]) {
                if ([info[@"value"] isKindOfClass:[NSArray class]]) {
                    invalidDateEntered = YES;
                    invalidDatePath = [bdVC indexPathForFormKey:info[@"key"]];
                    break;
                }
            }
        }
        
        if (invalidDateEntered) {
            [bdVC.tableView scrollToRowAtIndexPath:invalidDatePath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"invalid_date.title", nil, nil, @"Invalid Date", @"Error title when the user has entered an invalid date and tries to move forwards.");
            NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"invalid_date.message", nil, nil, @"Please enter a valid date or leave it blank.", @"Error message when the user has entered an invalid date and tries to move forwards.");
            
            [self showAlertWithTitle:alertTitle
                             message:alertMessage
                         cancelTitle:nil
                        buttonTitles:nil
                             actions:nil];
             return;
        }
        
        // check the age is valid
        if ([enteredBasicData[@"Age"] integerValue] > 120) {
            [bdVC.tableView scrollToRowAtIndexPath:invalidDatePath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"invalid_age.title", nil, nil, @"Your Age", @"Error title when the user has entered an invalid age and tries to move forwards.");
            NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"invalid_age.message", nil, nil, @"Please enter your age (up to 120) or leave it blank.", @"Error message when the user has entered an invalid age and tries to move forwards.");
            
            [self showAlertWithTitle:alertTitle
                             message:alertMessage
                         cancelTitle:nil
                        buttonTitles:nil
                             actions:nil];
            
            return;
        }
        
        self.record.basicData = [NSDictionary dictionaryWithDictionary:enteredBasicData];
    }
    
    if (segment == tabController.viewControllers.count - 1) {
        // commit the tracked time to the record so it can be loaded by the summary view controller. The tracking is paused on the summary screen to prevent confusion
        [self commitTracking];
    }
    
    if (oldSegment == tabController.viewControllers.count - 1 && segment != oldSegment) {
        // unpause the tracking when navigating away from the summary
        [self resetTracking];
    }
    
    [super selectSegment:segment];
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    if (isLastSection) {
        
        nextButton.TDLocalizedStringKey = PRLocalisationKeySubmit;
        [nextButton setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        nextButton.TDLocalizedStringKey = PRLocalisationKeyNext;
        [nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] neutralColor]];
    }
    
    [self applyThemeToView:footerView];
}

-(void)refreshFooterView
{
    [super refreshFooterView];
    
    BOOL footerShows = NO;
    
    if ([tabController.selectedViewController isKindOfClass:[PRQuestionaireViewController class]]) {
        
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) tabController.selectedViewController;
        NSInteger currentQuestion = qvc.currentQuestion;
        
        if (currentQuestion + 1 > 0) {
            footerShows = YES;
            
            progressLabel.text = [NSString stringWithFormat:@"Question %ld of %lu", currentQuestion + 1, (unsigned long)self.record.questions.count];
            progressView.progress = 1.0 * (currentQuestion + 1.0) / self.record.questions.count;
        }
    }
    
    progressFooter.hidden = !footerShows;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // force layout the footer view to ensure the difference between the buttons is caluclated correctly.
    [footerView layoutSubviews];
    
    CGSize progressSize = [progressFooter systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    CGFloat xDelta = CGRectGetMinX(prevButton.frame) - CGRectGetMaxX(settingsButton.frame);
    
    if (xDelta > progressSize.width && progressFooter.superview != footerView) {
        [progressFooter removeFromSuperview];
        
        [footerView addSubview:progressFooter];
        [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[settings][progress][previous]"
                                                                           options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                           metrics:nil
                                                                             views:@{@"settings":settingsButton,
                                                                                     @"progress":progressFooter,
                                                                                     @"previous":prevButton}]];
        
    } else if (xDelta < progressSize.width && progressFooter.superview == footerView) {
        [progressFooter removeFromSuperview];
        
        // storyboard constraints should be configured such that the container tries to be 20 away from the foot with a lower priority than the vertical content compression priority of the progress view. That way, when the progress footer is between container and the footer the gap will be 20, when it is in the way, the 20 spacing constraint will be ignored.
        [self.view addSubview:progressFooter];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container]-(20)-[progress]-(20)-[footer]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"container":containerView,
                                                                                    @"progress":progressFooter,
                                                                                    @"footer":footerView}]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressFooter
                                                              attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeLeading
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressFooter
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeTrailing
                                                             multiplier:1.0
                                                               constant:0.0]];
    }
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
        
        // check the number of questions and update the value if necessry
        NSInteger answered = [self.record answeredQuestions];
        NSInteger total = self.record.questions.count;
    
        NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"submit.alert.unanswered-title", nil, nil, @"Submit Record", @"The alert title shown when the user attempts to submit a record with incomplete data.");
        NSString *submitTitle = TDLocalizedStringWithDefaultValue(@"submit.alert.unanswered-submit", nil, nil, @"Submit Anyway", @"The alert button for continuing with submission even if questions are unanswered.");
        NSString *cancelTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyCancel, nil, nil, nil, nil);
        
        void (^submitCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
            [self performSegueWithIdentifier:@"ShowIncomplete" sender:nil];
        };
        
        NSString *alertMessage = nil;
        
        if (answered != total) {
            alertMessage = TDLocalizedStringWithDefaultValue(@"submit.alert.unanswered-message", nil, nil, @"This questionnaire has been partially completed. Please review questions missed and complete as much as you can.", @"The alert message shown when the user attempts to submit a record with incomplete data.");
        } else {
            alertMessage = TDLocalizedStringWithDefaultValue(@"submit.alert.answered-message", nil, nil, @"Thank you for completing this questionnaire. Once this questionnaire has been submitted it can no longer be editted.", @"The alert message shown when the user attempts to submit a record with complete data.");
        }
        
        [self showAlertWithTitle:alertTitle
                         message:alertMessage
                     cancelTitle:cancelTitle
                    buttonTitles:@[submitTitle] actions:@[submitCompletion]];
        
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
    
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.cancel.error-message", nil, nil, @"Returning to the home screen will cancel this record and any questions answered or data entered will not be saved. Are you sure you want to cancel this record and return to the home screen?", @"Alert message shown when returning to the app's title screen") ;
    NSString *buttonTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.button-title", nil, nil, @"Go Home", @"Button title to cancel a record and return to the home screen.");
    NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.cancel-title", nil, nil, @"Continue with Record", @"Button title to continue creating a record when prompted about cancelling a record.");
    
    void (^homeCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        [self.record MR_deleteEntity];
        [self continueHome];
    };
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 cancelTitle:cancelTitle
                buttonTitles:@[buttonTitle]
                     actions:@[homeCompletion]];
}

-(void)continueHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)continueSubmit
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = TDLocalizedStringWithDefaultValue(@"record.hud.submit", nil, nil, @"Submitting...", @"The label identifying that record is being submitted. Shown on the record screen.");
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [hud show:YES];
    }];
    
    [[PRAPIManager sharedManager] submitRecord:self.record
                                withCompletion:^(BOOL success, NSError *error) {
                                    
                                    [hud hide:YES];
                                    
                                    if (success) {
                                        
                                        // clear the un-needed entities from CoreData
                                        [self.record MR_deleteEntity];
                                        self.record = nil;
                                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
                                        
                                        NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.submission-complete.title", nil, nil, @"Questionnaire Submitted", @"Title for alert when the record has been successfully submitted.");
                                        NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.submission-complete.message", nil, nil, @"Questionnaire submitted, thank you for your time.", @"Message for alert when the record has been successfully submitted.");
                                        NSString *buttonTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, nil, nil);
                                        
                                        void (^buttonCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                                            [self continueHome];
                                        };
                                        
                                        [self showAlertWithTitle:alertTitle
                                                         message:alertMessage
                                                     cancelTitle:nil
                                                    buttonTitles:@[buttonTitle]
                                                         actions:@[buttonCompletion]];
                                    } else {
                                        [self logErrorFromSelector:_cmd withFormat:@"Unable to submit record: %@", error];
                                        
                                        NSString *errorTitle = TDLocalizedStringWithDefaultValue(@"record.submit-error.title", nil, nil, @"Cannot Submit Record", @"Error title when the record submit failed.");
                                        NSString *errorMessage = TDLocalizedStringWithDefaultValue(@"record.submit-error.message", nil, nil, @"The record could not be saved, either retry now, or the record will be automatically saved and retried when possible.", @"Error message when the record submit failed.");
                                        
                                        NSString *retryTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyRetry, nil, nil, nil, nil);
                                        NSString *laterTitle = TDLocalizedStringWithDefaultValue(@"record.submit-error.later", nil, nil, @"Later", @"Button title to save a record for later as an error occured trying to submit the data.");
                                        
                                        [PRAPIManager showAlertFromViewController:self
                                                                        forErrors:@[error]
                                                                        withTitle:errorTitle
                                                                          message:errorMessage
                                                                       retryTitle:retryTitle
                                                                       retryBlock:^(UIAlertAction *action) {
                                                                           [self continueSubmit];
                                                                       }
                                                                      cancelTitle:laterTitle
                                                                   andCancelBlock:^(UIAlertAction *action, NSString *errorMessage) {
                                                                       [self submitLater];
                                                                   }
                                                              contactSupportTitle:nil
                                                              contactSupportBlock:nil];
                                    }
                                }];
}

-(void)submitLater
{
    MBProgressHUD *savingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    savingHUD.labelText = TDLocalizedStringWithDefaultValue(@"record.hud.saving", nil, nil, @"Saving", @"HUD title shown whilst a record is being saved to disk if it cannot be submitted to the server.");
    
    // saving the context will commit this record to disk. This will be re-uploaded again on the login screen
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        
        [savingHUD hide:YES];
        
        if (error != nil) {
            NSString *saveErrorTitle = TDLocalizedStringWithDefaultValue(@"record.save.title", nil, nil, @"Save Error", @"Alert title shown when a record could not be saved to disk.");
            NSString *saveErrorMessage = TDLocalizedStringWithDefaultValue(@"record.save.message", nil, nil, @"Unable to save this questionnaire", @"Alert message shown when a record could not be saved to disk.");
            NSString *retryTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyRetry, nil, nil, nil, nil);
            NSString *cancelTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyCancel, nil, nil, nil, nil);
            
            void (^retryCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                [self submitLater];
            };
            
            void (^cancelCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                
            };
            
            [self showAlertWithTitle:saveErrorTitle
                             message:[NSString stringWithFormat:@"%@\n%@", saveErrorMessage, error.localizedDescription]
                         cancelTitle:nil
                        buttonTitles:@[retryTitle, cancelTitle]
                             actions:@[retryCompletion, cancelCompletion]];
        } else {
            NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.submission-later.title", nil, nil, @"Questionnaire Saved", @"Title for alert when the record has been successfully submitted.");
            NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.submission-later.message", nil, nil, @"Questionnaire has been saved and will be automatically submitted when a network connection becomes available. Thank you for your time.", @"Message for alert when the record has been successfully submitted.");
            NSString *buttonTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, nil, nil);
            
            void (^buttonCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                [self continueHome];
            };
            
            [self showAlertWithTitle:alertTitle
                             message:alertMessage
                         cancelTitle:nil
                        buttonTitles:@[buttonTitle]
                             actions:@[buttonCompletion]];
        }
    }];
}

#pragma mark - Incomplete Delegate

-(void)incompleteViewControllerDidCancel:(PRIncompleteViewController *)incompleteViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)incompleteViewController:(PRIncompleteViewController *)incompleteViewController completedWithText:(NSString *)text
{
    self.record.incompleteReason = text;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self continueSubmit];
    }];
}

@end
