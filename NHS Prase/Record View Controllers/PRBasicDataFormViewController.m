//
//  PRBasicDataFormViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRBasicDataFormViewController.h"

#import "PRDateSelectCell.h"

@interface PRBasicDataFormViewController ()

@end

@implementation PRBasicDataFormViewController

-(NSArray *)generateCellInfo
{
    NSNumber *presentationStyle = @(UIModalPresentationFormSheet);
    
    NSMutableDictionary *dobInfo = [PRDateSelectCell cellInfoWithTitle:@"Date of Birth"
                                                           placeholder:@"Tap to select"
                                                                 value:nil
                                                                andKey:@"DOB"];
    dobInfo[@"reuseIdentifier"] = @"DateSelectCell";
    dobInfo[@"userInfo"][@"selectionIdentifier"] = @"DateSelectionVC";
    dobInfo[@"userInfo"][@"selectionVCTitle"] = @"Date of Birth";
    dobInfo[@"userInfo"][@"modalPresentationStyle"] = presentationStyle;
    dobInfo[@"userInfo"][@"formatter"] = self.dateFormatter;
    
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
    ethnicGroupCell[@"userInfo"][@"sectionTitles"] = ethnicSections;
    ethnicGroupCell[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    ethnicGroupCell[@"userInfo"][@"selectionVCTitle"] = @"Ethnicity";
    ethnicGroupCell[@"userInfo"][@"modalPresentationStyle"] = presentationStyle;
    
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
    languageInfo[@"userInfo"][@"selectionVCTitle"] = @"First Language";
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    languageInfo[@"userInfo"][@"modalPresentationStyle"] = presentationStyle;
    
    NSMutableDictionary *admittedInfo = [PRDateSelectCell cellInfoWithTitle:@"When were you admitted to the hospital?"
                                                           placeholder:@"Tap to select"
                                                                 value:nil
                                                                andKey:@"Admitted"];
    admittedInfo[@"reuseIdentifier"] = @"DateSelectCell";
    admittedInfo[@"userInfo"][@"selectionIdentifier"] = @"DateSelectionVC";
    admittedInfo[@"userInfo"][@"selectionVCTitle"] = @"Date Admitted";
    admittedInfo[@"userInfo"][@"modalPresentationStyle"] = presentationStyle;
    admittedInfo[@"userInfo"][@"formatter"] = self.dateFormatter;
    
    NSMutableDictionary *ongoingTreatmentInfo = [TDSegmentedCell cellInfoWithTitle:@"Are you receiving any ongoing treatment elsewhere in the hospital?"
                                                                     segmentTitles:@[@"Yes", @"No"]
                                                                             value:@1
                                                                            andKey:@"OngoingTreatment"];
    ongoingTreatmentInfo[@"reuseIdentifier"] = @"SegmentCell";
    
    return @[@[dobInfo, genderInfo, ethnicGroupCell, languageInfo, admittedInfo, ongoingTreatmentInfo]];
}

-(NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *formatter = nil;
    
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    return formatter;
}

@end
