//
//  ViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"
#import "PRInputAccessoryView.h"

@class PRTrust;
@class PRHospital;
@class PRWard;
/*!
 * @class PRLoginViewController
 * @discussion The first screen the user sees, allowing log in to create a record. The methods in the KeyboardResponder UIViewController category are used to navigate between the log in fields.
 */
@interface PRLoginViewController : PRViewController <TDInputAccessoryDelegate, TDSelectionViewControllerDelegate, UITextViewDelegate>
{
    NSDictionary *logInCredentials;
    
    __weak IBOutlet UITextField *trustField;
    
    __weak IBOutlet UILabel *versionLabel;
    
    __weak IBOutlet UIScrollView *scrollView;

    __weak IBOutlet TDTextField *usernameField;
    __weak IBOutlet TDTextField *passwordField;
    
    __weak IBOutlet UIButton *retryButton;
    
    PRInputAccessoryView *inputView;
    
    __weak IBOutlet NSLayoutConstraint *retryWidthConstraint;
    
    /// Flag to determine whether there are previously saved records that cannot be submitted. If there are none to submit this is YES.
    BOOL submissionSucces;
    
    /// Flag to determine whether an attempt to download the latest data from the server was successful.
    BOOL dataSuccess;
    
    NSArray *trusts;
}

@property (nonatomic, strong) PRTrust *selectedTrust;

-(IBAction)continueAsGuest:(id)sender;
-(IBAction)login:(id)sender;

@end

