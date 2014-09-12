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
    
    TDLocalizedStringWithDefaultValue(@"question.statement", nil, nil, @"Please add a concern, something good or a note to articulate as appropriate:", @"The text displayed if a question has no options to select from.");
    statementLabel.TDLocalizedStringKey = @"question.statement";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    statementLabel.text = statementQuestion.statement;
    titleLabel.text = [NSString stringWithFormat:@"Q%ld: %@", self.questionIndex + 1, statementQuestion.questionID];
}

-(void)configureQuestionLabel
{
    //NSString *localizedPrefix = NSLocalizeds
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.question.answerID = @"";
}

-(void)setQuestion:(PRQuestion *)question
{
    [super setQuestion:question];
    
    titleLabel.TDLocalizedStringKey = TDLocalizedStringWithDefaultValue(question.questionID, nil, nil, nil, nil);
}

@end
