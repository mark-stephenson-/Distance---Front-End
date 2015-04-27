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


@end
