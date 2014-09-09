//
//  PRInputAccessoryView.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit.h>

@class PRButton;

@class PRInputAccessoryView;

@protocol PRInputAccessoryDelegate <TDInputAccessoryDelegate>

-(void)inputAccessoryRequestsNext:(PRInputAccessoryView *) inputAccessoryView;
-(void)inputAccessoryRequestsPrevious:(PRInputAccessoryView *) inputAccessoryView;
-(void)inputAccessoryRequestsDone:(PRInputAccessoryView *) inputAccessoryView;

@optional

-(BOOL)inputAccessoryCanGoToNext:(PRInputAccessoryView *) inputAccessoryView;
-(BOOL)inputAccessoryCanGoToPrevious:(PRInputAccessoryView *) inputAccessoryView;

@end

/*!
 * @class PRInputAccessoryView
 * @discussion General view which should be used on all keyboards and footer views to provide consistent navigation throughout the app.
 */
@interface PRInputAccessoryView : UIView
{
    NSArray *hConstrs;
    NSArray *vConstrs;
    NSLayoutConstraint *heightConstr;
    
    BOOL delegateCanGoToNext;
    BOOL delegateCanGoToPrevious;
}

@property (nonatomic, strong) id<PRInputAccessoryDelegate> navigationDelegate;

@property (nonatomic, readonly) PRButton *nextButton;
@property (nonatomic, readonly) PRButton *previousButton;
@property (nonatomic, readonly) PRButton *cancelButton;

/// Sets the bar button items to enabled or disabled by calling the relevant delegate methods.
-(void)refreshBarButtonItemStatus;

@end
