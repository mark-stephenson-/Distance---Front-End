//
//  PROptionCollectionViewCell.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface PROptionCollectionViewCell : UICollectionViewCell
{
    
    IBOutlet IBInspectable UILabel *optionTitleLabel;
    IBOutlet IBInspectable UIImageView *optionImageView;
}

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelHeightConstraint;

-(void)setOptionTitle:(NSString *) title andImage:(UIImage *) image;

@end
