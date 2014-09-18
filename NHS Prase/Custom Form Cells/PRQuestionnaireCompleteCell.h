//
//  PRButtonSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TDFormKit/TDFormKit.h>

/*!
 * @class PRQuestionnaireCompleteCell
 * @discussion SelectCell is subclassed to maintain the selection delegate methods, but the  text field is replaced with a button to launch the selection. An additional summary label is used to display the number of questions answered. As the title and the number of questions are different colours two labels are used to simplify applying the theme, as attributed text is not yet supported. The value property should be an array of two NSNumbers: @[<# answered>, <# total>].
 */
@interface PRQuestionnaireCompleteCell : TDSelectCell
{
    int answered;
    int total;
    
    IBOutlet UILabel *summaryLabel;
}


@property (nonatomic, weak) IBOutlet UIButton *button;

-(IBAction)buttonTapped:(id)sender;

@end
