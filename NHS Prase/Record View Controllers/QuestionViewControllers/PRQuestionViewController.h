//
//  PRQuestionViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PRNoteViewController.h"

@class PRQuestion;

@interface PRQuestionViewController : UIViewController <PRNoteDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *pirtView;
    
}

@property (nonatomic, strong) PRQuestion *question;
@property (nonatomic, assign) NSInteger questionIndex;

@property (nonatomic, assign) BOOL shouldHidePIRTView;

@end
