//
//  PRSelectionViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 12/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit_API.h>

/*!
 * @class PRSelectionViewController
 * @discussion Custom selection view controller formatted to look like the designs by removing the TDSelectionVC default selection and configuring the custom cell instead.
 */
@interface PRSelectionViewController : TDSelectionViewController
{
    IBOutlet UIView *tableContainer;
}

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subTitleLabel;


@end
