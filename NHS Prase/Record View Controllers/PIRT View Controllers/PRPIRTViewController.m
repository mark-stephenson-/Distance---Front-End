//
//  PRPIRTViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTViewController.h"

#import "PRPIRTWardSelectViewController.h"
#import "PRPIRTQuestionsViewController.h"
#import "PRTheme.h"


@interface PRPIRTViewController ()

@end

#define ALERT_CANCEL 111

@implementation PRPIRTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // create the input accessory view
    noteVCToolbar = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    noteVCToolbar.navigationDelegate = self;
    [self applyThemeToView:noteVCToolbar];
    
    // grab the storyboard created view controllers
    PRPIRTWardSelectViewController *wardSelectVC = tabController.viewControllers[0];
    wardSelectVC.record = self.record;
    PRPIRTQuestionsViewController *questionsVC = tabController.viewControllers[1];
    
    // force the view controllers to load their views so they can be configured here
    UIView *loadView = nil;
    
    // create the simple view controllers
    PRNoteViewController *whatViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = whatViewController.view;
    whatViewController.titleLabel.text = TDLocalizedStringWithDefaultValue(@"pirt.what.title", nil, nil, @"Detail needed about what, where and when the concern happened.", @"Concern section title");
    whatViewController.delegate = self;
    whatViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    PRNoteViewController *whyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = whyViewController.view;
    whyViewController.titleLabel.text = TDLocalizedStringWithDefaultValue(@"pirt.why.title", nil, nil, @"Why was this a concern for you?", @"Concern section title");
    whyViewController.delegate = self;
    whyViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    PRNoteViewController *preventViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = preventViewController.view;
    preventViewController.titleLabel.text = TDLocalizedStringWithDefaultValue(@"pirt.why.title", nil, nil, @"What could be done to stop this from happening again to you or other patients?", @"Concern section title");
    preventViewController.delegate = self;
    preventViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    [tabController setViewControllers:@[wardSelectVC, whatViewController, whyViewController, preventViewController, questionsVC]];
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    if (isLastSection) {
        nextButton.TDLocalizedStringKey = @"button.done";
        [nextButton setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        nextButton.TDLocalizedStringKey = @"button.next";
        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] neutralColor]];
    }
    
    [self applyThemeToView:footerView];
}

#pragma mark - Navigation

/// Overrides superclass method to dismiss on the final page
-(void)goNext:(id)sender
{
    if (tabController.selectedIndex == tabController.viewControllers.count - 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [super goNext:sender];
    }
}

/// The footer view is replaced by a keyboard text input view on the PRNoteViewController screens so the footer is removed as it will be replaced by the textView's inputAccessoryView
-(void)segmentChanged:(id)sender
{
    [super segmentChanged:sender];
    
    if (visibleSelector.selectedSegmentIndex == 0 || visibleSelector.selectedSegmentIndex == 4) {
        [self showFooterView:YES animated:NO];
    } else {
        [self showFooterView:NO animated:NO];
    }
}

#pragma mark - Input Accessory Delegate

// The input accessory is only visible on the middle 3 screens so navigation to and from them can always occur.

-(BOOL)inputAccessoryCanGoToNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    return YES;
}

-(BOOL)inputAccessoryCanGoToPrevious:(id<TDInputAccessoryView>)inputAccessoryView
{
    return YES;
}

-(void)inputAccessoryRequestsNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    [self goNext:self];
}

-(void)inputAccessoryRequestsPrevious:(id<TDInputAccessoryView>)inputAccessoryView
{
    [self goPrevious:self];
}

-(void)inputAccessoryRequestsDone:(id<TDInputAccessoryView>)inputAccessoryView
{
    [self cancelConcern:self];
}

#pragma mark - Note Delegate

-(void)cancelConcern:(id) sender
{
    NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"pirt.cancel.alert-title", nil, nil, @"Cancel Concern", @"Alert title shown before the user cancels a concern workflow.");
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"pirt.cancel.alert-message", nil, nil, @"Returning to the title screen will delete any entered data. Are you sure you want to continue?", @"Alert message shown before the user cancels a concern workflow");
    NSString *buttonTitle = alertTitle;
    NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"pirt.cancel.cancel-title", nil, nil, @"Continue", @"Cancel button title to continue a concern workflow dismissing the cancel alert.");
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 buttonTitle:buttonTitle
            buttonCompletion:^(NSNumber *buttonIndex, UIAlertAction *action) {
                [self continueCancel];
            }
                 cancelTitle:cancelTitle
                    alertTag:ALERT_CANCEL];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self continueCancel];
    }
}

-(void)continueCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
