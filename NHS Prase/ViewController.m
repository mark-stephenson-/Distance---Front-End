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

@end
