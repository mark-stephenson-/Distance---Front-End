//
//  PRQuestionOptionsViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionViewController.h"

@class PRQuestionOptions;

@interface PRQuestionOptionsViewController : PRQuestionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    PRQuestionOptions *optionsQuestion;
}

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
