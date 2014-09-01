//
//  PRRecordViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRRecordViewController : UIViewController <UIAlertViewDelegate>
{
    UITabBarController *tabController;
    IBOutlet UISegmentedControl *visibleSelector;
    
    IBOutlet UIButton *nextButton;
    IBOutlet UIButton *prevButton;
}

-(IBAction)segmentChanged:(id)sender;
-(IBAction)goNext:(id)sender;
-(IBAction)goPrevious:(id)sender;
-(IBAction)goHome:(id)sender;
-(IBAction)goToTitle:(id)sender;

@end
