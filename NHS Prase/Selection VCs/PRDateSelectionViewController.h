//
//  PRDateSelectionViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TheDistanceKit/TheDistanceKit.h>

@class PRDateSelectionViewController;

@protocol PRDateSelectionDelegate <NSObject>

-(void)dateSelectionViewControllerRequestsDismissal:(PRDateSelectionViewController *) dateSelector;
-(void)dateSelectionViewControllerRequestsCancel:(PRDateSelectionViewController *) dateSelector;

@end

@interface PRDateSelectionViewController : UIViewController
{
    IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, weak) id<PRDateSelectionDelegate> selectionDelegate;

-(IBAction)cancelSelectionViewController:(id)sender;
-(IBAction)dismissSelectionViewController:(id)sender;

@end
