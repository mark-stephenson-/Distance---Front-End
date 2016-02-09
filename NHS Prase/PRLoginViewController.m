//
//  ViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRLoginViewController.h"

#import <MagicalRecord/MagicalRecord.h>
#import <TheDistanceKit/TheDistanceKit_API.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "PRTheme.h"
#import "PRAPIManager.h"

#import "AppDelegate.h"

#import "PRAnswerOption.h"
#import "PRConcern.h"
#import "PRNote.h"
#import "PRQuestion.h"
#import "PRRecord.h"
#import "PRWard.h"
#import "PRHospital.h"
#import "PRTrust.h"
#import "PRUser.h"
#import "PRAnswerSet.h"
#import "PRPMOS.h"
#import "PRPMOSQuestion.h"

#import "PRSelectionViewController.h"
#import "PRWardSelectViewController.h"

#define ALERT_LOGIN 111
#define ALERT_DOWNLOAD_ERROR 222

@interface PRLoginViewController ()

@end

@implementation PRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:PRRecordUsernameKey];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.keyboardAccessoryView = nil;
    
    inputView = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    inputView.navigationDelegate = self;
    
    passwordField.text = nil;
    
    self.keyboardAccessoryView = inputView;
    
    self.components = @[usernameField, passwordField];
    
    self.scrollContainer = scrollView;
    
#ifdef DEBUG
    usernameField.text = @"training";
    passwordField.text = @"trainingtest";
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

#pragma mark - Server Selection

-(IBAction)selectServer:(id)sender
{
#if defined(DEBUG) || defined(BETA_TESTING)
    
    PRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PRBasicSelectionVC"];
    
    // get all of the server URLs
    NSDictionary *serverURLs = [[NSBundle mainBundle] infoDictionary][@"PRServerURLs"];
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:serverURLs.count];
    
    NSString *currentURLString = [[[PRAPIManager sharedManager] baseURL] absoluteString];
    
    for (NSString *serverKey in serverURLs.allKeys) {
        NSString *urlString = serverURLs[serverKey];
        options[serverKey] = [NSString stringWithFormat:@"%@:\n%@", serverKey, urlString];
    }
    
    [selectionVC setOptions:options withDetails:nil orderedAs:@[[serverURLs.allKeys sortedArrayUsingSelector:@selector(compare:)]]];
    
    NSString *selectedURLKey = [[NSUserDefaults standardUserDefaults] valueForKey:APIManagerBaseURLKey];
    if ([selectedURLKey  isNonNullString]) {
        [selectionVC setSelectedKeys:[NSMutableSet setWithObject:selectedURLKey]];
    }
    selectionVC.delegate = self;
    
    if (selectionVC.view) {
        // load the view to configure the labels
        selectionVC.titleLabel.text = @"Select Server";
        selectionVC.subTitleLabel.text = @"The is an advanced setting. Select Staging server for development purposes only. Select Live server for real data entry.";
    }
    
    [self presentViewController:selectionVC animated:YES completion:nil];
#endif
}

-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    NSString *selectionKey = selectionVC.key;
    
    if ([selectionKey isEqualToString:@"trust"]) {
        NSNumber *newTrustID = [[selectionVC selectedKeys] anyObject];
        
        
        if (self.selectedTrust == nil || ![newTrustID isEqualToNumber:self.selectedTrust.id]) {
            PRTrust *newTrust = [[trusts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", newTrustID]] firstObject];
            self.selectedTrust = newTrust;
            [self refreshLoginCredentials];
            trustField.text = newTrust.name;
        }
        
        [self dismissViewControllerAnimated:true completion:nil];
        return;
    }
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *currentURLKey = [[NSUserDefaults standardUserDefaults] valueForKey:APIManagerBaseURLKey];
        NSString *selectedURLKey = [selectionVC.selectedKeys anyObject];
        
        if ([selectedURLKey isNonNullString] && ![currentURLKey isEqualToString:selectedURLKey]) {
            NSString *selectedURL = [[NSBundle mainBundle] infoDictionary][@"PRServerURLs"][selectedURLKey];
            
            [self switchToBaseURL:[NSURL URLWithString:selectedURL] withKey:selectedURLKey];
        }
    }];
}

-(void)refreshLoginCredentials
{
    if (self.selectedTrust == nil) {
        logInCredentials = [NSDictionary dictionary];
        return;
    }
    
    NSArray *allUsers = [PRUser MR_findAll];
    
    NSMutableDictionary *tempUsers = [NSMutableDictionary dictionaryWithCapacity:allUsers.count];
    for (PRUser *user in allUsers) {
        if ([user.trustID isEqualToNumber: self.selectedTrust.id]) {
            tempUsers[user.username] = user.password;
        }
    }
    
    logInCredentials = [NSDictionary dictionaryWithDictionary:tempUsers];
}

-(void)switchToBaseURL:(NSURL *) newURL withKey:(NSString *) urlKey
{
    // prompt the user
    NSMutableString *alertMessage = [NSMutableString stringWithFormat:@"Changing the server will clear all current data."];
    NSUInteger savedRecordCount = [PRRecord MR_countOfEntities];
    if (savedRecordCount > 0) {
        [alertMessage appendFormat:@" There are currently %lu unsubmitted surveys on this device. Changing the server will delete these.", (unsigned long) savedRecordCount];
    }
    [alertMessage appendString:@" Do you wish to change server?"];
    
    void (^changeServerCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        
        MBProgressHUD *deletingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [deletingHUD setLabelText:@"Clearing Data"];
        
        // clear the data
        [[PRAPIManager sharedManager] clearAllDataWithCompletion:^(BOOL success, NSError *error) {
            [deletingHUD hide:YES];
            
            // nil error implies to changes to save.
            if (success || error == nil) {
                // perform the switch
                [[PRAPIManager sharedManager] setBaseURL:newURL];
                [self downloadData];
                
                // save the current baseURL for loading on next launch
                [[NSUserDefaults standardUserDefaults] setValue:urlKey forKey:APIManagerBaseURLKey];
            } else {
                
                void (^cancelCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                    [[PRAPIManager sharedManager] clearAllDataAndWait];
                    [self downloadData];
                };
                
                void (^retryCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
                    [self switchToBaseURL:newURL withKey:urlKey];
                };
                
                [self showAlertWithTitle:@"Data Error"
                                 message:[NSString stringWithFormat:@"Unable to clear the current data: %@", error.localizedDescription]
                             cancelTitle:nil
                            buttonTitles:@[@"Cancel", @"Retry"]
                                 actions:@[cancelCompletion, retryCompletion]];
            }
        }];
    };
    
    [self showAlertWithTitle:@"Change Server"
                     message:alertMessage
                 cancelTitle:@"No"
                buttonTitles:@[@"Yes"]
                     actions:@[changeServerCompletion]];
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
                        NSString *alertMessage = [NSString stringWithFormat:TDLocalizedStringWithDefaultValue(@"record.resubmit-error.message", nil, nil, @"%d previously saved records could not be submitted at this time.", @"The alert message shown when previously saved records have not been successfully submitted."), allErrors.count];
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
                                                       
                                                   } contactSupportTitle:TDLocalizedStringWithDefaultValue(@"alert.contact_support", nil, nil, @"Contact Support", @"The button title shown in an alert that launches an email for contacting support.")
                                              contactSupportBlock:^(UIAlertAction *action, MFMailComposeViewController *mailViewController) {
                                                  
                                                  NSString *errorDescriptions = [PRAPIManager errorDescriptionForErrors:allErrors
                                                                                                      canContactSupport:true
                                                                                                      shouldShowSupport:nil];
                                                  
                                                  NSString *fullErrorMessage = errorDescriptions.length > 0 ? [NSString stringWithFormat:@"%@\n%@", alertMessage, errorDescriptions] : alertMessage;
                                                  
                                                  NSMutableString *emailText = [NSMutableString stringWithFormat:@"An internal app error occured:\n\n%@\n\nErrors:\n\n%@", fullErrorMessage, allErrors];
                                                  [emailText appendFormat:@"Records that could not be submitted:\n"];
                                                  
                                                  for (NSError *error in allErrors) {
                                                      NSDictionary *json = error.userInfo[@"CorruptRecord"];
                                                      if ([json isKindOfClass:[NSDictionary class]]) {
                                                          [emailText appendFormat:@"\n\n%@\n\n", json];
                                                      }
                                                  }
                                                  
                                                  [mailViewController setMessageBody:emailText isHTML:NO];
                                                  
                                              }];
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
            [self refreshLoginCredentials];
        }
        
        if (selector == @selector(getTrustHierarchyWithCompletion:)) {
            trusts = [PRTrust MR_findAll];
#if defined(DEBUG)
            if (trusts.count > 0) {
                self.selectedTrust = [trusts firstObject];
                [self refreshLoginCredentials];
                trustField.text = self.selectedTrust.name;
            }
#endif
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
    
    BOOL isTestUser = [usernameField.text isEqualToString:PRTestAccountUsername] && [passwordField.text isEqualToString:PRTestAccountPassword];
    BOOL canContinue = logInCredentials[usernameField.text] != nil && [passwordField.text isEqualToString:logInCredentials[usernameField.text]];
    
    void (^continueLogIn)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        [[NSUserDefaults standardUserDefaults] setValue:usernameField.text forKey:PRRecordUsernameKey];
        [self performSegueWithIdentifier:@"Continue" sender:self];
    };
    
    if (isTestUser) {
        
        // Present and alert to confirm the choice.
        [self showAlertWithTitle:@"Test User"
                         message:@"You will be logged in as a test user. Any data entered will not be saved or submitted on completion. Do you wish to continue?"
                     cancelTitle:@"Cancel"
                    buttonTitles:@[@"Continue"]
                         actions:@[continueLogIn]];
        return;
    }
    
    if (canContinue) {
        continueLogIn(nil, 0, nil);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Continue"]) {
        PRWardSelectViewController *dvc = segue.destinationViewController;
        dvc.selectedTrust = self.selectedTrust;
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [super textFieldShouldBeginEditing:textField];
    
    if (textField == trustField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:trusts.count];
        
        for (int t = 0; t < trusts.count; t++) {
            PRTrust *thisTrust = trusts[t];
            tempOptions[thisTrust.id] = thisTrust.name;
        }
        
        NSDictionary *options = tempOptions;
        NSArray *sortedKeys = @[[trusts valueForKeyPath:@"id"]];
        id<NSCopying> selectedKey = self.selectedTrust.id;
        BOOL requiresSelection = YES;
        
        NSString *selectionKey = @"trust";
        
        NSString *selectionTitle = TDLocalizedStringWithDefaultValue(@"ward-select.title.trust", nil, nil, @"Trust", @"Title when selecting a trust.");
        NSString *selectionTitleLocalizationKey = @"ward-select.title.trust";
        
        NSString *selectionSubTitle = TDLocalizedStringWithDefaultValue(@"ward-select.subtitle.trust", nil, nil, @"Please select your trust from the list below:", @"Subtitle when selecting a trust.");
        NSString *selectionSubtitleLocalizationKey = @"ward-select.subtitle.trust";
        
        PRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PRBasicSelectionVC"];
        // force load the view to configure the labels
        if (selectionVC.view != nil) {
            [selectionVC setOptions:options withDetails:[NSDictionary dictionary] orderedAs:sortedKeys];
            
            if (selectedKey != nil) {
                selectionVC.selectedKeys = [NSMutableSet setWithObject:selectedKey];
            }
            
            selectionVC.requiresSelection = requiresSelection;
            selectionVC.tableView.allowsMultipleSelection = NO;
            selectionVC.delegate = self;
            selectionVC.key = selectionKey;
            selectionVC.title = selectionTitle;
            
            selectionVC.titleLabel.text = selectionTitle;
            selectionVC.titleLabel.TDLocalizedStringKey = selectionTitleLocalizationKey;
            
            selectionVC.subTitleLabel.text = selectionSubTitle;
            selectionVC.subTitleLabel.TDLocalizedStringKey = selectionSubtitleLocalizationKey;
            
            // present the configured selection vc
            selectionVC.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [self presentViewController:selectionVC animated:YES completion:nil];
        }
        return NO;
        
    }
    
    return YES;
    
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
