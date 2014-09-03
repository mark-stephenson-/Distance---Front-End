//
//  PRQuestionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionViewController.h"

#import "PRQuestion.h"
#import "PRQuestionOptions.h"

#import "PRButton.h"
#import "PRTheme.h"
#import "PRNoteViewController.h"
#import "PRGoodViewController.h"
#import "PRPIRTViewController.h"

#import <TheDistanceKit/TheDistanceKit.h>

@interface PRQuestionViewController ()

@end

@implementation PRQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    pirtView.hidden = self.shouldHidePIRTView;
    
    [self applyTheme];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"AddNote"] || [segue.identifier isEqualToString:@"AddGood"]) {
        PRNoteViewController *noteVC = (PRNoteViewController *) segue.destinationViewController;
        noteVC.delegate = self;
    }
}

#pragma mark - PIRT Methods

-(PRInputAccessoryView *)accessoryView
{
    static PRInputAccessoryView *view = nil;
    
    if (view == nil) {
        view = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
        view.navigationDelegate = self;
        
        view.previousButton.hidden = YES;
        
        view.nextButton.backgroundColor = [[PRTheme sharedTheme] positiveColor];
        [view.nextButton setTitle:@"Done" forState:UIControlStateNormal];
        [view.nextButton setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    }
    
    return view;
}

-(void)addNote:(id)sender
{
    PRNoteViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    toPresent.delegate = self;
    
    UIView *loadView = toPresent.view;
    PRInputAccessoryView *accessoryView = [self accessoryView];
    toPresent.noteView.inputAccessoryView = accessoryView;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:toPresent animated:YES completion:nil];
    }];
}

-(void)addSomethingGood:(id)sender
{
    PRGoodViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodVC"];
    toPresent.delegate = self;
    
    
    UIView *loadView = toPresent.view;
    PRInputAccessoryView *accessoryView = [self accessoryView];
    toPresent.noteView.inputAccessoryView = accessoryView;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:toPresent animated:YES completion:nil];
    }];
}

-(void)addConcern:(id)sender
{
    PRPIRTViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"PIRTVC"];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:toPresent animated:YES completion:nil];
    }];
}

#pragma mark - Note Delegate

-(void)noteViewControllerDidFinish:(PRNoteViewController *)noteVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)noteViewControllerCancelled:(PRNoteViewController *)noteVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Input Delegate

-(BOOL)inputAccessoryCanGoToNext:(TDInputAccessoryView *)inputAccessoryView
{
    return YES;
}

-(BOOL)inputAccessoryCanGoToPrevious:(TDInputAccessoryView *)inputAccessoryView
{
    return NO;
}

-(void)inputAccessoryRequestsDone:(TDInputAccessoryView *)inputAccessoryView
{
    PRNoteViewController *currentNote = (PRNoteViewController *) self.presentedViewController;
    [currentNote cancel:self];
}

-(void)inputAccessoryRequestsPrevious:(TDInputAccessoryView *)inputAccessoryView
{
    
}

-(void)inputAccessoryRequestsNext:(TDInputAccessoryView *)inputAccessoryView
{
    PRNoteViewController *currentNote = (PRNoteViewController *) self.presentedViewController;
    [currentNote submit:self];
}

@end
