//
//  PRTheme.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRTheme.h"

@implementation PRTheme

-(instancetype)init
{
    self = [super init];
    
    if (self != nil) {
        _neutralColor = [UIColor colorWithHex:@"#42c4fa" alpha:1.0];
        _mainColor = [UIColor colorWithHex:@"#32327b" alpha:1.0];
        _positiveColor = [UIColor colorWithHex:@"#8bc53f" alpha:1.0];
        _negativeColor = [UIColor colorWithHex:@"#eb008b" alpha:1.0];
        _backColor = [UIColor lightGrayColor];
    }
    
    return self;
}

-(UIColor *)colourForIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:@"negative"]) {
        return self.negativeColor;
    }
    
    if ([identifier isEqualToString:@"positive"]) {
        return self.positiveColor;
    }
    
    if ([identifier isEqualToString:@"neutral"]) {
        return self.neutralColor;
    }
    
    if ([identifier isEqualToString:@"main"]) {
        return self.mainColor;
    }
    
    if ([identifier isEqualToString:@"back"]) {
        return self.backColor;
    }
    
    return [super colourForIdentifier:identifier];
}

@end
