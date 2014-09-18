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

@implementation PRSettingsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.layer.borderColor = [[PRTheme sharedTheme] mainColor].CGColor;
    self.tableView.layer.borderWidth = 2.0;
}

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
    
    languageInfo[@"reuseIdentifier"] = @"LanguagSelect";
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    languageInfo[@"userInfo"][@"selectionDelegate"] = self;
    
    return @[@[languageInfo]];
}


-(void)cellValueChanged:(TDCell *)cell
{
    [super cellValueChanged:cell];
    
    if ([cell.key isEqualToString:@"Language"]) {

        NSString *selectedKey = [PRTheme keyForLanguage:cell.value];
        [[PRTheme sharedTheme] setLanguageIdentifier:selectedKey];
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
        
        // force load the view to configure its subclasses
        UIView *view = prSelection.view;
        prSelection.titleLabel.text = selectedCellInfo[@"title"];
        prSelection.subTitleLabel.text = @"Please select from the options below.";
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:prSelection animated:YES completion:nil];
        }];
    }
}



@end
