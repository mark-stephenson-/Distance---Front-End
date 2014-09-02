//
//  PRSegmentTabViewController.h
//  TheDistanceKit
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRSegmentTabViewController : UIViewController
{
    UITabBarController *tabController;
    
    IBOutlet NSLayoutConstraint *footerBottomConstraint;
    IBOutlet UIView *footerView;
    IBOutlet UISegmentedControl *visibleSelector;
    IBOutlet UIButton *nextButton;
    IBOutlet UIButton *prevButton;
}

-(IBAction)segmentChanged:(id)sender;
-(IBAction)goNext:(id)sender;
-(IBAction)goPrevious:(id)sender;

-(void)showAlertWithTitle:(NSString *) alertTitle message:(NSString *) alertMessage buttonTitle:(NSString *) buttonTitle buttonCompletion:(void (^)(void)) completion cancelTitle:(NSString *) cancelTitle alertTag:(NSInteger) tag;

-(void)refreshFooterView;
-(void)showFooterView:(BOOL) show animated:(BOOL) animated;

@end
