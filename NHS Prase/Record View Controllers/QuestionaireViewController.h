//
//  QuestionaireViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRQuestionnaire;

@interface QuestionaireViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    BOOL shouldShowStatement;
    UIPageViewController *pageController;
}

@property (nonatomic, strong) PRQuestionnaire *questionnaire;

@end
