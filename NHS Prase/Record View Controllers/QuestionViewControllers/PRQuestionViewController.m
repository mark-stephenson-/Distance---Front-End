//
//  PRQuestionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionViewController.h"

#import "PRQuestion.h"

#import "PRTheme.h"
#import "PRNoteViewController.h"
#import "PRGoodViewController.h"
#import "PRPIRTViewController.h"
#import "PRNote.h"
#import "PRConcern.h"

#import <TheDistanceKit/TheDistanceKit_API.h>

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
    [self refreshPIRTViews];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"AddNote"] || [segue.identifier isEqualToString:@"AddGood"]) {
        PRNoteViewController *noteVC = (PRNoteViewController *) segue.destinationViewController;
        noteVC.delegate = self;
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGSize viewSize = self.view.frame.size;
    TDButtonImageAlignment alignment = viewSize.width > viewSize.height ? kTDButtonImageAlignmentLeft : kTDButtonImageAlignmentTop;
    for (TDButton *button in pirtButtons) {
        if (button.imageAlignment != alignment) {
            button.imageAlignment = alignment;
        }
    }
}

-(void)refreshPIRTViews
{
    concernButton.selected = validConcern;
    goodButton.selected = validGoodNote;
    noteButton.selected = validNote;
    
    
    if (validConcern) {
        concernButton.backgroundColor = [[PRTheme sharedTheme] negativeColor];
        concernButton.imageTint = [UIColor whiteColor];
        [concernButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    } else {
        concernButton.backgroundColor = [UIColor clearColor];
        concernButton.imageTint = [[PRTheme sharedTheme] negativeColor];
    }
    
    if (validGoodNote) {
        goodButton.backgroundColor = [[PRTheme sharedTheme] positiveColor];
        goodButton.imageTint = [UIColor whiteColor];
        [goodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    } else {
        goodButton.backgroundColor = [UIColor clearColor];
        goodButton.imageTint = [[PRTheme sharedTheme] positiveColor];
    }
    
    if (validNote) {
        noteButton.backgroundColor = [[PRTheme sharedTheme] neutralColor];
        noteButton.imageTint = [UIColor whiteColor];
        [noteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    } else {
        noteButton.backgroundColor = [UIColor clearColor];
        noteButton.imageTint = [[PRTheme sharedTheme] neutralColor];
    }
}


#pragma mark - PIRT Methods

-(PRInputAccessoryView *)accessoryView
{
    PRInputAccessoryView *view = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    view.navigationDelegate = self;
    
    view.previousButton.hidden = YES;
    
    view.nextButton.backgroundColor = [[PRTheme sharedTheme] positiveColor];
    view.nextButton.TDLocalizedStringKey = @"button.done";
    [view.nextButton setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    
    [self applyThemeToView:view];
    
    return view;
}

-(void)addNote:(id)sender
{
    PRNoteViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVC"];
    toPresent.delegate = self;
    toPresent.note = self.question.note;
    
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
    toPresent.record = self.question.record;
    toPresent.note = self.question.goodNote;
    
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
    toPresent.record = self.question.record;
    toPresent.pirtDelegate = self;
    toPresent.concern = self.question.concern;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:toPresent animated:YES completion:nil];
    }];
}

#pragma mark - Note Delegate

-(void)noteViewControllerDidFinish:(PRNoteViewController *)noteVC withNote:(PRNote *)note
{
    if ([noteVC isKindOfClass:[PRGoodViewController class]]) {
        validGoodNote = [note isValid];
        
        if (validGoodNote) {
            self.question.goodNote = note;
        } else {
            self.question.goodNote = nil;
        }
    } else {
        validNote = [note isValid];
        
        if (validNote) {
            self.question.note = note;
        } else {
            self.question.note = nil;
        }
    }
    
    [self refreshPIRTViews];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)noteViewControllerCancelled:(PRNoteViewController *)noteVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PIRT Delegate

-(void)pirtViewControllerDidCancel:(PRPIRTViewController *)pirtVC
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [pirtVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)pirtViewControllerDidFinish:(PRPIRTViewController *)pirtVC withConcern:(PRConcern *)concern
{
    validConcern = [concern isValid];
    if (validConcern) {
        self.question.concern = concern;
    } else {
        self.question.concern = nil;
    }
    
    [self refreshPIRTViews];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [pirtVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Input Delegate

-(BOOL)inputAccessoryCanGoToNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    return YES;
}

-(BOOL)inputAccessoryCanGoToPrevious:(id<TDInputAccessoryView>)inputAccessoryView
{
    return NO;
}

-(void)inputAccessoryRequestsDone:(id<TDInputAccessoryView>)inputAccessoryView
{
    PRNoteViewController *currentNote = (PRNoteViewController *) self.presentedViewController;
    [currentNote cancel:self];
}

-(void)inputAccessoryRequestsPrevious:(id<TDInputAccessoryView>)inputAccessoryView
{
    
}

-(void)inputAccessoryRequestsNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    PRNoteViewController *currentNote = (PRNoteViewController *) self.presentedViewController;
    [currentNote submit:self];
}

@end
