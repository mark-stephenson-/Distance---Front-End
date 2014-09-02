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
    
    canDismissKeyboard = NO;
    
    self.noteView.textInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    self.noteView.layer.borderColor = self.view.tintColor.CGColor;
    self.noteView.layer.borderWidth = 2.0;
    self.noteView.inputAccessoryView = [self createInputAccessoryViewOfHeight:40.0];
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

    [self.noteView becomeFirstResponder];
}

#pragma mark - Keyboard Methods

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
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

-(UIToolbar *)createInputAccessoryViewOfHeight:(CGFloat) height;
{
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    
    UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleBordered target:self action:@selector(submit:)];
    
    tb.items = @[cancel, space1, submit];
    
    return tb;
}

#pragma mark - Cancelling

-(void)cancel:(id)sender
{
    NSString *alertTitle = @"Cancel Note";
    NSString *alertMessage = @"Cancelling a note will lose the text entered or sound recorded. Are you sure you want to cancel this note?";
    NSString *buttonTitle = @"Cancel Note";
    NSString *cancelTitle = @"Continue";
    
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
                                                          handler:nil]];
        
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
    if (buttonIndex == 1) {
        if (alertView.tag == ALERT_CANCEL) {
            [self continueCancel];
        }
    }
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
