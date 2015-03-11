//
//  PRIncompleteViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 11/03/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "PRIncompleteViewController.h"
#import "PRTheme.h"

@interface PRIncompleteViewController ()

@end

@implementation PRIncompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleLabel.text = self.title;
    subtitleLabel.text = self.subtitle;
    
    containerView.layer.borderWidth = 2.0;
    containerView.layer.borderColor = self.view.tintColor.CGColor;
    
    [self refreshDoneButton];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [textView becomeFirstResponder];
}

-(void)refreshDoneButton
{
    BOOL reasonGiven = [textView.text isNonNullString];
    
    doneButton.enabled = reasonGiven;
    doneButton.backgroundColor = reasonGiven ? [[PRTheme sharedTheme] positiveColor] : [UIColor lightGrayColor];
}


#pragma mark - Setters

-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    subtitleLabel.text = subtitle;
}

-(void)done:(id)sender
{
    [self.delegate incompleteViewController:self completedWithText:textView.text];
}

-(void)cancel:(id)sender
{
    [self.delegate incompleteViewControllerDidCancel:self];
}

#pragma mark - Text View Delegate Methods

-(void)textViewDidChange:(UITextView *)tv
{
    [self refreshDoneButton];
}

@end
