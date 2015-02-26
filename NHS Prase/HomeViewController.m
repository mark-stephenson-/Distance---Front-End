//
//  HomeViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "HomeViewController.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "PRRecord.h"
#import "PRRecordViewController.h"

#import "PRTrust.h"
#import "PRHospital.h"
#import "PRWard.h"

#define ALERT_GO_TITLE 111

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
#ifdef DEBUG
    self.selectedTrust = [trusts firstObject];
    self.selectedHospital = [self.selectedTrust.hospitals anyObject];
    self.selectedWard = [self.selectedHospital.wards anyObject];
#endif
    
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
        [self commitCustomWard];
        [self performSegueWithIdentifier:@"CreateRecord" sender:self];
    }
}

#pragma mark - Navigation Methods

-(void)goToLogIn:(id)sender
{
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"home.logout.title", nil, nil, @"Log Out", @"Alert title to log out of a session.");
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"home.logout.error-message", nil, nil, @"Do you want to Log out of the PRASE app?", @"Alert message shown when returning to the app's title screen") ;
    NSString *logoutTitle = TDLocalizedStringWithDefaultValue(@"home.logout.button", nil, nil, @"Log Out", @"Button title to log out.");
    NSString *continueRecordTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyCancel, nil, nil, nil, nil);
    
    void (^logoutCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 cancelTitle:continueRecordTitle
                buttonTitles:@[logoutTitle]
                     actions:@[logoutCompletion]];
}

@end
