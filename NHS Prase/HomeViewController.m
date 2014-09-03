//
//  HomeViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "HomeViewController.h"

#define ALERT_GO_TITLE 111

@interface HomeViewController ()

@end

@implementation HomeViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyTheme) name:TDThemeLanguageChange object:nil];
    
    [self applyTheme];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TDThemeLanguageChange object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Language Methods

-(void)toggleLanguage:(id)sender
{
    static BOOL isFrench = NO;
    
    [[TDTheme sharedTheme] setLanguageIdentifier:isFrench ? @"en" : @"fr"];
    isFrench = !isFrench;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)createRecord:(id)sender
{
    if (true) {//[self.selectedTrust isNonNullString] && [self.selectedHospital isNonNullString] && [self.selectedTrust isNonNullString]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:self.selectedTrust forKey:@"trust"];
        [[NSUserDefaults standardUserDefaults] setValue:self.selectedHospital forKey:@"hospital"];
        [[NSUserDefaults standardUserDefaults] setValue:self.selectedWard forKey:@"ward"];
        
        [self performSegueWithIdentifier:@"CreateRecord" sender:self];
        
    } else {
        
        NSString *errorMessage = @"";
        
        if (![self.selectedTrust isNonNullString]) {
            errorMessage = @"Please select a trust.\n";
        }
        
        if (![self.selectedHospital isNonNullString]) {
            
            
            errorMessage = [errorMessage stringByAppendingString:@"Please select a hospital.\n"];// TDLocalizedString(@"home.error.no-hospital", @"Error message shown when the user has not selected a hospital.");
        }
        
        if (![wardField.text isNonNullString]) {
            if (![hospitalField.text isNonNullString]) {
                //errorMessage = [errorMessage stringByAppendingString:@"\n"];
            }

            errorMessage = [errorMessage stringByAppendingString:@"Please select a ward."];//[errorMessage stringByAppendingString:TDLocalizedString(@"home.error.no-ward", @"Error message shown when the user has not selected a ward.")];
        }
        
        NSString *errorTitle = @"Cannot create record."; //TDLocalizedString(@"home.error.create-record", @"Error title when the user cannot create a record.");
        [[[UIAlertView alloc] initWithTitle:errorTitle message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}



#pragma mark - Navigation Methods

-(void)goToLogIn:(id)sender
{
    NSString *alertTitle = @"Cancel Record";
    NSString *alertMessage = @"Returning to the title screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Cancel Record";
    NSString *cancelTitle = @"Continue";
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                              [self continueTitle];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        // iOS 8 Deprecation
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:self
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:buttonTitle, nil];
        alert.tag = ALERT_GO_TITLE;
        [alert show];
    }
}

// iOS 8 Deprecation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == ALERT_GO_TITLE) {
            [self continueTitle];
        }
    }
}

// iOS 8 Deprecation
-(void)continueTitle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
