//
//  ViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"
#import "PRInputAccessoryView.h"

/*!
 * @class PRLoginViewController
 * @discussion The first screen the user sees, allowing log in to create a record. The methods in the KeyboardResponder UIViewController category are used to navigate between the log in fields.
 */
@interface PRLoginViewController : PRViewController <TDInputAccessoryDelegate>
{
    NSDictionary *logInCredentials;
    
    IBOutlet UIScrollView *scrollView;

    IBOutlet TDTextField *usernameField;
    IBOutlet TDTextField *passwordField;
    
    PRInputAccessoryView *inputView;
    
    __weak IBOutlet NSLayoutConstraint *retryWidthConstraint;
}

-(IBAction)continueAsGuest:(id)sender;
-(IBAction)login:(id)sender;

@end

