//
//  ViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRLoginViewController.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <TheDistanceKit/TheDistanceKit_API.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "PRTheme.h"
#import "PRAPIManager.h"

#import "AppDelegate.h"
#import "PRRecord.h"

#define ALERT_LOGIN 111
#define ALERT_DOWNLOAD_ERROR 222

@interface PRLoginViewController ()

@end

@implementation PRLoginViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    logInCredentials = @{@"00001":@"nhs123",
                         @"00002":@"bradfordnhs",
                         @"00003":@"barnsleyhospital"};
    
    retryWidthConstraint.priority = 999;
    
    usernameField.accessoryImage = nil;
    passwordField.accessoryImage = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)retryPressed:(id)sender {
    [self downloadData];
}

- (void)downloadData
{
    __block NSMutableArray *allErrors = [NSMutableArray array];
    __block BOOL allSuccess = YES;
    __block int completionCount = 0;
    
    NSMutableArray *savedRecords = [[NSUserDefaults standardUserDefaults] valueForKey:@"savedRecords"];
    if (savedRecords == nil) {
        savedRecords = [NSMutableArray array];
    }
    
    for (PRRecord *toSubmit in savedRecords) {
        [[PRAPIManager sharedManager] submitRecord:toSubmit withCompletion:^(BOOL success, NSError *error) {
            if (success) {
                [toSubmit MR_deleteEntity];
            }
        }];
    }
    
    // start download operations
    void (^downloadCompletion)(SEL selector, BOOL success, NSArray *errors) = ^(SEL selector, BOOL success, NSArray *errors){
        [allErrors addObjectsFromArray:errors];
        allSuccess = allSuccess && success;
        
        completionCount++;
        
        if (completionCount == 3) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
            
            NSMutableString *errorMessage = [NSMutableString stringWithFormat:@""];
            
            if ([allErrors count] > 0) {
                NSMutableArray *errorCodes = [NSMutableArray array];
                for (NSError *error in allErrors) {
                    if (![errorCodes containsObject:@(error.code)]) {
                        [errorCodes addObject:@(error.code)];
                        
                        NSMutableString *thisErrorString = [NSMutableString stringWithFormat:@""];
                        
                        if ([[error localizedDescription] isNonNullString]) {
                            [thisErrorString appendFormat:@"%@", [error localizedDescription]];
                        }
                        
                        if ([[error localizedFailureReason] isNonNullString]) {
                            
                            if (thisErrorString.length > 0) {
                                [thisErrorString appendString:@"\n"];
                            }
                            
                            [thisErrorString appendString:error.localizedFailureReason];
                        }
                        
                        if (errorMessage.length > 0) {
                            
                            [errorMessage appendFormat:@", %@", thisErrorString];
                            
                        } else {
                            [errorMessage appendString:thisErrorString];
                        }
                    }
                }
                
                NSString *errorTitle = TDLocalizedStringWithDefaultValue(@"login.download-error.title", nil, nil, @"Cannot Download Data", @"Error title when the data download failed.");
                NSString *buttonTitle = TDLocalizedStringWithDefaultValue(@"login.download.button-title", nil, nil, @"Retry", @"Button title to retry downloading data.");
                NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"alert.cancel-title", nil, nil, @"OK", @"The default button to dismiss an alert view.");
                
                
                // We need a cancel completion handler so the superclass method isn't called here
                if ([UIAlertController class]) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:errorTitle
                                                                                             message:errorMessage
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                                        style:UIAlertActionStyleDestructive
                                                                      handler:^(UIAlertAction *action) {
                                                                          [self downloadData];
                                                                      }]];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                                        style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction *action) {
                                                                          retryWidthConstraint.priority = 1;
                                                                          [UIView animateWithDuration:0.2 animations:^{
                                                                              [self.view layoutIfNeeded];
                                                                          }];
                                                                      }]];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                } else {
                    // iOS 8 Deprecation
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorTitle
                                                                    message:errorMessage
                                                                   delegate:self
                                                          cancelButtonTitle:cancelTitle
                                                          otherButtonTitles:buttonTitle, nil];
                    alert.tag = ALERT_DOWNLOAD_ERROR;
                    [alert show];
                }

            } else {
                retryWidthConstraint.priority = 999;
                [UIView animateWithDuration:0.2 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
        }
    };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = TDLocalizedStringWithDefaultValue(@"login.hud.download", nil, nil, @"Downloading...", @"The label identifying that data is being downloaded. Shown on the login screen.");
    
    PRAPIManager *manager = [PRAPIManager sharedManager];
    [manager getTrustHierarchyWithCompletion:downloadCompletion];
    [manager getQuestionHierarchyWithCompletion:downloadCompletion];
    [manager getLocalizationsWithCompletion:downloadCompletion];
}

// iOS 8 Deprecation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_DOWNLOAD_ERROR) {
        if (buttonIndex == 1) {
            [self downloadData];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_DOWNLOAD_ERROR && buttonIndex == 0) {
        retryWidthConstraint.priority = 1;
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.keyboardAccessoryView = nil;
    
    inputView = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    inputView.navigationDelegate = self;
    [self applyThemeToView:inputView];
    
    passwordField.text = nil;
    
    self.keyboardAccessoryView = inputView;
    
    self.components = @[usernameField, passwordField];

    self.scrollContainer = scrollView;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self downloadData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.scrollContainer = nil;
}

-(void)applyTheme
{
    [super applyTheme];
    
    [self applyThemeToView:inputView];
}

#pragma mark - Log In

-(void)continueAsGuest:(id)sender
{
    [self performSegueWithIdentifier:@"Continue" sender:self];
}

-(void)login:(id)sender
{
    BOOL canContinue = logInCredentials[usernameField.text] != nil && [passwordField.text isEqualToString:logInCredentials[usernameField.text]];

//    canContinue = true;

    if (canContinue) {
        [[NSUserDefaults standardUserDefaults] setValue:usernameField.text forKey:@"user"];
        [self performSegueWithIdentifier:@"Continue" sender:self];
    } else {
        NSString *title = TDLocalizedStringWithDefaultValue(@"login.error.title", nil, nil, @"Invalid Credentials", @"Error title if the user enters an incorrect username or password.");
        NSString *message = TDLocalizedStringWithDefaultValue(@"login.error.message", nil, nil, @"Please enter a valid username and password.", @"Error message when the user enters an incorrect username or password.");
        
        [self showAlertWithTitle:title
                         message:message
                     buttonTitle:nil
                buttonCompletion:nil
                     cancelTitle:nil
                        alertTag:ALERT_LOGIN];
    }
}

#pragma mark - Input Accessory Delegate Methods

// configuring the active field or its accessory should be done on didBegin to ensure tapping to swap fields maintains the correct activeComponent.
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
    
    if (self.activeComponent == passwordField) {
        inputView.nextButton.TDLocalizedStringKey = @"button.done";
        inputView.nextButton.backgroundColor = [[PRTheme sharedTheme] positiveColor];
        [inputView.nextButton setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    } else {
        inputView.nextButton.TDLocalizedStringKey = @"button.next";
        [inputView.nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        inputView.nextButton.backgroundColor = [[PRTheme sharedTheme] neutralColor];
    }
    
    [self applyThemeToView:inputView];
}


-(BOOL)inputAccessoryCanGoToNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    return YES;
}

-(void)inputAccessoryRequestsNext:(PRInputAccessoryView *)inputAccessoryView
{
    if (self.activeComponent == passwordField) {
        [self dismissKeyboard];
    } else {
        [super inputAccessoryRequestsNext:(PRInputAccessoryView *)inputAccessoryView];
    }
    
    return;
}

@end
