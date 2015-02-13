//
//  PRBasicDataFormViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRBasicDataFormViewController.h"

#import "PRTheme.h"
#import "PRDateSelectCell.h"
#import "PRIncrementCell.h"
#import "PRSelectionViewController.h"

@interface PRBasicDataFormViewController ()

@end

@implementation PRBasicDataFormViewController

-(NSArray *)generateCellInfo
{
    // save a weak reference of self to store in the dictionary to prevent retain cycles caused in self.cellInfo
    __weak PRBasicDataFormViewController *wSelf = self;
    
    NSMutableDictionary *dobInfo = [PRDateSelectCell cellInfoWithTitle:@"Date of Birth"
                                                                 value:nil
                                                                andKey:@"DOB"];
    dobInfo[@"reuseIdentifier"] = @"DateSelectCell";
    
    NSMutableDictionary *genderInfo = [TDSegmentedCell cellInfoWithTitle:@"Gender"
                                                           segmentTitles:@[@"Male", @"Female"]
                                                                   value:nil
                                                                  andKey:@"Gender"];
    genderInfo[@"reuseIdentifier"] = @"SegmentCell";
    
    // Ethnicity
    
    NSArray *ethnicSections = @[@"White", @"Black or Black British", @"Asian or Asian British", @"Chinese", @"Mixed", @"Other"];
    
    NSDictionary *ethnicOptions = @{@"british" : @"British",
                                    @"irish" : @"Irish",
                                    @"other white" : @"Other",
                                    @"african": @"African",
                                    @"caribbean": @"Caribbean",
                                    @"other black": @"Other background",
                                    @"indian": @"Indian",
                                    @"pakistani": @"Pakistani",
                                    @"bangladeshi": @"Bangladeshi",
                                    @"other asian": @"Other background",
                                    @"chinese": @"Chinese",
                                    @"white+asian": @"White & Asian",
                                    @"white+black african": @"White & Black African",
                                    @"white+black caribbean": @"White & Black Caribbean",
                                    @"other mixed": @"Other mixed background",
                                    @"other other": @"Other ethnic background"};
    
    NSArray *ethnicKeys = @[@[@"british", @"irish", @"other white"],
                            @[@"african", @"caribbean", @"other black"],
                            @[@"indian", @"pakistani", @"bangladeshi", @"other asian"],
                            @[@"chinese"],
                            @[@"white+asian", @"white+black african", @"white+black caribbean", @"other mixed",],
                            @[@"other other"]];
    
    NSMutableDictionary *ethnicGroupCell = [TDSelectCell cellInfoWithTitle:@"How would you describe your ethnic group?"
                                                               placeholder:@"Tap to select"
                                                                   options:ethnicOptions
                                                                   details:nil
                                                                   inOrder:ethnicKeys
                                                                     value:nil
                                                                    andKey:@"Ethnicity"];
    
    ethnicGroupCell[@"reuseIdentifier"] = @"SelectCell";
    ethnicGroupCell[@"userInfo"][@"selectionDelegate"] = wSelf;
    ethnicGroupCell[@"userInfo"][@"selectionVCInfo"] = @{@"sectionTitles": ethnicSections};
    ethnicGroupCell[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    ethnicGroupCell[@"userInfo"][@"textField.textInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(4, 15, 4, 15)];
    ethnicGroupCell[@"userInfo"][@"textField.imageInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 15)];
    
    // Language
    
    NSDictionary *languageOptions = @{@"en": @"English",
                                      @"mi": @"Mirpuri",
                                      @"ur": @"Urdu",
                                      @"other" : @"Other"};
    NSArray *languageKeys = @[@[@"en", @"mi", @"ur", @"other"]];
    
    NSMutableDictionary *languageInfo = [TDSelectCell cellInfoWithTitle:@"What is your first language?"
                                                            placeholder:@"Tap to select"
                                                                options:languageOptions
                                                                details:nil
                                                                inOrder:languageKeys
                                                                  value:nil
                                                                 andKey:@"Language"];
    
    languageInfo[@"reuseIdentifier"] = @"SelectCell";
    languageInfo[@"userInfo"][@"selectionDelegate"] = wSelf;
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    languageInfo[@"userInfo"][@"textField.textInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(4, 15, 4, 15)];
    languageInfo[@"userInfo"][@"textField.imageInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 10)];
    
    NSMutableDictionary *admittedInfo = [PRDateSelectCell cellInfoWithTitle:@"When were you admitted to the hospital?"
                                                                      value:[NSDate date]
                                                                     andKey:@"Admitted"];
    admittedInfo[@"reuseIdentifier"] = @"DateSelectCell";
    
    /*
     // question removed by client but prototype
    NSMutableDictionary *inpatientInfo = [PRIncrementCell cellInfoWithTitle:@"How many times have you been an inpatient at this hospital in the past 5 years?"
                                                                      value:@0
                                                                     andKey:@"InpatientCount"];
    inpatientInfo[@"reuseIdentifier"] = @"IncrementCell";
    */
    
    /*
    NSMutableDictionary *ongoingTreatmentInfo = [TDSegmentedCell cellInfoWithTitle:@"Are you receiving any ongoing treatment elsewhere in the hospital?"
                                                                     segmentTitles:@[@"Yes", @"No"]
                                                                             value:@1
                                                                            andKey:@"OngoingTreatment"];
    ongoingTreatmentInfo[@"reuseIdentifier"] = @"SegmentCell";
    */
    
    return @[@[dobInfo, genderInfo, ethnicGroupCell, languageInfo, admittedInfo]];
}

#pragma mark - SelectionCell Delegate Methods

-(void)selectionCell:(TDSelectCell *)cell requestsPresentationOfSelectionViewController:(TDSelectionViewController *)selectionVC
{
    if ([selectionVC isKindOfClass:[PRSelectionViewController class]]) {

        NSIndexPath *selectedPath = [self indexPathForFormKey:cell.key];
        NSDictionary *selectedCellInfo = self.cellInfo[selectedPath.section][selectedPath.row];
        
        PRSelectionViewController *prSelection = (PRSelectionViewController *) selectionVC;
        
        // force load the view to configure its subclasses
        if (prSelection.view != nil) {
            prSelection.titleLabel.text = selectedCellInfo[@"title"];
            prSelection.subTitleLabel.text = @"Please select from the options below.";
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:prSelection animated:YES completion:nil];
            }];
        }
    }
}

-(CGFloat)selectionViewController:(TDSelectionViewController *)selectionVC heightForHeaderInSection:(NSInteger)section
{
    if ([selectionVC.key isEqualToString:@"Ethnicity"]) {
        NSString *thisSectionTitle = selectionVC.sectionTitles[section];
        
        UIView *view = [self createHeaderWithTitle:thisSectionTitle];
        CGSize layoutSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return layoutSize.height + 2.0;;
    }
    
    return 0;
}

-(UIView *)selectionViewController:(TDSelectionViewController *)selectionVC viewForHeaderInSection:(NSInteger)section
{
    if ([selectionVC.key isEqualToString:@"Ethnicity"]) {
        NSString *thisSectionTitle = selectionVC.sectionTitles[section];
        
        UIView *view = [self createHeaderWithTitle:thisSectionTitle];
        
        return view;
    }
    
    return nil;
}

-(UIView *)createHeaderWithTitle:(NSString *) title
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.TDTextStyleIdentifier = @"SubHeadline";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [[PRTheme sharedTheme] mainColor];
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [view addSubview:label];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(15)-[label]-(15)-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"label": label}]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[label]-(8)-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"label": label}]];
    
    [self applyThemeToView:view];
    //[view layoutIfNeeded];
    
    return view;
}

@end
