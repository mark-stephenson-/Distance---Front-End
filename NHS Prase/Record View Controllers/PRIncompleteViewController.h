//
//  PRIncompleteViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 11/03/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "PRViewController.h"
#import "PRInputAccessoryView.h"

@class PRIncompleteViewController;

@protocol PRIncompleteViewControllerDelegate <NSObject>

-(void)incompleteViewController:(PRIncompleteViewController *) incompleteViewController completedWithText:(NSString *) text;
-(void)incompleteViewControllerDidCancel:(PRIncompleteViewController *) incompleteViewController;

@end

/*!
 * @class PRIncompleteViewController
 * @discussion Simple class displayed from the record vc if the user chooses to submit an incomplete record. When the done button is pressed, a simple delegate method is called. The done button is only enabled when the user has entered some text. PRRecordViewController implements the delegate protocol to dismiss this view controller.
 */
@interface PRIncompleteViewController : PRViewController<TDInputAccessoryDelegate, UITextViewDelegate>
{
    __weak IBOutlet UIView *containerView;
    __weak IBOutlet UITextView *textView;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *subtitleLabel;
    __weak IBOutlet UIButton *doneButton;
    
    PRInputAccessoryView *inputView;
}

@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, weak) id<PRIncompleteViewControllerDelegate> delegate;

-(IBAction)done:(id)sender;
-(IBAction)cancel:(id)sender;

@end
