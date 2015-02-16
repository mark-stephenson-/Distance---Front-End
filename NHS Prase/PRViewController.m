//
//  PRViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 08/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"
#import "PRTheme.h"

NSString *const PRLocalisationKeyOK = @"pr.ok";
NSString *const PRLocalisationKeyCancel = @"button.cancel";
NSString *const PRLocalisationKeyRetry = @"pr.retry";
NSString *const PRLocalisationKeySubmit = @"button.submit";
NSString *const PRLocalisationKeyNext = @"button.next";

@implementation PRViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
        // explicitly add a string to be picked up in gen strings
    NSString *loadString = nil;
    loadString = TDLocalizedStringWithDefaultValue(@"button.cancel", nil, nil, @"Cancel", @"Used as a button title to cancel an action or event throughout the app.");
    loadString = TDLocalizedStringWithDefaultValue(@"pr.ok", nil, nil, @"OK", @"Used as a button title  to confirm an action or event throughout the app.");
    loadString = TDLocalizedStringWithDefaultValue(@"pr.retry", nil, nil, @"Retry", @"Used as a button title  to retry an action or event throughout the app.");
    loadString = TDLocalizedStringWithDefaultValue(@"button.submit", nil, nil, @"Submit", @"Used as a button title throughout the app to complete a task, such as adding a concern or submitting a record.");
    loadString = TDLocalizedStringWithDefaultValue(@"button.next", nil, nil, @"Next", @"Used as a button title throughout the app to advance a task.");
}

-(void)showAlertWithStyle:(TDAlertStyle)style sourceItem:(id)sourceItem title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancel buttonTitles:(NSArray *)titles actions:(NSArray *)actions
{
    if (cancel == nil && titles.count == 0) {
        cancel = TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, nil, nil);
    }
    
    [super showAlertWithStyle:style sourceItem:sourceItem title:title message:message cancelTitle:cancel buttonTitles:titles actions:actions];
}

@end
