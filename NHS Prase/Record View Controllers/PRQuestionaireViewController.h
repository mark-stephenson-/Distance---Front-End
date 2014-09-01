//
//  QuestionaireViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRQuestionnaire;

@interface PRQuestionaireViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    BOOL shouldShowStatement;
    UIPageViewController *pageController;
}

@property (nonatomic, strong) PRQuestionnaire *questionnaire;

/// The index of the question currently on screen. Question indexes are 1 higher than their entry in self.questionnaire.questions as the first question here is the statement page.
@property (nonatomic, assign) NSInteger currentQuestion;


-(BOOL)canGoToNextQuestion;
-(BOOL)canGoToPreviousQuestion;

-(void)goToNextQuestion;
-(void)goToPreviousQuestion;

@end
