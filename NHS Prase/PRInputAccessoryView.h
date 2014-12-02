//
//  PRInputAccessoryView.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit.h>

@class TDButton;

/*!
 * @class PRInputAccessoryView
 * @discussion General view which should be used on all keyboards and footer views to provide consistent navigation throughout the app. Done button is equivalent to cancel button
 */
@interface PRInputAccessoryView : UIView <TDInputAccessoryView>
{
    NSArray *hConstrs;
    NSArray *vConstrs;
    NSLayoutConstraint *heightConstr;
    
    BOOL delegateCanGoToNext;
    BOOL delegateCanGoToPrevious;
}

@property (nonatomic, readonly) TDButton *nextButton;
@property (nonatomic, readonly) TDButton *previousButton;
@property (nonatomic, readonly) TDButton *cancelButton;

@end
