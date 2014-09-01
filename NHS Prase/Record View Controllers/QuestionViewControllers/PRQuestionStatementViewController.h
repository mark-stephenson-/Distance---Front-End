//
//  PRStatementQuestionViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionViewController.h"

@class PRQuestionStatement;

@interface PRQuestionStatementViewController : PRQuestionViewController
{
    PRQuestionStatement *statementQuestion;
    IBOutlet UILabel *statementLabel;
}

@end
