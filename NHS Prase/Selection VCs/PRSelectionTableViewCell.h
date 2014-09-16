//
//  PRSelectionTableViewCell.h
//  NHS Prase
//
//  Created by Josh Campion on 15/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit.h>

@interface PRSelectionTableViewCell : TDTableViewCell
{
    IBOutletCollection(NSLayoutConstraint) NSArray *hConstraints;
    //IBOutletCollection(NSLayoutConstraint) NSArray *vConstraints;
    
    IBOutlet UIImageView *selectionIndicator;
}

@end
