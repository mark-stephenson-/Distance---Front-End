//
//  PRRecordViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRRecordViewController.h"

#import "PRBasicDataFormViewController.h"
#import "PRQuestionaireViewController.h"

// iOS 8 Deprecation
#define ALERT_GO_HOME 111
#define ALERT_GO_TITLE 222

@interface PRRecordViewController ()

@end

@implementation PRRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id child = [self.childViewControllers firstObject];
    
    if ([child isKindOfClass:[UITabBarController class]]) {
        tabController = child;
        tabController.tabBar.hidden = YES;
        [tabController setSelectedIndex:0];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self refreshFooterView];
}

-(void)segmentChanged:(id)sender
{
    NSInteger selectedTab = visibleSelector.selectedSegmentIndex;
    
    if (selectedTab < tabController.viewControllers.count) {
        [tabController setSelectedIndex:selectedTab];
    }
    
    [self refreshFooterView];
}

#pragma mark - Navigation

-(void)refreshFooterView
{
    nextButton.enabled = tabController.selectedIndex < tabController.viewControllers.count - 1;
    prevButton.enabled = tabController.selectedIndex > 0;
}

-(void)goNext:(id)sender
{
    UIViewController *currentVC = tabController.selectedViewController;
    
    if ([currentVC isKindOfClass:[PRQuestionaireViewController class]]) {
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) currentVC;
        
        if ([qvc canGoToNextQuestion]) {
            [qvc goToNextQuestion];
            return;
        }
    }
    
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab < tabController.viewControllers.count - 1) {
        [visibleSelector setSelectedSegmentIndex:currentTab + 1];
        [self segmentChanged:self];
    }
}

-(void)goPrevious:(id)sender
{
    UIViewController *currentVC = tabController.selectedViewController;
    
    if ([currentVC isKindOfClass:[PRQuestionaireViewController class]]) {
        PRQuestionaireViewController *qvc = (PRQuestionaireViewController *) currentVC;
        
        if ([qvc canGoToPreviousQuestion]) {
            [qvc goToPreviousQuestion];
            return;
        }
    }
    
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab > 0) {
        [visibleSelector setSelectedSegmentIndex:currentTab - 1];
        [self segmentChanged:self];
    }
}

-(void)goHome:(id)sender
{
    NSString *alertTitle = @"Go Home";
    NSString *alertMessage = @"Returning to the ward select screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Go Home";
    NSString *cancelTitle = @"Cancel";
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
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
        alert.tag = ALERT_GO_HOME;
        [alert show];
    }
}

-(void)goToTitle:(id)sender
{
    NSString *alertTitle = @"Cancel Record";
    NSString *alertMessage = @"Returning to the title screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Cancel Record";
    NSString *cancelTitle = @"Continue";
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
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
        alert.tag = ALERT_GO_TITLE;
        [alert show];
    }
}

// iOS 8 Deprecation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == ALERT_GO_HOME) {
            [self continueHome];
        }
        
        if (alertView.tag == ALERT_GO_TITLE) {
            [self continueTitle];
        }
    }
}

// iOS 8 Deprecation
-(void)continueHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

// iOS 8 Deprecation
-(void)continueTitle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
