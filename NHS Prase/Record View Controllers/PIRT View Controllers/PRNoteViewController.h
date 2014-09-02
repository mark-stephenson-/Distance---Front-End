//
//  PRNoteViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDTextView;
@class PRNoteViewController;

@protocol PRNoteDelegate <NSObject>

@optional

-(void)noteViewControllerDidFinish:(PRNoteViewController *) noteVC;
-(void)noteViewControllerCancelled:(PRNoteViewController *) noteVC;

@end

@interface PRNoteViewController : UIViewController <UITextViewDelegate>
{
    BOOL canDismissKeyboard;
    
    
    IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
}

@property (nonatomic, weak) id<PRNoteDelegate> delegate;

/// Exposed as a property so the accessoryInputView can be set externally.
@property (nonatomic, strong) IBOutlet TDTextView *noteView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSString *noteText;

-(IBAction)submit:(id)sender;
-(IBAction)cancel:(id)sender;

@end
