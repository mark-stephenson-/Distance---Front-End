//
//  PRFormViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRFormViewController.h"

@interface PRFormViewController ()

@end

@implementation PRFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    tableHeight.constant = self.tableView.contentSize.height;
    
    [self.view layoutIfNeeded];
}

@end
