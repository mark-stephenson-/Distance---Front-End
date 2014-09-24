//
//  PRButton.h
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TheDistanceKit/TheDistanceKit.h>

typedef enum {kPRButtonImageAlignmentLeft, kPRButtonImageAlignmentRight, kPRButtonImageAlignmentTop} PRButtonImageAlignment;

IB_DESIGNABLE
@interface PRButton : UIButton

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat vBuffer;
@property (nonatomic, assign) IBInspectable CGFloat hBuffer;
@property (nonatomic, assign) IBInspectable CGFloat labelButtonBuffer;

@property (nonatomic, strong) IBInspectable UIColor *imageTint;

@property (nonatomic, assign) IBInspectable PRButtonImageAlignment imageAlignment;

@end
