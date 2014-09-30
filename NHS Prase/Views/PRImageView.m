//
//  PRImageView.m
//  NHS Prase
//
//  Created by Josh Campion on 30/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRImageView.h"

@implementation PRImageView

-(void)setImage:(UIImage *)image
{
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
}

@end
