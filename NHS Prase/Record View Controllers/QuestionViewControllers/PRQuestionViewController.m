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
}


@end
