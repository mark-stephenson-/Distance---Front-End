//
//  ViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRLoginViewController.h"

#import <TheDistanceKit/TheDistanceKit.h>
#import "PRButton.h"
#import "PRTheme.h"

#define ALERT_LOGIN 111

@interface PRLoginViewController ()

@end

@implementation PRLoginViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *loginCredentials = @{@"00001":@"nhs123",
                                       @"00002":@"bradfordnhs",
                                       @"00003":@"barnsleyhospital"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.keyboardAccessoryView = nil;
    
    inputView = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    inputView.navigationDelegate = self;
    [self applyThemeToView:inputView];
    
    self.keyboardAccessoryView = inputView;
    
    self.components = @[usernameField, passwordField];

    self.scrollContainer = scrollView;
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
    if (true) {//logInCredentials[usernameField.text] != nil && [passwordField.text isEqualToString:logInCredentials[usernameField.text]]) {
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
