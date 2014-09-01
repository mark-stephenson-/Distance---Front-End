//
//  PRRecordViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRRecordViewController.h"

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
    }
}

-(void)segmentChanged:(id)sender
{
    NSInteger selectedTab = visibleSelector.selectedSegmentIndex;
    
    if (selectedTab < tabController.viewControllers.count) {
        [tabController setSelectedIndex:selectedTab];
    }
}

@end
