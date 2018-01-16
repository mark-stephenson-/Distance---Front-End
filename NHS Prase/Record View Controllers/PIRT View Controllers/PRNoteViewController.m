//
//  PRNoteViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRNoteViewController.h"
#import <TheDistanceKit/TheDistanceKit_API.h>

#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/MagicalRecord.h>
#import "PRNote.h"

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
    self.noteView.delegate = self;
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
    
    self.noteText = self.note.text;
    self.noteView.text = self.noteText;
    
    if (self.parentViewController == nil) {
        topLayoutConstraint.constant = topLayoutConstraint.constant + 20.0;
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    if (canShowKeyboard && self.showKeyboardOnWillAppear) {
//        [self.noteView becomeFirstResponder];
//    }
}

#pragma mark - Keyboard Methods

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if (canShowKeyboard && !self.showKeyboardOnWillAppear) {
//        [self.noteView becomeFirstResponder];
//    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    canDismissKeyboard = YES;
    [self.noteView resignFirstResponder];
    self.activeComponent = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"note.cancel.error-title", nil, nil, @"Cancel Comment", @"Error title shown when the user is about to cancel a note.");
    
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"note.cancel.error-message", nil, nil, @"By cancelling this comment any text entered will not be saved. Are you sure you want to cancel this comment?", @"Error message shown when the user is about to cancel a note.");
    NSString *cancelNoteTitle = alertTitle;
    NSString *continueNoteTitle = TDLocalizedStringWithDefaultValue(@"note.cancel.cancel-title", nil, nil, @"Continue with Comment", @"Button title to continue creating a good comment when prompted about cancelling it.");
    
    canDismissKeyboard = YES;
    [self.noteView resignFirstResponder];
    canShowKeyboard = NO;
    
    void (^continueNoteCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        canShowKeyboard = YES;
        canDismissKeyboard = NO;
        [self.noteView becomeFirstResponder];
    };
    
    void (^cancelNoteCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        if ([self.delegate respondsToSelector:@selector(noteViewControllerCancelled:)]) {
            [self.delegate noteViewControllerCancelled:self];
        }
    };
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 cancelTitle:nil
                buttonTitles:@[cancelNoteTitle, continueNoteTitle]
                     actions:@[cancelNoteCompletion, continueNoteCompletion]];
}

#pragma mark - Delegate Methods
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return true;
//    return canDismissKeyboard;
}

-(void)textViewDidChange:(UITextView *)textView
{
    _noteText = textView.text;
}

-(void)submit:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(noteViewControllerDidFinish:withNote:)]) {
        [self.delegate noteViewControllerDidFinish:self withNote:self.note];
    }
}

-(PRNote *)note
{
    if (_note == nil) {
        _note = [self currentNote];
    } else {
        _note.text = self.noteText;
    }
    
    return _note;
}

-(void)setNote:(PRNote *)note
{
    _note = note;
    self.noteText = note.text;
}

-(PRNote *)currentNote
{
    if ([self.noteText isNonNullString]) {
        PRNote *newNote = [PRNote MR_createEntity];
        newNote.text = self.noteText;
        return newNote;
    }
    
    return nil;
}

@end
