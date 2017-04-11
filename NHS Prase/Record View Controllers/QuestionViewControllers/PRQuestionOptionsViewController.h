//
//  PRQuestionOptionsViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionViewController.h"
#import "PRAnswerOptionsLayout.h"

@class PRQuestionOptions;

@interface PRQuestionOptionsViewController : PRQuestionViewController <UICollectionViewDataSource, PRAnswerOptionsLayoutDelegate>
{
    IBOutlet UIView *collectionContainer;
    IBOutlet NSLayoutConstraint *collectionViewWidthConstraint;
    IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
    
    NSMutableDictionary *layoutCells;
    UILabel *layoutLabel;
}

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
