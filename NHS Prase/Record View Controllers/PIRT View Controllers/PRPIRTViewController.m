//
//  PRPIRTViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTViewController.h"

#import "PRGoodViewController.h"
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
    
    /*
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelConcern:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(goPrevious:)];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(goNext:)];
    
    noteVCToolbar.items = @[cancel, space, previous, next];
    */
    
    // grab the storyboard created view controllers
    PRGoodViewController *wardSelectVC = tabController.viewControllers[0];
    PRPIRTQuestionsViewController *questionsVC = tabController.viewControllers[1];
    
    // force the view controllers to load their views so they can be configured here
    UIView *loadView = nil;
    
    // create the simple view controllers
    PRNoteViewController *whatViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = whatViewController.view;
    whatViewController.titleLabel.text = @"Detail needed about what, where and when the concern happened.";
    whatViewController.delegate = self;
    whatViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    PRNoteViewController *whyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = whyViewController.view;
    whyViewController.titleLabel.text = @"Why was this a concern for you?";
    whyViewController.delegate = self;
    whyViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    PRNoteViewController *preventViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = preventViewController.view;
    preventViewController.titleLabel.text = @"What could be done to stop this from happening again to you or other patients?";
    preventViewController.delegate = self;
    preventViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    [tabController setViewControllers:@[wardSelectVC, whatViewController, whyViewController, preventViewController, questionsVC]];
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    if (isLastSection) {
        [nextButton setTitle:@"Done" forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] neutralColor]];
    }
}

#pragma mark - Navigation

-(void)goNext:(id)sender
{
    if (tabController.selectedIndex == tabController.viewControllers.count - 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [super goNext:sender];
    }
}

-(void)segmentChanged:(id)sender
{
    [super segmentChanged:sender];
    
    if (visibleSelector.selectedSegmentIndex == 0 || visibleSelector.selectedSegmentIndex == 4) {
        [self showFooterView:YES animated:NO];
    } else {
        [self showFooterView:NO animated:NO];
    }
    
    //[self refreshFooterView];
}

#pragma mark - Input Accessory Delegate

// The input accessory is only visible on the middle 3 screens so navigation to and from them can always occur.

-(BOOL)inputAccessoryCanGoToNext:(TDInputAccessoryView *)inputAccessoryView
{
    return YES;
}

-(BOOL)inputAccessoryCanGoToPrevious:(TDInputAccessoryView *)inputAccessoryView
{
    return YES;
}

-(void)inputAccessoryRequestsNext:(TDInputAccessoryView *)inputAccessoryView
{
    [self goNext:self];
}

-(void)inputAccessoryRequestsPrevious:(TDInputAccessoryView *)inputAccessoryView
{
    [self goPrevious:self];
}

-(void)inputAccessoryRequestsDone:(TDInputAccessoryView *)inputAccessoryView
{
    [self cancelConcern:self];
}

#pragma mark - Note Delegate

-(void)cancelConcern:(id) sender
{
    NSString *alertTitle = @"Cancel Concern";
    NSString *alertMessage = @"Returning to the title screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Cancel Concern";
    NSString *cancelTitle = @"Continue";
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 buttonTitle:buttonTitle
            buttonCompletion:^{
                [self continueCancel];
            }
                 cancelTitle:cancelTitle
                    alertTag:ALERT_CANCEL];
    
}

-(void)continueCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
