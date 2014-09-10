//
//  PRNoteViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRNoteViewController.h"
#import <TheDistanceKit/TheDistanceKit.h>

@interface PRNoteViewController ()

@end

// iOS 8 Deprecation
#define ALERT_CANCEL 111

@implementation PRNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    canShowKeyboard = YES;
    canDismissKeyboard = NO;
    
    self.noteView.textInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    self.noteView.layer.borderColor = self.view.tintColor.CGColor;
    self.noteView.layer.borderWidth = 2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNoteText:(NSString *)noteText
{
    _noteText = noteText;
    
    self.noteView.text = noteText;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.noteView.text = self.noteText;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (canShowKeyboard && self.showKeyboardOnWillAppear) {
        [self.noteView becomeFirstResponder];
    }
}

#pragma mark - Keyboard Methods

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (canShowKeyboard && !self.showKeyboardOnWillAppear) {
        [self.noteView becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    canDismissKeyboard = YES;
    [self.noteView resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary *info = [note userInfo];
    CGRect kbFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbFrame = [[[UIApplication sharedApplication] keyWindow] convertRect:kbFrame toView:self.view];
    
    NSNumber *duration = info[UIKeyboardAnimationDurationUserInfoKey];
    BOOL animated = [duration floatValue] > 0;

    if (animated) {
        [UIView animateWithDuration:duration.floatValue animations:^{
            bottomLayoutConstraint.constant = 10.0 + kbFrame.size.height;
            [self.view layoutIfNeeded];
        }];
    } else {
        bottomLayoutConstraint.constant = 10.0 + kbFrame.size.height;
    }
    
}

-(void)keyboardWillHide:(NSNotification *)note
{
    NSDictionary* info = [note userInfo];
    CGRect kbFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbFrame = [[[UIApplication sharedApplication] keyWindow] convertRect:kbFrame toView:self.view];
    
    NSNumber *duration = info[UIKeyboardAnimationDurationUserInfoKey];
    BOOL animated = [duration floatValue] > 0;
    
    if (animated) {
        [UIView animateWithDuration:duration.floatValue animations:^{
            bottomLayoutConstraint.constant = 20.0;
            [self.view layoutIfNeeded];
        }];
    } else {
        bottomLayoutConstraint.constant = 20.0;
    }
    
}

#pragma mark - Cancelling

-(void)cancel:(id)sender
{
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"note.cancel.error-title", nil, nil, @"Cancel Note", @"Error title shown when the user is about to cancel a note.");
    
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"note.cancel.error-message", nil, nil, @"Cancelling a note will lose the text entered or sound recorded. Are you sure you want to cancel this note?", @"Error message shown when the user is about to cancel a note.");
    NSString *buttonTitle = TDLocalizedStringWithDefaultValue(@"note.cancel.error-title", nil, nil, nil, nil);
    NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"note.cancel.cancel-title", nil, nil, @"Continue", @"Button title to continue creating a note when prompted about cancelling it.");
    
    canDismissKeyboard = YES;
    [self.noteView resignFirstResponder];
    canShowKeyboard = NO;
    
#warning JRC: create a more general superclass method to handle multiple completions
    // We need a cancel completion handler so the superclass method isn't called here
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                              [self continueCancel];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction *action) {
                                                              [self cancelCancel];
                                                          }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        // iOS 8 Deprecation
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:self
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:buttonTitle, nil];
        alert.tag = ALERT_CANCEL;
        [alert show];
    }
}

// iOS 8 Deprecation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_CANCEL) {
        if (buttonIndex == 1) {
            [self continueCancel];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_CANCEL && buttonIndex == 0) {
        [self cancelCancel];
    }
}

-(void)cancelCancel
{
    canShowKeyboard = YES;
    canDismissKeyboard = NO;
    [self.noteView becomeFirstResponder];
}

// iOS 8 Deprecation
-(void)continueCancel
{
    if ([self.delegate respondsToSelector:@selector(noteViewControllerCancelled:)]) {
        [self.delegate noteViewControllerCancelled:self];
    }
}

#pragma mark - Delegate Methods

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return canDismissKeyboard;
}

-(void)textViewDidChange:(UITextView *)textView
{
    _noteText = textView.text;
}

-(void)submit:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(noteViewControllerDidFinish:)]) {
        [self.delegate noteViewControllerDidFinish:self];
    }
    
}

@end
