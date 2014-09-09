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
    
    self.components = @[usernameField, passwordField];
    usernameField.inputAccessoryView = inputView;
    passwordField.inputAccessoryView = inputView;
    
    self.scrollContainer = scrollView;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.scrollContainer = nil;
}

#pragma mark - Log In

-(void)continueAsGuest:(id)sender
{
    [self performSegueWithIdentifier:@"Continue" sender:self];
}

-(void)login:(id)sender
{
    if (true) { //[usernameField.text isEqualToString:@"user"] && [passwordField.text isEqualToString:@"1234"]) {
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

#warning JRC: +KeyboardResponders input accessory should be generalised to a category so a UIView can be used not just a UIToolBar to remove a lot of these duplicated implementations.

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.activeComponent = textField;
    
    [inputView refreshBarButtonItemStatus];
    
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
    
    return YES;
}

-(BOOL)inputAccessoryCanGoToPrevious:(PRInputAccessoryView *)inputAccessoryView
{
    return self.activeComponent == passwordField;
}

-(BOOL)inputAccessoryCanGoToNext:(PRInputAccessoryView *)inputAccessoryView
{
    return YES;
}

-(void)inputAccessoryRequestsNext:(PRInputAccessoryView *)inputAccessoryView
{
    if (self.activeComponent == passwordField) {
        [self dismissKeyboard];
        return;
    }
    
    self.swappingFields = YES;
    
    UIView *nextComponent = self.components[self.activeComponent.tag + 1];
    
    if ([self.activeComponent canResignFirstResponder]) {
        [self.activeComponent resignFirstResponder];
    }
    
    if ([nextComponent canBecomeFirstResponder]) {
        [nextComponent becomeFirstResponder];
    }
    
    [inputView refreshBarButtonItemStatus];
}

-(void)inputAccessoryRequestsPrevious:(TDInputAccessoryView *)inputAccessoryView
{
    self.swappingFields = YES;
    
    UIView *prevComponent = self.components[self.activeComponent.tag - 1];
    
    if ([self.activeComponent canResignFirstResponder]) {
        [self.activeComponent resignFirstResponder];
    }
    
    if ([prevComponent canBecomeFirstResponder]) {
        [prevComponent becomeFirstResponder];
    }
    
    [inputView refreshBarButtonItemStatus];
}

-(void)inputAccessoryRequestsDone:(TDInputAccessoryView *)inputAccessoryView
{
    [self dismissKeyboard];
}

@end
