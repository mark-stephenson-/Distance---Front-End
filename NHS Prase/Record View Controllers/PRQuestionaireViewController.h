//
//  QuestionaireViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRQuestionnaire;

/*!
 * @class PRQuestionaireViewController
 * @discussion Displays the questionnaire by dynamically creating each question as a page in a UIPageViewController. This class is queried by the PRRecordViewController whether internal navigation between questions can occur using the canGoToNextQuestion and canGoToPreviousQuestion methods.
 */
@interface PRQuestionaireViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    /// Flag to track whether the statement screen has been displayed, as the user should only see it once.
    BOOL shouldShowStatement;
    UIPageViewController *pageController;
}

@property (nonatomic, strong) PRQuestionnaire *questionnaire;

/// The index of the question currently on screen. Question indexes are as they appear in self.questionnaire.questions. The first question is the statement page which is given index -1.
@property (nonatomic, assign) NSInteger currentQuestion;


-(BOOL)canGoToNextQuestion;
-(BOOL)canGoToPreviousQuestion;

-(void)goToNextQuestion;
-(void)goToPreviousQuestion;

@end
