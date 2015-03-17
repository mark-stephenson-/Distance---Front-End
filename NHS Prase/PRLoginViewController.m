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
#import "PRWard.h"
#import "PRQuestion.h"
#import "PRConcern.h"
#import "PRNote.h"
#import "PRUser.h"

#define ALERT_LOGIN 111
#define ALERT_DOWNLOAD_ERROR 222

@interface PRLoginViewController ()

@end

@implementation PRLoginViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    logInCredentials = @{@"TheDistance": @"PraseTheDistance",
                         @"00001":@"nhs123",
                         @"00002":@"bradfordnhs",
                         @"00003":@"barnsleyhospital"};
    */
    
    retryWidthConstraint.priority = 999;
    
    usernameField.accessoryImage = nil;
    passwordField.accessoryImage = nil;
    
    // show the version & build number
    NSString *versionNumber = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *buildNumber = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    
    versionLabel.text = [NSString stringWithFormat:@"%@ (%@)", versionNumber, buildNumber];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.keyboardAccessoryView = nil;
    
    inputView = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    inputView.navigationDelegate = self;
    
    passwordField.text = nil;
    
    self.keyboardAccessoryView = inputView;
    
    self.components = @[usernameField, passwordField];
    
    self.scrollContainer = scrollView;
    
#ifdef DEBUG
    usernameField.text = @"thedistance";
    passwordField.text = @"password";
#endif
    
    // assume both will be successful in order to not show the download error button straight away
    submissionSucces = YES;
    dataSuccess = YES;
    [self refreshDownloadErrorButton];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self submitSavedRecordsWithCompletion:^{
        [self downloadData];
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.scrollContainer = nil;
}

-(void)handleThemeChange:(NSNotification *)note
{
    [super handleThemeChange:note];
    
    [self applyThemeToView:inputView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Methods

- (IBAction)retryPressed:(id)sender {
    
    if ([sender isKindOfClass:[UILongPressGestureRecognizer class]]) {
        UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *) sender;
        if (longPress.state != UIGestureRecognizerStateBegan) {
            return;
        }
    }
    
    [self submitSavedRecordsWithCompletion:^{
        [self downloadData];
    }];
}

-(void)clearCustomWards
{
    NSMutableArray *customWardsToRemove = [NSMutableArray arrayWithArray:[PRWard MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"id < 0"]]];
    NSArray *allRecords = [PRRecord MR_findAll];
    
    NSLog(@"testing %ld records, with %ld custom wards", (long) allRecords.count, (long) customWardsToRemove.count);
    for (PRRecord *record in allRecords) {
        
        if (customWardsToRemove.count == 0) {
            break;
        }
        
        if (record.ward.id.integerValue < 0) {
            PRWard *toKeep = record.ward;
            [customWardsToRemove removeObject:toKeep];
        }
        
        for (PRQuestion *question in record.questions) {
            if (question.goodNote.ward != nil && question.goodNote.ward.id.integerValue < 0) {
                PRWard *toKeep = question.goodNote.ward;
                [customWardsToRemove removeObject:toKeep];
            }
            
            if (question.concern.ward != nil && question.concern.ward.id.integerValue < 0) {
                PRWard *toKeep = question.concern.ward;
                [customWardsToRemove removeObject:toKeep];
            }
        }
        
        for (PRNote *goodNote in record.goodNotes) {
            if (goodNote.ward != nil && goodNote.ward.id.integerValue < 0) {
                PRWard *toKeep = goodNote.ward;
                [customWardsToRemove removeObject:toKeep];
            }
        }
        
        for (PRConcern *concern in record.concerns) {
            if (concern.ward != nil && concern.ward.id.integerValue < 0) {
                PRWard *toKeep = concern.ward;
                [customWardsToRemove removeObject:toKeep];
            }
        }
    }
    
    NSLog(@"removing %ld unused custom wards", (long) customWardsToRemove.count);
    
    for (PRWard *unusedWard in customWardsToRemove) {
        [unusedWard MR_deleteEntity];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
}

-(void)submitSavedRecordsWithCompletion:(void (^)(void)) completion
{
    // attempt to submit any records which haven't been submitted yet
    NSArray *savedRecords = [PRRecord MR_findAll];
    
    if (savedRecords.count > 0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = TDLocalizedStringWithDefaultValue(@"login.hud.submitting", nil, nil, @"Submitting...", @"The label identifying that old records is being re-submitted. Shown on the login screen.");
        
        __block NSMutableArray *allErrors = [NSMutableArray array];
        __block NSInteger submissionCount = savedRecords.count;
        __block NSInteger successCount = 0;
        __block NSInteger completedCount = 0;
        
        for (PRRecord *toSubmit in savedRecords) {
            [[PRAPIManager sharedManager] submitRecord:toSubmit withCompletion:^(BOOL success, NSError *error) {
                completedCount++;
                if (success) {
                    successCount++;
                    NSLog(@"Successfully submitted previously saved record.");
                    [toSubmit MR_deleteEntity];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
                } else {
                    [allErrors addObject:error];
                }
                
                if (completedCount == submissionCount) {
                    
                    [hud hide:YES];
                    [self clearCustomWards];
                    
                    if (successCount == submissionCount) {
                        
                        submissionSucces = YES;
                        
                        [self refreshDownloadErrorButton];
                        
                        NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.resubmit.title", nil, nil, @"Records Submitted", @"The alert title shown when previously saved records have been successfully submitted.");
                        NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.resubmit.message", nil, nil, @"Previously saved records have now been submitted. Thank you for your time.", @"The alert message shown when previously saved records have been successfully submitted.");
                        NSString *buttonTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, nil, nil);
                        void (^okCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                            if (completion != nil) {
                                completion();
                            }
                        };
                        
                        [self showAlertWithTitle:alertTitle
                                         message:alertMessage
                                     cancelTitle:nil
                                    buttonTitles:@[buttonTitle]
                                         actions:@[okCompletion]];
                    } else {
                        
                        submissionSucces = NO;
                        
                        NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"record.resubmit-error.title", nil, nil, @"Records Not Submitted", @"The alert title shown when previously saved records have not been successfully submitted.");
                        NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"record.resubmit-error.message", nil, nil, @"Previously saved records could not be submitted at this time.", @"The alert message shown when previously saved records have not been successfully submitted.");
                        NSString *cancelTitle = TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, nil, nil);
                        
                        [PRAPIManager showAlertFromViewController:self
                                                        forErrors:allErrors
                                                        withTitle:alertTitle
                                                          message:alertMessage
                                                       retryTitle:TDLocalizedStringWithDefaultValue(PRLocalisationKeyRetry, nil, nil, nil, nil)
                                                       retryBlock:^(UIAlertAction *action) {
                                                           [self submitSavedRecordsWithCompletion:completion];
                                                       } cancelTitle:cancelTitle
                                                   andCancelBlock:^(UIAlertAction *action, NSString *errorMessage) {
                                                       
                                                       [self refreshDownloadErrorButton];
                                                       
                                                       if (completion != nil) {
                                                           completion();
                                                       }
                                                       
                                                   } contactSupportTitle:nil
                                              contactSupportBlock:nil];
                    }
                }
            }];
        }
    } else {
        submissionSucces = YES;
        [self refreshDownloadErrorButton];
        [self clearCustomWards];
        
        if (completion != nil) {
            completion();
        }
    }
}

- (void)downloadData
{
    // start download operations
    NSInteger requestCount = 4;
    __block NSMutableArray *allErrors = [NSMutableArray array];
    __block BOOL allSuccess = YES;
    __block int completionCount = 0;
    
    void (^downloadCompletion)(SEL selector, BOOL success, NSArray *errors) = ^(SEL selector, BOOL success, NSArray *errors){
        [allErrors addObjectsFromArray:errors];
        allSuccess = allSuccess && success;
        
        completionCount++;
        
        if (selector == @selector(getUsersWithCompletion:)) {
            NSArray *allUsers = [PRUser MR_findAll];
            
            NSMutableDictionary *tempUsers = [NSMutableDictionary dictionaryWithCapacity:allUsers.count];
            for (PRUser *user in allUsers) {
                tempUsers[user.username] = user.password;
            }
            
            logInCredentials = [NSDictionary dictionaryWithDictionary:tempUsers];
        }
        
        if (completionCount == requestCount) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
            
            if ([allErrors count] > 0) {
                
                dataSuccess = NO;
                
                NSString *errorTitle = TDLocalizedStringWithDefaultValue(@"login.download-error.title", nil, nil, @"Cannot Download Data", @"Error title when the data download failed.");
                NSString *errorMessage = TDLocalizedStringWithDefaultValue(@"login.download-error.message", nil, nil, @"Unable to update local database.", @"Error message prefix when the data download fails.");
                NSString *buttonTitle = TDLocalizedStringWithDefaultValue(@"login.download.button-title", nil, nil, @"Retry", @"Button title to retry downloading data.");
                NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"alert.cancel-title", nil, nil, @"OK", @"The default button to dismiss an alert view.");
                
                [PRAPIManager showAlertFromViewController:self
                                                forErrors:allErrors
                                                withTitle:errorTitle
                                                  message:errorMessage
                                               retryTitle:buttonTitle
                                               retryBlock:^(UIAlertAction *action) {
                                                   [self downloadData];
                                               } cancelTitle:cancelTitle
                                           andCancelBlock:^(UIAlertAction *action, NSString *errorMessage) {
                                               [self refreshDownloadErrorButton];
                                           } contactSupportTitle:nil
                                      contactSupportBlock:nil];
            
            } else {
                dataSuccess = YES;
                [self refreshDownloadErrorButton];
            }
        }
    };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = TDLocalizedStringWithDefaultValue(@"login.hud.download", nil, nil, @"Downloading...", @"The label identifying that data is being downloaded. Shown on the login screen.");
    
    PRAPIManager *manager = [PRAPIManager sharedManager];
    [manager getTrustHierarchyWithCompletion:downloadCompletion];
    [manager getQuestionHierarchyWithCompletion:downloadCompletion];
    [manager getLocalizationsWithCompletion:downloadCompletion];
    [manager getUsersWithCompletion:downloadCompletion];
}

-(void)refreshDownloadErrorButton
{
    if (!submissionSucces || !dataSuccess) {
        // there has been an error so ignore the width == 0 constraint
        retryWidthConstraint.priority = 90;
        retryButton.alpha = 1.0;
    } else {
        // no errors so button.width == 0
        retryButton.alpha = 0.0;
        retryWidthConstraint.priority = 990;
    }
    
    if (hasAppeared) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - Log In

-(void)continueAsGuest:(id)sender
{
    [self performSegueWithIdentifier:@"Continue" sender:self];
}

-(void)login:(id)sender
{
    if ([PRWard MR_findFirst] == nil) {
        // prevent log in when no data has been synced as there will be no questions and no wards
        NSString *noDataTitle = TDLocalizedStringWithDefaultValue(@"login.nodata.title", nil, nil, @"No Data", @"Error title when the user tries to log in when there is no data on the app.");
        NSString *noDataMessage = TDLocalizedStringWithDefaultValue(@"login.nodata.message", nil, nil, @"The app has not been able to sync with the server. Please connect to the internet then tap \"Download Error\" or launch this app again.", @"Error message when the user tries to log in when there is no data on the app.");
        
        [self showAlertWithTitle:noDataTitle
                         message:noDataMessage
                     cancelTitle:nil
                    buttonTitles:nil
                         actions:nil];
        return;
    }
    
    if ([PRUser MR_findFirst] == nil) {
        // prevent log in when no credentials have been set up on the server
        NSString *noUserTitle = TDLocalizedStringWithDefaultValue(@"login.nouser.title", nil, nil, @"No Users", @"Error title when the user tries to log in but no user credentials have been synced with the app.");
        NSString *noUserMessage = TDLocalizedStringWithDefaultValue(@"login.nouser.message", nil, nil, @"No user credentials have been created on the server. Please contact your administrator to set up new credentials.", @"Error message when the user tries to log in but no user credentials have been synced with the app.");
        
        [self showAlertWithTitle:noUserTitle
                         message:noUserMessage
                     cancelTitle:nil
                    buttonTitles:nil
                         actions:nil];
        return;
    }
    
    BOOL canContinue = logInCredentials[usernameField.text] != nil && [passwordField.text isEqualToString:logInCredentials[usernameField.text]];

    if (canContinue) {
        [[NSUserDefaults standardUserDefaults] setValue:usernameField.text forKey:PRRecordUsernameKey];
        [self performSegueWithIdentifier:@"Continue" sender:self];
    } else {
        NSString *title = TDLocalizedStringWithDefaultValue(@"login.error.title", nil, nil, @"Incorrect Username or Password", @"Error title if the user enters an incorrect username or password.");
        NSString *message = TDLocalizedStringWithDefaultValue(@"login.error.message", nil, nil, @"Please enter a valid username and password.", @"Error message when the user enters an incorrect username or password.");
        
        [self showAlertWithTitle:title
                         message:message
                     cancelTitle:nil
                    buttonTitles:nil
                         actions:nil];
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
        inputView.nextButton.TDLocalizedStringKey = PRLocalisationKeyNext;
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
