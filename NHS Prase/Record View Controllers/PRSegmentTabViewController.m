//
//  PRSegmentTabViewController.m
//  TheDistanceKit
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSegmentTabViewController.h"

#import "PRTheme.h"

@interface PRSegmentTabViewController ()

@end

@implementation PRSegmentTabViewController

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



-(void)showAlertWithTitle:(NSString *) alertTitle message:(NSString *) alertMessage buttonTitle:(NSString *) buttonTitle buttonCompletion:(void (^)(void)) completion cancelTitle:(NSString *) cancelTitle alertTag:(NSInteger) tag
{
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                              if (completion != nil) {
                                                                  completion();
                                                              }
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
        alert.tag = tag;
        [alert show];
    }
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    
}

-(void)refreshFooterView
{
    nextButton.enabled = YES;
    prevButton.enabled = tabController.selectedIndex > 0;
    
    [self configureNext:tabController.selectedIndex == tabController.viewControllers.count - 1];
    
    if (footerBottomConstraint.constant != 0.0) {
        footerBottomConstraint.constant = [footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [self.view layoutIfNeeded];
    }
}

-(void)showFooterView:(BOOL)show animated:(BOOL)animated
{
    CGSize footerSize = [footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (animated) {
        [UIView animateWithDuration:0.35 animations:^{
            footerBottomConstraint.constant = show ? 0.0 : footerSize.height;
            [self.view layoutIfNeeded];
        }];
    } else {
        footerBottomConstraint.constant = show ? 0.0 : footerSize.height;
    }
}

#pragma mark - Navigation

-(void)segmentChanged:(id)sender
{
    NSInteger selectedTab = visibleSelector.selectedSegmentIndex;
    
    if (selectedTab < tabController.viewControllers.count) {
        [tabController setSelectedIndex:selectedTab];
    }
    
    [self refreshFooterView];
}


-(void)goNext:(id)sender
{
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab < tabController.viewControllers.count - 1) {
        [visibleSelector setSelectedSegmentIndex:currentTab + 1];
        [self segmentChanged:self];
    }
}

-(void)goPrevious:(id)sender
{
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab > 0) {
        [visibleSelector setSelectedSegmentIndex:currentTab - 1];
        [self segmentChanged:self];
    }
}

@end
