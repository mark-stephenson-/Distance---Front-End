//
//  HomeViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "HomeViewController.h"

#import "PRRecord.h"
#import "PRRecordViewController.h"

#define ALERT_GO_TITLE 111
#define ALERT_CREATE_ERROR 222

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CreateRecord"]) {
        PRRecord *newRecord = [PRRecord newRecordWithWard:self.selectedWard];
        newRecord.startDate = [NSDate date];
        newRecord.user = [[NSUserDefaults standardUserDefaults] valueForKey:@"user"];
        
        PRRecordViewController *recordVC = (PRRecordViewController *) segue.destinationViewController;
        recordVC.record = newRecord;
    }
}

#pragma mark - Language Methods

-(void)toggleLanguage:(id)sender
{
    static BOOL isFrench = NO;
    
    [[TDTheme sharedTheme] setLanguageIdentifier:isFrench ? @"en" : @"fr"];
    isFrench = !isFrench;
}

-(void)createRecord:(id)sender
{
    // a ward can only be non-nil if the trust and hospital have been chosen
    if (true) { //self.selectedWard != nil) {
        
        [self performSegueWithIdentifier:@"CreateRecord" sender:self];
        
    } else {
        
        NSString *errorMessage = @"";
        
        if (self.selectedTrust == nil) {
            errorMessage = TDLocalizedStringWithDefaultValue(@"home.create-error.no-trust", nil, nil, @"Please select a trust.", @"The error shown in the user tries to create a new record without selecting a trust.");
        }
        
        if (self.selectedHospital == nil) {
            
            if (errorMessage.length > 0) {
                errorMessage = [errorMessage stringByAppendingString:@"\n"];
            }
            
            NSString *hospitalError = TDLocalizedStringWithDefaultValue(@"home.create-error.no-hospital", nil, nil, @"Please select a hospital.", @"The error shown in the user tries to create a new record without selecting a trust.");
            errorMessage = [errorMessage stringByAppendingString:hospitalError];
        }
        
        if (self.selectedWard == nil) {
            
            if (errorMessage.length > 0) {
                errorMessage = [errorMessage stringByAppendingString:@"\n"];
            }
            
            NSString *wardError = TDLocalizedStringWithDefaultValue(@"home.create-error.no-ward", nil, nil, @"Please select a ward.", @"The error shown in the user tries to create a new record without selecting a ward.");
            errorMessage = [errorMessage stringByAppendingString:wardError];
        }
        
        NSString *errorTitle = TDLocalizedStringWithDefaultValue(@"home.create-error.title", nil, nil, @"Cannot Create Record", @"Error title when the user cannot create a record.");
        
        [self showAlertWithTitle:errorTitle
                         message:errorMessage
                     buttonTitle:nil
                buttonCompletion:nil
                     cancelTitle:nil
                        alertTag:ALERT_CREATE_ERROR];
    }
}



#pragma mark - Navigation Methods

-(void)goToLogIn:(id)sender
{
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.error-title", nil, nil, @"Cancel Record", @"Alert title to cancel a record and return to the home or title screen.");
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.cancel.error-message", nil, nil, @"Returning to the title screen will delete any entered data. Are you sure you want to continue?", @"Alert message shown when returning to the app's title screen") ;
    NSString *buttonTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.button-title", nil, nil, @"Cancel Record", @"Button title to cancel a record.");
    NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.cancel-title", nil, nil, @"Continue", @"Button title to continue creating a record when prompted about cancelling a record.");
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 buttonTitle:buttonTitle
            buttonCompletion:^(NSNumber *buttonIndex, UIAlertAction *action) {
                [self continueTitle];
            } cancelTitle:cancelTitle
                    alertTag:ALERT_GO_TITLE];
}


// iOS 8 Deprecation
-(void)continueTitle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
