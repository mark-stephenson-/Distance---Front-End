//
//  PRNoteViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"

@class TDTextView;
@class PRNoteViewController;

@protocol PRNoteDelegate <NSObject>

@optional

-(void)noteViewControllerDidFinish:(PRNoteViewController *) noteVC;
-(void)noteViewControllerCancelled:(PRNoteViewController *) noteVC;

@end

/*!
 * @class PRNoteViewController
 * @discussion Contains the UI and functionality for adding detailed information. This is used to add notes, something good and in the concern PIRT workflow. As this is either presented or displayed in a PRSegmentedTabViewController tab a delegate callback is used to request appropriate dismissal. The keyboard should always be visible on this screen, so two BOOL flags are used to control when the keyboard is hidden, allowing it to dismiss when the alert is shown but not otherwise. The keyboard showing and hiding methods are overriden to shrink the text view rather than scroll it.
 */
@interface PRNoteViewController : PRViewController <UITextViewDelegate, UIAlertViewDelegate>
{
    
    BOOL canDismissKeyboard;
    BOOL canShowKeyboard;
    
    IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
}

@property (nonatomic, weak) id<PRNoteDelegate> delegate;

// if no, shows on did appear
@property (nonatomic, assign) BOOL showKeyboardOnWillAppear;

/// Exposed as a property so the accessoryInputView can be set externally.
@property (nonatomic, strong) IBOutlet TDTextView *noteView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSString *noteText;

-(IBAction)submit:(id)sender;
-(IBAction)cancel:(id)sender;

@end
