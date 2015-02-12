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

#import "PRTrust.h"
#import "PRHospital.h"

#define ALERT_GO_TITLE 111

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.selectedTrust = [trusts firstObject];
    self.selectedHospital = [self.selectedTrust.hospitals anyObject];
    self.selectedWard = [self.selectedHospital.wards anyObject];
    
    [self refreshViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CreateRecord"]) {
        PRRecord *newRecord = [PRRecord newRecordWithWard:self.selectedWard];
        newRecord.startDate = [NSDate date];
        newRecord.user = [[NSUserDefaults standardUserDefaults] valueForKey:PRRecordUsernameKey];
        
        PRRecordViewController *recordVC = (PRRecordViewController *) segue.destinationViewController;
        recordVC.record = newRecord;
    }
}

-(void)createRecord:(id)sender
{
    // a ward can only be non-nil if the trust and hospital have been chosen
    BOOL canCreate = [self validateSelectedWard];

    canCreate = true;

    if (canCreate) {
        [self performSegueWithIdentifier:@"CreateRecord" sender:self];
    }
}

#pragma mark - Navigation Methods

-(void)goToLogIn:(id)sender
{
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.error-title", nil, nil, @"Cancel Record", @"Alert title to cancel a record and return to the home or title screen.");
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.cancel.error-message", nil, nil, @"Returning to the title screen will delete any entered data. Are you sure you want to continue?", @"Alert message shown when returning to the app's title screen") ;
    NSString *cancelRecordTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.button-title", nil, nil, @"Cancel Record", @"Button title to cancel a record.");
    NSString *continueRecordTitle = TDLocalizedStringWithDefaultValue(@"record.cancel.cancel-title", nil, nil, @"Continue Record", @"Button title to continue creating a record when prompted about cancelling a record.");
    
    void (^cancelRecordCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 cancelTitle:continueRecordTitle
                buttonTitles:@[cancelRecordTitle]
                     actions:@[cancelRecordCompletion]];
}

@end
