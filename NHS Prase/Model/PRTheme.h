//
//  PRTheme.h
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit.h>

typedef enum {kRotationPreferencePortrait, kRotationPreferenceLandscape, kRotationPreferenceBoth} RotationPreference;

//NSString * PRLocalizedStringWithDefaultValue(NSString *key, NSString *tbl, NSBundle *bundle, NSString *val, NSString *comment);

@interface PRTheme : TDTheme

@property (nonatomic, strong) UIColor *negativeColor;
@property (nonatomic, strong) UIColor *positiveColor;
@property (nonatomic, strong) UIColor *neutralColor;
@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, assign) RotationPreference currentRotationPreference;;

@end
