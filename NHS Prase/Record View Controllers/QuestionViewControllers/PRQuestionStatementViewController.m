//
//  PRStatementQuestionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionStatementViewController.h"

#import "PRQuestionStatement.h"

@interface PRQuestionStatementViewController ()

@end

@implementation PRQuestionStatementViewController

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
    
    statementLabel.text = statementQuestion.statement;
    titleLabel.text = [NSString stringWithFormat:@"Q%ld: %@", self.questionIndex + 1, statementQuestion.questionTitle];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.question.answer = @YES;
}

-(void)setQuestion:(PRQuestion *)question
{
    if ([question isKindOfClass:[PRQuestionStatement class]]) {
        [super setQuestion:question];
        statementQuestion = (PRQuestionStatement *) question;
        
        titleLabel.text = statementQuestion.questionTitle;
        statementLabel.text = statementQuestion.statement;
    }
}

@end
