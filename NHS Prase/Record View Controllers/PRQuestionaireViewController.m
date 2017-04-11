//
//  QuestionaireViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionaireViewController.h"

#import "PRQuestion.h"
#import "PRPMOSQuestion.h"

#import "PRQuestionViewController.h"
#import "PRQuestionStatementViewController.h"
#import "PRQuestionOptionsViewController.h"

@interface PRQuestionaireViewController ()

@end

@implementation PRQuestionaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                   options:nil];
    
    // pageController.dataSource = self;
    pageController.delegate = self;
    
    [self resetPageViewController];
    
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
}

-(void)resetPageViewController
{
    shouldShowStatement = YES;
    
    PRQuestionViewController *q0 = [self viewControllerForIndex:-1];
    
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

#pragma mark - Pseudo Property

-(NSInteger)currentQuestion
{
    NSInteger currentQuestion = [(PRQuestionViewController *)[pageController.viewControllers firstObject] questionIndex];
    return currentQuestion;
}

-(void)setCurrentQuestion:(NSInteger)currentQuestion
{
    NSInteger cq = self.currentQuestion;
    
    if (cq != currentQuestion) {
        PRQuestionViewController *q = [self viewControllerForIndex:currentQuestion];
        
        [pageController setViewControllers:@[q]
                                 direction:currentQuestion > cq ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse
                                  animated:NO
                                completion:nil];
    }
    
}

#pragma mark - Questionnaire Methods

-(void)setQuestions:(NSArray *)questions
{
    _questions = questions;
    
    [self resetPageViewController];
}

-(BOOL)canGoToNextQuestion
{
    return self.currentQuestion < self.questions.count - 1.0;
}

-(BOOL)canGoToPreviousQuestion
{
    return self.currentQuestion > 0;
}

-(void)goToNextQuestion
{
    if ([self canGoToNextQuestion]) {
        UIViewController *nextVC = [self viewControllerForIndex:self.currentQuestion + 1];

        [pageController setViewControllers:@[nextVC]
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:YES
                                completion:^(BOOL finished) {
                                    [nextVC.view performSelector:@selector(layoutIfNeeded) withObject:nil afterDelay:1];
                                }];
    }
}

-(void)goToPreviousQuestion
{
    if ([self canGoToPreviousQuestion]) {

        UIViewController *prevVC = [self viewControllerForIndex:self.currentQuestion - 1];

        [pageController setViewControllers:@[prevVC]
                                 direction:UIPageViewControllerNavigationDirectionReverse
                                  animated:YES
                                completion:^(BOOL finished) {
                                    [prevVC.view performSelector:@selector(layoutIfNeeded) withObject:nil afterDelay:1];
                                }];
    }
}

#pragma mark - Page Data Source

/// Primary data source method for the UIPageViewController. nil is returned if there is no question for the given index. Index -1 corresponds to the statement screen, which is only should once.
-(PRQuestionViewController *)viewControllerForIndex:(NSInteger) idx
{
    if (idx < 0) {
        
        if (shouldShowStatement) {
            shouldShowStatement = NO;
            PRQuestionViewController *statementVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StatementVC"];
            statementVC.questionIndex = -1;
            return statementVC;
        } else {
            return nil;
        }
        
    } else if (idx >= 0 && idx < self.questions.count) {
        PRQuestion *thisQuestion = self.questions[idx];
        
        PRQuestionViewController *qvc = nil;
        
        
        if (thisQuestion.pmosQuestion.answerSets.count == 0) {
            
            PRQuestionStatementViewController *statementVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionStatementVC"];
            qvc = statementVC;
            
        } else {
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

@end
