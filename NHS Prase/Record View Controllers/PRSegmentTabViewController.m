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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSString *textStyle = [[TDTheme sharedTheme] textStyleForIdentifier:visibleSelector.TDTextStyleIdentifier];
    UIFont *selectorFont = [[TDTheme sharedTheme] preferredFontForTextStyle:textStyle];
    selectorHeight.constant = 30 + selectorFont.pointSize;
    
    [self.view layoutIfNeeded];
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
    
    [self refreshFooterView];
}

-(void)goPrevious:(id)sender
{
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab > 0) {
        [visibleSelector setSelectedSegmentIndex:currentTab - 1];
        [self segmentChanged:self];
    }
    
    [self refreshFooterView];
}

@end
