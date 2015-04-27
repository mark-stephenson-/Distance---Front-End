//
//  PRSegmentTabViewController.h
//  TheDistanceKit
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"

@class TDSegmentedControl;

/*!
 * @class PRSegmentTabViewController
 * @discussion Main navigation controller throughout the app. This class contains a child tab controller but hides its tab bar. Navigation is controlled using a segmented controler, which is used to switch the tabs. A footview is used to allow easier navigation switching between tabs. 
 
 Subclasses should override configureNext: to change the next button to a done / submit button as appropriate for the final tab if desired. 
 
 Subclasses should override goNext: and goPrevious: to perform internal navigation instead of swapping tabs if desired.
 */
@interface PRSegmentTabViewController : PRViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UIView *containerView;
    UITabBarController *tabController;
    
    /// used to hide and show the footer view in showFooterView:animated:.
    __weak IBOutlet NSLayoutConstraint *footerBottomConstraint;
    __weak IBOutlet UIView *footerView;
    __weak IBOutlet UIButton *nextButton;
    __weak IBOutlet UIButton *prevButton;
    __weak IBOutlet UIButton *settingsButton;
    
    __weak IBOutlet UICollectionView *segmentSelector;
    __weak IBOutlet NSLayoutConstraint *segmentSelectorHeightConstraint;
    NSArray *segmentTitles;
    /// The buffers between the segment title text label and the edge of the cell. These are enforced using UIView's layoutMargins property.
    UIEdgeInsets segmentCellTextInsets;
    NSDictionary *segmentCellSizes;
//    IBOutlet TDSegmentedControl *visibleSelector;
    //IBOutlet NSLayoutConstraint *selectorHeight;
}

-(void)selectSegment:(NSInteger) segment;
//-(IBAction)segmentChanged:(id)sender;

/// Navigates to the next tab. Subclasses should override this to perform internal navigation.
-(IBAction)goNext:(id)sender;

/// Navigates to the previous tab. Subclasses should override this to perform internal navigation.
-(IBAction)goPrevious:(id)sender;

-(void)configureNext:(BOOL) isLastSection;
-(void)refreshFooterView;
-(void)showFooterView:(BOOL) show animated:(BOOL) animated;

@end
