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

#import "PRNote.h"
#import "PRConcern.h"
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface PRPIRTViewController ()

@end

#define ALERT_CANCEL 111

@implementation PRPIRTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    segmentTitles = @[@"Ward", @"What is your conern?", @"Severity of Concern"];
    
    // create the input accessory view
    noteVCToolbar = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    noteVCToolbar.navigationDelegate = self;
    [self applyThemeToView:noteVCToolbar];
    
    // grab the storyboard created view controllers
    wardSelectVC = tabController.viewControllers[0];
    wardSelectVC.record = self.record;
    
    questionsVC = tabController.viewControllers[1];
    
    // force the view controllers to load their views so they can be configured here
    UIView *loadView = nil;
    
    // create the simple view controllers
    whatViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = whatViewController.view;
    whatViewController.titleLabel.text = TDLocalizedStringWithDefaultValue(@"pirt.what.title", nil, nil, @"Can you please provide a brief description detailing what your concern is, why it is a concern to you and what you think could have been done differently to prevent it from happening to you or other patients. General comments can also be included.", @"Concern section title");
    whatViewController.delegate = self;
    whatViewController.titleLabel.TDLocalizedStringKey = @"pirt.what.title";
    whatViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    /*
    whyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = whyViewController.view;
    whyViewController.titleLabel.text = TDLocalizedStringWithDefaultValue(@"pirt.why.title", nil, nil, @"Why was this a concern for you?", @"Concern section title");
    whyViewController.titleLabel.TDLocalizedStringKey = @"pirt.why.title";
    whyViewController.delegate = self;
    whyViewController.noteView.inputAccessoryView = noteVCToolbar;
    
    preventViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    loadView = preventViewController.view;
    preventViewController.titleLabel.text = TDLocalizedStringWithDefaultValue(@"pirt.prevent.title", nil, nil, @"What could be done to stop this from happening again to you or other patients?", @"Concern section title");
    preventViewController.delegate = self;
    preventViewController.titleLabel.TDLocalizedStringKey = @"pirt.prevent.title";
    preventViewController.noteView.inputAccessoryView = noteVCToolbar;
    */
    
    // call the setter again to assign all the properties to the view conctrollers
    self.concern = _concern;
    
    [tabController setViewControllers:@[wardSelectVC, whatViewController, questionsVC]];
}

-(PRConcern *)concern
{
    if (_concern == nil) {
        _concern = [self currentConcern];
    }
    
    if (wardSelectVC.selectedWard != nil) {
        _concern.ward = wardSelectVC.selectedWard;
    }
    
    return _concern;
}

-(void)setConcern:(PRConcern *)concern
{
    _concern = concern;
    
    wardSelectVC.selectedWard = concern.ward;
    whatViewController.note = concern.whatNote;
//    whyViewController.note = concern.whyNote;
//    preventViewController.note = concern.preventNote;
    questionsVC.seriousQuestion = concern.seriousQuestion;
    questionsVC.preventQuestion = concern.preventQuestion;
}

-(PRConcern *)currentConcern
{
    PRConcern *newConcern = [PRConcern MR_createEntity];
    
    newConcern.ward = wardSelectVC.selectedWard;
    newConcern.whatNote = [whatViewController note];
//    newConcern.whyNote = [whyViewController note];
//    newConcern.preventNote = [preventViewController note];
    
    newConcern.seriousQuestion = questionsVC.seriousQuestion;
    newConcern.preventQuestion = questionsVC.preventQuestion;
    
    return newConcern;
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    if (isLastSection) {
        nextButton.TDLocalizedStringKey = @"button.done";
        [nextButton setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        nextButton.TDLocalizedStringKey = PRLocalisationKeyNext;
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
    if (tabController.selectedIndex == 0) {
        if ([wardSelectVC validateSelectedWard]) {
            [wardSelectVC commitCustomWard];
        } else {
            return;
        }
    }
    
    if (tabController.selectedIndex == tabController.viewControllers.count - 1) {
        
        if ([self.pirtDelegate respondsToSelector:@selector(pirtViewControllerDidFinish:withConcern:)]) {
            
            [self.pirtDelegate pirtViewControllerDidFinish:self withConcern:self.concern];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } else {
        [super goNext:sender];
    }
}

/// The footer view is replaced by a keyboard text input view on the PRNoteViewController screens so the footer is removed as it will be replaced by the textView's inputAccessoryView
-(void)selectSegment:(NSInteger)segment
{
    if (tabController.selectedIndex == 0) {
        [self.view endEditing:YES];
        
        if ([wardSelectVC validateSelectedWard]) {
            [wardSelectVC commitCustomWard];
        } else {
            return;
        }
    }
    
    [super selectSegment:segment];
    
    if (segment == 0 || segment == tabController.viewControllers.count - 1) {
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
    NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"pirt.cancel.alert-message", nil, nil, @"By cancelling this concern any data entered about this concern will not be saved. Are you sure you want to cancel this concern?", @"Alert message shown before the user cancels a concern workflow");
    NSString *buttonTitle = alertTitle;
    NSString *cancelTitle = TDLocalizedStringWithDefaultValue(@"pirt.cancel.cancel-title", nil, nil, @"Continue with Concern", @"Cancel button title to continue a concern workflow dismissing the cancel alert.");
    
    void (^deletePIRTCompletion)(UIAlertAction *, NSInteger, NSString *) = ^(UIAlertAction *action, NSInteger buttonIndex, NSString *buttonTitle){
        [self continueCancel];
    };
    
    [self showAlertWithTitle:alertTitle
                     message:alertMessage
                 cancelTitle:cancelTitle
                buttonTitles:@[buttonTitle]
                     actions:@[deletePIRTCompletion]];
}

/*
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self continueCancel];
    }
}
*/
 
-(void)continueCancel
{
    if ([self.pirtDelegate respondsToSelector:@selector(pirtViewControllerDidCancel:)]) {
        [self.pirtDelegate pirtViewControllerDidCancel:self];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
