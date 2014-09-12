//
//  PRAnswerOptionsLayout.h
//  NHS Prase
//
//  Created by Josh Campion on 11/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {kLayoutAlignmentLeft, kLayoutAlignmentRight, kLayoutAlignmentCenter} LayoutAlignment;

@protocol PRAnswerOptionsLayoutDelegate <UICollectionViewDelegateFlowLayout>

-(CGFloat)maximumLayoutWidthForCollectionView:(UICollectionView *) collectionView;
-(CGFloat)maximumLayoutHeightForCollectionView:(UICollectionView *) collectionView;
-(CGFloat)collectionView:(UICollectionView *) collectionView heightForCellAtIndexPath:(NSIndexPath *) indexPath constrainedToWidth:(CGFloat) width;
                                       
@end

@interface PRAnswerOptionsLayout : UICollectionViewFlowLayout
{
    CGSize intrinsicSize;
    CGFloat maxTotalWidth;
    CGFloat cellWidth;
    NSInteger sectionCount;
    NSArray *sectionCounts;
    NSArray *sectionWidths;
    NSArray *sectionHeights;
}

@property (nonatomic, assign) LayoutAlignment alignment;

@end
