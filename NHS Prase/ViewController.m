//
//  ViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "ViewController.h"

#import <TheDistanceKit/TheDistanceKit.h>

@interface ViewController ()

@end

@implementation ViewController
            
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
    
    self.keyboardAccessoryView = [TDInputAccessoryView inputAccessoryViewWithNavigationDelegate:self];
    self.components = @[usernameField, passwordField];
    
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
    if ([usernameField.text isEqualToString:@"user"] && [passwordField.text isEqualToString:@"123"]) {
        [self performSegueWithIdentifier:@"Continue" sender:self];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"Please enter a valid username and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }

    
}


@end
