//
//  PRSegmentTabViewController.m
//  TheDistanceKit
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSegmentTabViewController.h"

#import "PRTheme.h"

@interface PRSegmentTabViewController ()

@end

@implementation PRSegmentTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id child = [self.childViewControllers firstObject];
    
    if ([child isKindOfClass:[UITabBarController class]]) {
        tabController = child;
        tabController.tabBar.hidden = YES;
        [tabController setSelectedIndex:0];
    }
    
    segmentSelector.bounces = NO;
    segmentSelector.showsHorizontalScrollIndicator = NO;
    segmentSelector.showsVerticalScrollIndicator = NO;
    
    segmentCellTextInsets = UIEdgeInsetsMake(8, 25, 8, 25);
//    visibleSelector.textBuffer = 25.0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshFooterView];
    
    NSIndexPath *zeroPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [segmentSelector selectItemAtIndexPath:zeroPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

-(void)applyTheme
{
    [super applyTheme];
    
    [self calculateCellSizes];
}

#pragma mark - View Configuration

-(void)configureNext:(BOOL) isLastSection
{
    
}

-(void)refreshFooterView
{
    nextButton.enabled = YES;
    prevButton.enabled = tabController.selectedIndex > 0;
    
    [self configureNext:tabController.selectedIndex == tabController.viewControllers.count - 1];
    
    if (footerBottomConstraint.constant != 0.0) {
        footerBottomConstraint.constant = [footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [self.view layoutIfNeeded];
    }
}

-(void)showFooterView:(BOOL)show animated:(BOOL)animated
{
    CGSize footerSize = [footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (animated) {
        [UIView animateWithDuration:0.35 animations:^{
            footerBottomConstraint.constant = show ? 0.0 : footerSize.height;
            [self.view layoutIfNeeded];
        }];
    } else {
        footerBottomConstraint.constant = show ? 0.0 : footerSize.height;
    }
}

#pragma mark - CollectionView Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == segmentSelector) {
        return 1;
    }
    
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == segmentSelector) {
        return segmentTitles.count;
    }
    
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == segmentSelector) {
        NSString *cellIdentifier = @"TabCell";
        
        TDCollectionViewCell *tdCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        tdCell.textLabelTD.text = segmentTitles[indexPath.item];
        
        [self applyThemeToView:tdCell];
        
        return tdCell;
    }
    
    return nil;
}

#pragma mark Sizing Methods

-(void)calculateCellSizes
{
    NSMutableDictionary *tempCellSizes = [NSMutableDictionary dictionary];
    
    CGFloat totalWidth = 0.0;
    CGFloat maxHeight = 0.0;
    
    // calculate all the fitting sizes, these may be adjusted if the total is too small
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) segmentSelector.collectionViewLayout;
    for (int t = 0; t < segmentTitles.count; t++) {
        NSIndexPath *thisPath = [NSIndexPath indexPathForItem:t inSection:0];
        
        CGSize fittingSize = [self calculateFittingSizeForCollectionView:segmentSelector layout:flowLayout itemAtIndexPath:thisPath];
        
        tempCellSizes[thisPath] = [NSValue valueWithCGSize:fittingSize];
        totalWidth += fittingSize.width + flowLayout.minimumLineSpacing;
        
        if (fittingSize.height > maxHeight) {
            maxHeight = fittingSize.height;
        }
    }
    
    totalWidth += flowLayout.sectionInset.left + flowLayout.sectionInset.right - flowLayout.minimumLineSpacing;
    
    CGFloat difference = self.view.bounds.size.width - totalWidth;
    CGFloat widthAdjustment = 0.0;
    if (difference > 0) {
        widthAdjustment = difference / segmentTitles.count;
    }
    
    // adjust the fitting values to ensure all the cells are the same height
    for (int t = 0; t < segmentTitles.count; t++) {
        NSIndexPath *thisPath = [NSIndexPath indexPathForItem:t inSection:0];
        
        CGSize cellSize = [tempCellSizes[thisPath] CGSizeValue];
        // add extra padding to ensure the cells fill the width of the screen
        cellSize.width += widthAdjustment;
        
        // ensure all the cells are the same height
        if (cellSize.height != maxHeight) {
            cellSize.height = maxHeight;
        }
        
        tempCellSizes[thisPath] = [NSValue valueWithCGSize:cellSize];
    }
    
    // ensure the collection view is marginally larger than the cells to give a small border around the edge
    segmentSelectorHeightConstraint.constant = maxHeight + flowLayout.sectionInset.top + flowLayout.sectionInset.bottom;
    segmentCellSizes = tempCellSizes;
    [segmentSelector.collectionViewLayout invalidateLayout];
    [self.view layoutIfNeeded];
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == segmentSelector) {
        if (segmentCellSizes[indexPath]  != nil) {
            return [segmentCellSizes[indexPath] CGSizeValue];
        }
        
        return CGSizeMake(120, 40);
    }
    
    return CGSizeZero;
}

-(CGSize)calculateFittingSizeForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == segmentSelector) {
        NSString *cellText = segmentTitles[indexPath.item];
        UIFont *font = [[PRTheme sharedTheme] preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        CGSize cellSize = [cellText sizeWithAttributes:@{NSFontAttributeName: font}];
        cellSize.width += segmentCellTextInsets.left + segmentCellTextInsets.right + 2.0;
        cellSize.height += segmentCellTextInsets.top + segmentCellTextInsets.bottom + 2.0;
        
        if (segmentSelectorHeightConstraint.constant != cellSize.height) {
            segmentSelectorHeightConstraint.constant = cellSize.height + 3.0; // leave a 1pt border around the collection view to make it look like a border on the cell.
        }
        
        return cellSize;
    }
    
    return CGSizeZero;
}

#pragma mark Selection Methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    TDCollectionViewCell *tdCell = (TDCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
//    tdCell.contentView.backgroundColor = [[PRTheme sharedTheme] mainColor];
//    tdCell.textLabelTD.textColor = [UIColor whiteColor];
    
    [self selectSegment:indexPath.item];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDCollectionViewCell *tdCell = (TDCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [tdCell layoutSubviews];
//    tdCell.contentView.backgroundColor = [UIColor whiteColor];
//    tdCell.textLabelTD.textColor = [[PRTheme sharedTheme] mainColor];
}

#pragma mark - Navigation

-(void)selectSegment:(NSInteger) segment
{
    NSIndexPath *oldSegmentPath = [[segmentSelector indexPathsForSelectedItems] firstObject];

    NSIndexPath *segmentPath = [NSIndexPath indexPathForItem:segment inSection:0];
    // programmatic calls don't call the delegate so this won't be cyclic, but will center the collection view
    [segmentSelector selectItemAtIndexPath:segmentPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [[segmentSelector cellForItemAtIndexPath:segmentPath] layoutSubviews];
    
    if (oldSegmentPath != nil) {
        [[segmentSelector cellForItemAtIndexPath:oldSegmentPath] layoutSubviews];
    }
    
    if (segment >= 0 && segment <= segmentTitles.count) {
        [tabController setSelectedIndex:segment];
    }
    
    [self refreshFooterView];
}

/*
-(void)segmentChanged:(id)sender
{
    NSInteger selectedTab = visibleSelector.selectedSegmentIndex;
    
    if (selectedTab < tabController.viewControllers.count) {
        [tabController setSelectedIndex:selectedTab];
    }
    
    [self refreshFooterView];
}
*/

-(void)goNext:(id)sender
{
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab < tabController.viewControllers.count - 1) {
        [self selectSegment:currentTab + 1];
//        [visibleSelector setSelectedSegmentIndex:currentTab + 1];
//        [self segmentChanged:self];
    }
    
    [self refreshFooterView];
}

-(void)goPrevious:(id)sender
{
    NSInteger currentTab = tabController.selectedIndex;
    
    if (currentTab > 0) {
        [self selectSegment:currentTab - 1];
//        [visibleSelector setSelectedSegmentIndex:currentTab - 1];
//        [self segmentChanged:self];
    }
    
    [self refreshFooterView];
}

@end
