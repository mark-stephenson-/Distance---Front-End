//
//  PRQuestionOptionsViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <NHSPraseKit/NHSPraseKit.h>
#import "PRQuestionViewController.h"
#import "PRAnswerOptionsLayout.h"

@class PRQuestionOptions;

@interface PRQuestionOptionsViewController : PRQuestionViewController <UICollectionViewDataSource, PRAnswerOptionsLayoutDelegate>
{
    IBOutlet UIView *collectionContainer;
    IBOutlet NSLayoutConstraint *collectionViewWidthConstraint;
    IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
    
    CGSize oldViewSize;
    
    NSMutableDictionary *layoutCells;
}

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
