//
//  PRViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 08/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @class PRViewController
 * @discussion Base class to be the root superclass of all view controllers. Provides methods to show alerts based on iOS version to centralise deprecation. Sets up themeing appropriately in viewWillAppear: and viewWillDisappear:.
 */
@interface PRViewController : UIViewController <UIAlertViewDelegate>
{
    NSMutableDictionary *alertCompletions;
}

/*!
 * @discussion Shows an alert with a single button. This displays using a UIAlertController and iOS 8 and a UIAlertView on iOS 7.
 * @param buttonTitle If this is non nil this button is displayed, when the button is tapped the completion handler is run. If this is nil only the cancel button shows.
 * @param completion The completion handler which runs when the button is clicked, either from the UIAlertView delegate method alertView:clickedButtonAtIndex: or as a UIAlertAction handler.
 * @param cancelTitle If this is nil, the localized string with key "alert.cancel-title" is used.
 */
/// If cancel
-(void)showAlertWithTitle:(NSString *) alertTitle message:(NSString *) alertMessage buttonTitle:(NSString *) buttonTitle buttonCompletion:(void (^)(NSNumber *buttonIndex, UIAlertAction *action)) completion cancelTitle:(NSString *) cancelTitle alertTag:(NSInteger) tag;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
