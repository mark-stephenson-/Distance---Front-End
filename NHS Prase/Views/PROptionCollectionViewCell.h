//
//  PROptionCollectionViewCell.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OPTIONS_CELL_BORDER_WIDTH 2

IB_DESIGNABLE
@interface PROptionCollectionViewCell : UICollectionViewCell
{
    IBOutlet UILabel *optionTitleLabel;
    IBOutlet UIImageView *optionImageView;
    IBOutlet UIImageView *secondOptionImageView;
    
    IBOutletCollection(NSLayoutConstraint) NSArray *vBufferConstraints;
    
    
    CAShapeLayer *borderLayer;
}

@property (nonatomic, assign) IBInspectable CGFloat vBuffer;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelHeightConstraint;
@property (nonatomic, strong) IBInspectable UIColor *imageTintColor;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

-(void)setOptionTitle:(NSString *)title image:(UIImage *)image andSecondImage:(UIImage *) image2;
-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize constrainedToWidth:(CGFloat)width;

@end
