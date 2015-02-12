//
//  PRViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 08/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TheDistanceKit/TheDistanceKit_API.h>

/// Default localisation key to use for any "OK" string.
extern NSString *const PRLocalisationKeyOK;

/// Default localisation key to use for any "Cancel" string.
extern NSString *const PRLocalisationKeyCancel;

/// Default localisation key to use for any "Retry" string.
extern NSString *const PRLocalisationKeyRetry;

/// Default localisation key to use for any "Submit" button title.
extern NSString *const PRLocalisationKeySubmit;

/// Default localisation key to use for any "Next" button title.
extern NSString *const PRLocalisationKeyNext;

/*!
 * @class PRViewController
 * @discussion Base class to be the root superclass of all view controllers. Adds default functionality to showAlertWithTitle: to set the default cancel button title.
 */
@interface PRViewController : TDViewController <UIAlertViewDelegate>
{
//    NSMutableDictionary *alertCompletions;
}

/*!
 * @discussion Shows an alert with a single button. This displays using a UIAlertController and iOS 8 and a UIAlertView on iOS 7.
 * @param buttonTitle If this is non nil this button is displayed, when the button is tapped the completion handler is run. If this is nil only the cancel button shows.
 * @param completion The completion handler which runs when the button is clicked, either from the UIAlertView delegate method alertView:clickedButtonAtIndex: or as a UIAlertAction handler.
 * @param cancelTitle If this is nil, the localized string with key "alert.cancel-title" is used.
 */
///-(void)showAlertWithTitle:(NSString *) alertTitle message:(NSString *) alertMessage buttonTitle:(NSString *) buttonTitle buttonCompletion:(void (^)(NSNumber *buttonIndex, UIAlertAction *action)) completion cancelTitle:(NSString *) cancelTitle alertTag:(NSInteger) tag;
///-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
