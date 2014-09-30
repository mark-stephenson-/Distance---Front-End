//
//  PRPIRTQuestionsViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionOptionsViewController.h"

@class PRImageView;

@interface PRPIRTQuestionsViewController : PRQuestionOptionsViewController
{
    IBOutlet UICollectionView *q1CV;
    IBOutlet UICollectionView *q2CV;
    
    IBOutlet NSLayoutConstraint *q1WidthConstr;
    IBOutlet NSLayoutConstraint *q2WidthConstr;
    
    IBOutlet PRImageView *sadFace;
    IBOutlet PRImageView *notSadFace;
}

@property (nonatomic, strong) PRQuestion *seriousQuestion;
@property (nonatomic, strong) PRQuestion *preventQuestion;

@end
