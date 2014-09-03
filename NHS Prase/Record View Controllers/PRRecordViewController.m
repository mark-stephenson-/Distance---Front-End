//
//  PRRecordViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRRecordViewController.h"

#import "PRBasicDataFormViewController.h"
#import "PRQuestionaireViewController.h"
#import "PRTheme.h"

// iOS 8 Deprecation
#define ALERT_GO_HOME 111
#define ALERT_GO_TITLE 222

@interface PRRecordViewController ()

@end

@implementation PRRecordViewController

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    if (isLastSection) {
        [nextButton setTitle:@"Submit" forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] neutralColor]];
    }
}

#pragma mark - Navigation


-(void)goNext:(id)sender
{
    UIViewController *currentVC = tabController.selectedViewController;
    
    if ([currentVC isKindOfClass:[PRQuestionaireViewController class]]) {
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) currentVC;
        
        if ([qvc canGoToNextQuestion]) {
            [qvc goToNextQuestion];
            return;
        }
    }
    
    [super goNext:sender];
}

-(void)goPrevious:(id)sender
{
    UIViewController *currentVC = tabController.selectedViewController;
    
    if ([currentVC isKindOfClass:[PRQuestionaireViewController class]]) {
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) currentVC;
        
        if ([qvc canGoToPreviousQuestion]) {
            [qvc goToPreviousQuestion];
            return;
        }
    }
    
    [super goPrevious:sender];
}

-(void)goHome:(id)sender
{
    NSString *alertTitle = @"Go Home";
    NSString *alertMessage = @"Returning to the ward select screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Go Home";
    NSString *cancelTitle = @"Cancel";
 
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 buttonTitle:buttonTitle
            buttonCompletion:^{
                [self continueHome];
            }
                 cancelTitle:cancelTitle
                    alertTag:ALERT_GO_HOME];
}

-(void)goToTitle:(id)sender
{
    NSString *alertTitle = @"Cancel Record";
    NSString *alertMessage = @"Returning to the title screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Cancel Record";
    NSString *cancelTitle = @"Continue";
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 buttonTitle:buttonTitle
            buttonCompletion:^{
                [self continueHome];
            }
                 cancelTitle:cancelTitle
                    alertTag:ALERT_GO_TITLE];
}

// iOS 8 Deprecation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == ALERT_GO_HOME) {
            [self continueHome];
        }
        
        if (alertView.tag == ALERT_GO_TITLE) {
            [self continueTitle];
        }
    }
}

-(void)continueHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)continueTitle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
