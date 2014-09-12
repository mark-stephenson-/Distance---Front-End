//
//  PRAnswerOptionsLayout.m
//  NHS Prase
//
//  Created by Josh Campion on 11/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRAnswerOptionsLayout.h"
#import <NHSPraseKit/NHSPraseKit.h>

#define CELL_MAX_WIDTH 140

@interface PRAnswerOptionsLayout()
{
    /// An internal reference to the specific delegate if appropriate
    id<PRAnswerOptionsLayoutDelegate> prDelegate;
}

@end

@implementation PRAnswerOptionsLayout


-(void)awakeFromNib
{
    [super awakeFromNib];
    self.alignment = kLayoutAlignmentCenter;
}

-(id<PRAnswerOptionsLayoutDelegate>)prDelegate
{
    if (prDelegate == nil || self.collectionView.delegate != prDelegate) {
        if ([self.collectionView.delegate conformsToProtocol:@protocol(PRAnswerOptionsLayoutDelegate)]) {
            prDelegate = (id<PRAnswerOptionsLayoutDelegate>) self.collectionView.delegate;
        }
    }
    
    return prDelegate;
}

// As this is displaying a small amount of static data we can re-calculate in full each time
-(void)prepareLayout
{
    // store the data-source information structures
    sectionCount = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
    NSMutableArray *tempSectionCounts = [NSMutableArray arrayWithCapacity:sectionCount];
    
    for (int s = 0; s < sectionCount; s++) {
        NSInteger thisSectionCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:s];
        
        [tempSectionCounts addObject:@(thisSectionCount)];
    }
    
    sectionCounts = [NSArray arrayWithArray:tempSectionCounts];
    
    // calculate the fitting widths
    maxTotalWidth = 0.0;
    
    if ([self prDelegate] != nil) {
        maxTotalWidth = [prDelegate maximumLayoutWidthForCollectionView:self.collectionView];
    } else {
        maxTotalWidth = self.collectionView.frame.size.width;
    }
    
    cellWidth = floorf(MIN(CELL_MAX_WIDTH, maxTotalWidth / [[sectionCounts valueForKeyPath:@"@max.self"] floatValue]));
    
    // calculate the fitting heights
    NSMutableArray *tempSectionHeights = [NSMutableArray arrayWithCapacity:sectionCount];
    
    if ([self prDelegate] != nil) {
        
        for (int s = 0; s < sectionCount; s++) {
            CGFloat maxHeight = CELL_MAX_WIDTH;
            NSInteger thisSectionCount = [sectionCounts[s] integerValue];
            
            for (int c = 0; c < thisSectionCount; c++) {
                CGFloat thisHeight = [prDelegate collectionView:self.collectionView heightForCellAtIndexPath:[NSIndexPath indexPathForItem:c inSection:s] constrainedToWidth:cellWidth];
                
                if (thisHeight > maxHeight) {
                    maxHeight = thisHeight;
                }
            }
            
            [tempSectionHeights addObject:@(maxHeight)];
        }
    } else {
        CGFloat cellHeight = cellWidth * 1.2;
        
        for (int s = 0; s < sectionCount; s++) {
            [tempSectionHeights addObject:@(cellHeight)];
        }
    }
    
    sectionHeights = [NSArray arrayWithArray:tempSectionHeights];
    
    NSMutableArray *tempSectionWidths = [NSMutableArray arrayWithCapacity:sectionCount];
    
    for (int s = 0; s < sectionCount; s++) {
        CGFloat thisWidth = [sectionCounts[s] integerValue] * cellWidth;
        [tempSectionWidths addObject:@(thisWidth)];
    }
    
    sectionWidths = [NSArray arrayWithArray:tempSectionWidths];
}

-(CGSize)collectionViewContentSize
{
    CGFloat contentWidth = [[sectionWidths valueForKeyPath:@"@max.self"] floatValue];
    CGFloat contentHeight = (self.minimumLineSpacing * (sectionCount - 1)) + [[sectionHeights valueForKeyPath:@"@sum.self"] floatValue];
    intrinsicSize = CGSizeMake(contentWidth, contentHeight);
    
    return intrinsicSize;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:[[sectionCounts valueForKeyPath:@"@sum.self"] integerValue]];
    for (int s = 0; s < sectionCount; s++) {
        NSInteger thisSectionCount = [sectionCounts[s] integerValue];
        
        for (int c = 0; c < thisSectionCount; c++) {
            UICollectionViewLayoutAttributes *thisAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:c inSection:s]];
            [allAttributes addObject:thisAttributes];
        }
    }
    
    return allAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *cellAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat cellHeight = [sectionHeights[indexPath.section] floatValue];
    CGRect cellFrame = CGRectMake(0, 0, cellWidth, cellHeight);
    
    switch (self.alignment) {
        case kLayoutAlignmentLeft:
            cellFrame.origin.x = (indexPath.row) * (cellWidth - OPTIONS_CELL_BORDER_WIDTH);
            break;
        case kLayoutAlignmentRight:
            cellFrame.origin.x = intrinsicSize.width - (indexPath.row + 1) * (cellWidth - OPTIONS_CELL_BORDER_WIDTH) - OPTIONS_CELL_BORDER_WIDTH;
            break;
        case kLayoutAlignmentCenter:
            cellFrame.origin.x = (intrinsicSize.width - [sectionWidths[indexPath.section] floatValue]) / 2.0 + (indexPath.row) * (cellWidth - OPTIONS_CELL_BORDER_WIDTH);
            break;
        default:
            break;
    }
    
    cellFrame.origin.y = (indexPath.section) * (cellHeight + self.minimumLineSpacing);
    
    cellAttributes.frame = cellFrame;
    
    return cellAttributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return !CGSizeEqualToSize(newBounds.size, self.collectionView.bounds.size);
}


@end
