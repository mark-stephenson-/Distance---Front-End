//
//  PRSettingsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 08/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSettingsViewController.h"

//#import <TheDistanceKit/TheDistanceKit.h>

#import "PRTheme.h"

@implementation PRSettingsViewController


-(NSArray *)generateCellInfo
{
    NSString *currentLanguageKey = [[PRTheme sharedTheme] languageIdentifier];
    NSString *languageTitle = TDLocalizedStringWithDefaultValue(@"settings.cell.language", nil, nil, @"Select your language:", @"Cell title to change the app's language.");
    NSDictionary *languageOptions = [PRTheme languageDictionary];
    
    NSArray *languageOrder = @[[languageOptions.allKeys sortedArrayUsingSelector:@selector(compare:)]];
    NSMutableDictionary *languageInfo = [TDSelectCell cellInfoWithTitle:languageTitle
                                                            placeholder:nil
                                                                options:languageOptions
                                                                details:nil
                                                                inOrder:languageOrder
                                                                  value:languageOptions[currentLanguageKey]
                                                                 andKey:@"Language"];
    
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    languageInfo[@"userInfo"][@"selectionVCTitle"] = TDLocalizedStringWithDefaultValue(@"settings.language.options", nil, nil, @"Language Select", @"Title of the form when selecting a new language.");
    languageInfo[@"userInfo"][@"modalPresentationStyle"] = @(UIModalPresentationFormSheet);
    
    return @[@[languageInfo]];
}


-(void)cellValueChanged:(TDCell *)cell
{
    [super cellValueChanged:cell];
    
    if ([cell.key isEqualToString:@"Language"]) {

        NSString *selectedKey = [PRTheme keyForLanguage:cell.value];
        [[PRTheme sharedTheme] setLanguageIdentifier:selectedKey];
        //[self applyTheme];
        //[self reloadForm];
    }
}

-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
