//
//  PRViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 08/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"
#import "PRTheme.h"

@implementation PRViewController

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

@end
