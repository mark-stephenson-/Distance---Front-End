//
//  PRStatementQuestionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionStatementViewController.h"

@interface PRQuestionStatementViewController ()

@end

@implementation PRQuestionStatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    statementLabel.text = TDLocalizedStringWithDefaultValue(@"question.statement", nil, nil, @"Please add a concern, something good or a note to articulate as appropriate:", @"The text displayed if a question has no options to select from.");
    statementLabel.TDLocalizedStringKey = @"question.statement";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
