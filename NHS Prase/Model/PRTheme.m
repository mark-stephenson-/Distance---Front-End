//
//  PRTheme.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRTheme.h"

#import "PRRecord.h"

NSString *const PRRotationPreferenceKey = @"RotationPreference";

NSString *const PRTestAccountUsername = @"PraseTest";
NSString *const PRTestAccountPassword = @"PraseTest";

@implementation PRTheme

-(CGFloat)preferredBaseFontSizeForCategory:(NSString *)currentContentSizeCategory
{
    return [super preferredBaseFontSizeForCategory:currentContentSizeCategory] + 3.0;
}

-(CGFloat)preferredFontSizeForTextStyle:(NSString *)fontStyle andCategorySize:(NSString *)categorySize
{
    // ... set the font size adjustment based on the chosen style
    CGFloat fontSize = [self preferredBaseFontSizeForCategory:categorySize];
    
    if ([fontStyle isEqualToString:UIFontTextStyleHeadline]) {
        // used only for dark blue headlines
        fontSize += 4.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleSubheadline]) {
        // used for most headings, explanations and prompts
        fontSize += 0.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleBody]) {
        // used for used inputted data
        fontSize -= 2.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleCaption1]) {
        // used for navigation buttons
        fontSize -= 1.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleCaption2]) {
        // used for the Questionnaire CMS introduction
        fontSize += 2.0;
        
    } else if ([fontStyle isEqualToString:UIFontTextStyleFootnote]) {
        // used for text under the PIRT concern faces
        fontSize -= 4.0;
    }
    
    return fontSize;
}

-(instancetype)init
{
    self = [super init];
    
    if (self != nil) {
        
        _neutralColor = [UIColor colorWithHex:@"#42c4fa" alpha:1.0];
        _mainColor = [UIColor colorWithHex:@"#32327b" alpha:1.0];
        _positiveColor = [UIColor colorWithHex:@"#8bc53f" alpha:1.0];
        _negativeColor = [UIColor colorWithHex:@"#eb008b" alpha:1.0];
        _backColor = [UIColor lightGrayColor];
        
        NSString *fontName = @"Helvetica";
        self.preferredFontNameForHeadline = @"Helvetica Bold";
        self.preferredFontNameForSubHeadline = @"Helvetica Bold";
        self.preferredFontNameForBody = fontName;
        self.preferredFontNameForCaption1 = @"Helvetica Bold";
        self.preferredFontNameForCaption2 = fontName;
        self.preferredFontNameForFootnote = fontName;
        
        _currentRotationPreference = [[[NSUserDefaults standardUserDefaults] valueForKey:PRRotationPreferenceKey] intValue];
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

-(void)setCurrentRotationPreference:(RotationPreference)currentRotationPreference
{
    _currentRotationPreference = currentRotationPreference;
    [[NSUserDefaults standardUserDefaults] setValue:@(currentRotationPreference) forKey:PRRotationPreferenceKey];
    
    // force a rotation if appropriate
    
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentRotationPreference == kRotationPreferencePortrait && UIInterfaceOrientationIsLandscape(currentOrientation)) {
        
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        
    } else if (currentRotationPreference == kRotationPreferenceLandscape && UIInterfaceOrientationIsPortrait(currentOrientation)) {
        
        if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
        } else {
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        }
    }
    
    [UIViewController attemptRotationToDeviceOrientation];
}

#pragma mark - Test User methods

-(BOOL)currentUserIsTest
{
    NSString *currentUser = [[NSUserDefaults standardUserDefaults] valueForKey:PRRecordUsernameKey];
    return [currentUser isEqualToString:PRTestAccountUsername];
}


@end
