//
//  PRBasicDataFormViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRFormViewController.h"

@class PRInputAccessoryView;

/*!
 * @class PRBasicDataFormViewController
 * @discussion This class hard codes the first screen on the questionnaire, as such it should be appropriately  localized.
 */
@interface PRBasicDataFormViewController : PRFormViewController <TDSelectionViewControllerDelegate, TDInputAccessoryDelegate>
{
    BOOL showOtherLanguageOption;
    BOOL showOtherCompleterOption;
    
    PRInputAccessoryView *inputView;
}

+(NSArray *)basicDataFormKeys;

@end
