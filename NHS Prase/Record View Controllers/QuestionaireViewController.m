//
//  QuestionaireViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "QuestionaireViewController.h"

#import "PRQuestionnaire.h"
#import "PRQuestion.h"
#import "PRQuestionStatement.h"
#import "PRQuestionOptions.h"

#import "PRQuestionViewController.h"
#import "PRQuestionStatementViewController.h"
#import "PRQuestionOptionsViewController.h"

@interface QuestionaireViewController ()

@end

@implementation QuestionaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up for prototype only
    
    self.questionnaire = [PRQuestionnaire prototypeQuestionnaire];
    
    // end prototype set up
    
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                   options:nil];
    
    pageController.dataSource = self;
    pageController.delegate = self;
    
    [self resetPageViewController];
    
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
}

-(void)resetPageViewController
{
    shouldShowStatement = YES;
    
    PRQuestionViewController *q0 = [self viewControllerForIndex:0];
    
    [pageController setViewControllers:@[q0]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    static BOOL added = NO;
    
    if (!added) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[page]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"page":pageController.view}]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[page]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"page":pageController.view}]];
        
        added = YES;
    }
}

#pragma mark - Questionnaire Methods

-(void)setQuestionnaire:(PRQuestionnaire *)questionnaire
{
    if (_questionnaire != nil) {
        // clear the existing questionnaire and remove any saved view controllers
    }
    
    _questionnaire = questionnaire;
    
    [self resetPageViewController];
}

#pragma mark - Page Data Source

-(PRQuestionViewController *)viewControllerForIndex:(NSInteger) idx
{
    if (idx == 0) {
        
        if (shouldShowStatement) {
            shouldShowStatement = NO;
            return [self.storyboard instantiateViewControllerWithIdentifier:@"StatementVC"];
        } else {
            return nil;
        }
        
    } else if (idx > 0 && idx - 1 < self.questionnaire.questions.count) {
        PRQuestion *thisQuestion = self.questionnaire.questions[idx - 1];
        
        PRQuestionViewController *qvc = nil;
        
        
        if ([thisQuestion isKindOfClass:[PRQuestionStatement class]]) {
            
            PRQuestionStatementViewController *statementVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionStatementVC"];
            
            qvc = statementVC;
            
        } else if ([thisQuestion isKindOfClass:[PRQuestionOptions class]]){
            PRQuestionOptionsViewController *optionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionOptionsVC"];
            
            qvc = optionsVC;
        }
        
        qvc.question = thisQuestion;
        qvc.questionIndex = idx;
        
        return qvc;
    } else {
        return nil;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger idx = ((PRQuestionViewController *)viewController).questionIndex;
    
    return [self viewControllerForIndex:idx - 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger idx = ((PRQuestionViewController *)viewController).questionIndex;
    
    return [self viewControllerForIndex:idx + 1];
}

#pragma mark - Page Delegate

@end
