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
NSString *const PRLocalisationKeyCancel = @"pr.cancel";
NSString *const PRLocalisationKeyRetry = @"pr.retry";
NSString *const PRLocalisationKeySubmit = @"button.submit";
NSString *const PRLocalisationKeyNext = @"button.next";

@implementation PRViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
        // explicitly add a string to be picked up in gen strings
    TDLocalizedStringWithDefaultValue(PRLocalisationKeyCancel, nil, nil, @"Cancel", @"Used as a button title to cancel an action or event throughout the app.");
    TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, @"OK", @"Used as a button title  to confirm an action or event throughout the app.");
    TDLocalizedStringWithDefaultValue(PRLocalisationKeyCancel, nil, nil, @"Retry", @"Used as a button title  to retry an action or event throughout the app.");
    TDLocalizedStringWithDefaultValue(PRLocalisationKeySubmit, nil, nil, @"Submit", @"Used as a button title throughout the app to complete a task, such as adding a concern or submitting a record.");
}

-(void)showAlertWithStyle:(TDAlertStyle)style sourceItem:(id)sourceItem title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancel buttonTitles:(NSArray *)titles actions:(NSArray *)actions
{
    if (cancel == nil && titles.count == 0) {
        cancel = TDLocalizedStringWithDefaultValue(PRLocalisationKeyOK, nil, nil, nil, nil);
    }
    
    [super showAlertWithStyle:style sourceItem:sourceItem title:title message:message cancelTitle:cancel buttonTitles:titles actions:actions];
}

/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self applyTheme];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyTheme) name:TDThemeChange object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TDThemeChange object:nil];
}

-(void)showAlertWithTitle:(NSString *) alertTitle message:(NSString *) alertMessage buttonTitle:(NSString *) buttonTitle buttonCompletion:(void (^)(NSNumber *buttonIndex, UIAlertAction *action)) completion cancelTitle:(NSString *) cancelTitle alertTag:(NSInteger) tag
{
    if (cancelTitle == nil) {
        cancelTitle = TDLocalizedStringWithDefaultValue(@"alert.cancel-title", nil, nil, @"OK", @"The default button to dismiss an alert view.");
    }
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        if ([buttonTitle isNonNullString]) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                                style:UIAlertActionStyleDestructive
                                                              handler:^(UIAlertAction *action) {
                                                                  if (completion != nil) {
                                                                      completion(nil, action);
                                                                  }
                                                              }]];
        }
        
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
        alert.tag = tag;
        
        if (completion != nil) {
            alertCompletions[@(tag)] = completion;
        }
        
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^buttonCompletion)(NSNumber *idx, UIAlertAction *action) = alertCompletions[@(alertView.tag)];
    
    if (buttonCompletion != nil) {
        buttonCompletion(@(buttonIndex), nil);
    }
}
*/

@end
