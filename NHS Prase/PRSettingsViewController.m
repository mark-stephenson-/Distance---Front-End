//
//  PRSettingsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 08/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSettingsViewController.h"

#import "PRTheme.h"
#import "PRSelectionViewController.h"
#import "PRTextSizeSelectCell.h"

@implementation PRSettingsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.layer.borderColor = [[PRTheme sharedTheme] mainColor].CGColor;
    self.tableView.layer.borderWidth = 2.0;
}

-(NSArray *)generateCellInfo
{
    // Create the language select cell
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
    
    languageInfo[@"reuseIdentifier"] = @"LanguagSelect";
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    languageInfo[@"userInfo"][@"selectionDelegate"] = self;
    
    // Create the text size cell
    
    NSMutableDictionary *textSizeCell = [PRTextSizeSelectCell cellInfoWithTitle:TDLocalizedStringWithDefaultValue(@"settings.cell.text-size", nil, nil, @"Change the font size:", @"The title label on the settings screen to set the user's preferred font size for the app")
                                                                          value:[[PRTheme sharedTheme] currentContentSizeCategory]
                                                                         andKey:@"TextSize"];
    textSizeCell[@"reuseIdentifier"] = @"TextSize";
    
    // create the rotation preference cell
    
    NSNumber *rotationValue = nil;
    switch ([[PRTheme sharedTheme] currentRotationPreference]) {
        case kRotationPreferencePortrait:
            rotationValue = @0;
            break;
        case kRotationPreferenceLandscape:
            rotationValue = @1;
            break;
        case kRotationPreferenceBoth:
            rotationValue = @2;
            break;
        default:
            break;
    }
    
    NSArray *rotationTitles = @[TDLocalizedStringWithDefaultValue(@"settings.rotation.portrait", nil, nil, @"Portrait", @"Interface rotation preference is portrait."),
                                TDLocalizedStringWithDefaultValue(@"settings.rotation.landscape", nil, nil, @"Landscape", @"Interface rotation preference is portrait."),
                                TDLocalizedStringWithDefaultValue(@"settings.rotation.automatic", nil, nil, @"Automatic Rotation", @"Interface rotation preference is to rotate to match the device.")];
    NSMutableDictionary *rotationCell = [TDSegmentedCell cellInfoWithTitle:TDLocalizedStringWithDefaultValue(@"settings.cell.rotation", nil, nil, @"Please select your screen rotation preference", @"The title label on the settings screen to set the user's preference on interface orientation.")
                                                             segmentTitles:rotationTitles
                                                                       value:rotationValue
                                                                      andKey:@"Rotation"];
    rotationCell[@"reuseIdentifier"] = @"Rotation";
    
    
    return @[@[languageInfo, textSizeCell, rotationCell]];
}


-(void)cellValueChanged:(TDCell *)cell
{
    [super cellValueChanged:cell];
    
    if ([cell.key isEqualToString:@"Language"]) {
        NSString *selectedKey = [PRTheme keyForLanguage:cell.value];
        [[PRTheme sharedTheme] setLanguageIdentifier:selectedKey];
    }
    
    if ([cell.key isEqualToString:@"TextSize"]) {
        [self reloadForm];
    }
    
    if ([cell.key isEqualToString:@"Rotation"]) {
        TDSegmentedCell *segCell = (TDSegmentedCell *) cell;
        NSUInteger index = [segCell.segmentTitles indexOfObject:cell.value];
        
        RotationPreference newPref;
        switch (index) {
            case 0:
                newPref = kRotationPreferencePortrait;
                break;
            case 1:
                newPref = kRotationPreferenceLandscape;
                break;
            case 2:
                newPref = kRotationPreferenceBoth;
                break;
            default:
                break;
        }
        
        [[PRTheme sharedTheme] setCurrentRotationPreference:newPref];
    }
}

-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SelectionCell Delegate Methods

-(void)selectionCell:(TDSelectCell *)cell requestsPresentationOfSelectionViewController:(TDSelectionViewController *)selectionVC
{
    if ([selectionVC isKindOfClass:[PRSelectionViewController class]]) {
        
        NSIndexPath *selectedPath = [self indexPathForFormKey:cell.key];
        NSDictionary *selectedCellInfo = self.cellInfo[selectedPath.section][selectedPath.row];
        
        PRSelectionViewController *prSelection = (PRSelectionViewController *) selectionVC;
        
        // force load the view to configure the subviews
        if (prSelection.view != nil) {
            prSelection.titleLabel.text = selectedCellInfo[@"title"];
            prSelection.subTitleLabel.text = @"Please select from the options below.";
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:prSelection animated:YES completion:nil];
            }];
        }
    }
}



@end
