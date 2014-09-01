//
//  PRRecordViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRRecordViewController : UIViewController
{
    UITabBarController *tabController;
    IBOutlet UISegmentedControl *visibleSelector;
}

-(IBAction)segmentChanged:(id)sender;

@end
