//
//  PRSegmentTabViewController.h
//  TheDistanceKit
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"

/*!
 * @class PRSegmentTabViewController
 * @discussion Main navigation controller throughout the app. This class contains a child tab controller but hides its tab bar. Navigation is controlled using a segmented controler, which is used to switch the tabs. A footview is used to allow easier navigation switching between tabs. 
 
 Subclasses should override configureNext: to change the next button to a done / submit button as appropriate for the final tab if desired. 
 
 Subclasses should override goNext: and goPrevious: to perform internal navigation instead of swapping tabs if desired.
 */
@interface PRSegmentTabViewController : PRViewController <UIAlertViewDelegate>
{
    UITabBarController *tabController;
    
    /// used to hide and show the footer view in showFooterView:animated:.
    IBOutlet NSLayoutConstraint *footerBottomConstraint;
    IBOutlet UIView *footerView;
    IBOutlet UIButton *nextButton;
    IBOutlet UIButton *prevButton;
    
    IBOutlet UISegmentedControl *visibleSelector;
}

-(IBAction)segmentChanged:(id)sender;

/// Navigates to the next tab. Subclasses should override this to perform internal navigation.
-(IBAction)goNext:(id)sender;

/// Navigates to the previous tab. Subclasses should override this to perform internal navigation.
-(IBAction)goPrevious:(id)sender;

-(void)configureNext:(BOOL) isLastSection;
-(void)refreshFooterView;
-(void)showFooterView:(BOOL) show animated:(BOOL) animated;

@end
