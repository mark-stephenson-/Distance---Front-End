//
//  ViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
{
    IBOutlet UIScrollView *scrollView;

    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
}

-(IBAction)continueAsGuest:(id)sender;
-(IBAction)login:(id)sender;

@end

