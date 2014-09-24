//
//  PRTextSizeSelectCell.m
//  NHS Prase
//
//  Created by Josh Campion on 23/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRTextSizeSelectCell.h"
#import "PRTheme.h"

@implementation PRTextSizeSelectCell

-(id)value
{
    return @(textSizeSlider.value);
}

-(void)setValue:(id)value
{
    if (value != nil && [value isKindOfClass:[NSNumber class]]) {
        textSizeSlider.value = ((NSNumber *)value).floatValue;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        NSNumber *sizeValue = [PRTheme sizeValueForCategorySize:(NSString *)value];
        self.value = sizeValue;
    }
}

-(void)awakeFromNib
{
    textSizeOptionCount = 7;
    
    smallTextLabel.font = [[PRTheme sharedTheme] preferredFontForTextStyle:UIFontTextStyleBody andCategorySize:UIContentSizeCategoryExtraSmall];
    largeTextLabel.font = [[PRTheme sharedTheme] preferredFontForTextStyle:UIFontTextStyleBody andCategorySize:UIContentSizeCategoryExtraExtraExtraLarge];
}

-(void)sliderChange:(UISlider *)sender
{
    sender.value = roundf(sender.value);
    
    NSInteger category = sender.value;
    
    NSString *newCategory = [PRTheme categorySizeForSizeValue:@(category)];
    
    if (newCategory != nil && ![newCategory isEqualToString:[[PRTheme sharedTheme] currentContentSizeCategory]]) {
        //NSLog(@"Changing Theme's Content Size Category to %@", newCategory);
        [[PRTheme sharedTheme] setCurrentContentSizeCategory:newCategory];
        [self.formViewController cellValueChanged:self];
    }
}

@end