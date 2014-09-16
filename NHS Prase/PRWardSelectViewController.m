//
//  PRWardSelectViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRWardSelectViewController.h"

#import "PRSelectionViewController.h"

@implementation PRWardSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    trusts = @[@"Bradford Teaching Hospital NHS Foundation Trust", @"Barnsley Hospital NHS Foundation Trust"];
    
    hospitals = @{@"Bradford Teaching Hospital NHS Foundation Trust": @[@"Bradford Teaching Hospital"],
                  @"Barnsley Hospital NHS Foundation Trust": @[@"Barnsley Hospital"]};
    
    wards = @{@"Bradford Teaching Hospital": @[@"Ward 6",
                                               @"Ward 18"],
              @"Barnsley Hospital": @[@"Ward 19"]};
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshViews];
}

-(void)refreshViews
{
    trustField.text = self.selectedTrust;
    hospitalField.text = self.selectedHospital;
    wardField.text = self.selectedWard;
    
    trustField.enabled = YES;
    hospitalField.enabled = [self.selectedTrust isNonNullString];
    wardField.enabled = [self.selectedHospital isNonNullString];
}

#pragma mark - Delegate Methods

// Show a TDSelectionViewController and prevent a keyboard from showing;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSDictionary *options;
    NSArray *sortedKeys;
    NSString *selectedKey;
    BOOL requiresSelection;
    NSString *selectionKey;
    
    NSString *selectionTitle;
    NSString *selectionTitleLocalizationKey;
    
    NSString *selectionSubTitle;
    NSString *selectionSubtitleLocalizationKey;
    
    if (textField == trustField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitals.count];
        
        for (int h = 0; h < trusts.count; h++) {
            // get localized string
            tempOptions[trusts[h]] = trusts[h];
        }
        
        options = tempOptions;
        sortedKeys = @[trusts];
        selectedKey = self.selectedTrust;
        requiresSelection = YES;
        
        selectionKey = @"trust";
        
        selectionTitle = TDLocalizedStringWithDefaultValue(@"ward-select.title.trust", nil, nil, @"Trust", @"Title when selecting a trust.");
        selectionTitleLocalizationKey = @"ward-select.title.trust";
        
        selectionSubTitle = TDLocalizedStringWithDefaultValue(@"ward-select.subtitle.trust", nil, nil, @"Please select you trust from the list below:", @"Subtitle when selecting a trust.");
        selectionSubtitleLocalizationKey = @"ward-select.subtitle.trust";
        
    } else if (textField == hospitalField) {
        
        NSArray *trustHospitals = hospitals[self.selectedTrust];
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:trustHospitals.count];
        
        
        for (int h = 0; h < trustHospitals.count; h++) {
            // get localized string
            tempOptions[trustHospitals[h]] = trustHospitals[h];
        }
        
        options = tempOptions;
        sortedKeys = @[trustHospitals];
        selectedKey = self.selectedHospital;
        requiresSelection = YES;
        selectionKey = @"hospital";
        
        selectionTitle = TDLocalizedStringWithDefaultValue(@"ward-select.title.hospital", nil, nil, @"Hospital", @"Title when selecting a hospital.");
        selectionTitleLocalizationKey = @"ward-select.title.hospital";
        
        selectionSubTitle = TDLocalizedStringWithDefaultValue(@"ward-select.subtitle.hospital", nil, nil, @"Please select your hospital from the list below:", @"Subtitle when selecting a hospital.");
        selectionSubtitleLocalizationKey = @"ward-select.subtitle.hospital";
        
    } else if (textField == wardField) {
        
        NSArray *hospitalWards = wards[self.selectedHospital];
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitalWards.count];
        
        for (int w = 0; w < hospitalWards.count; w++) {
            // get localized string
            tempOptions[hospitalWards[w]] = hospitalWards[w];
        }
        
        options = tempOptions;
        sortedKeys = @[hospitalWards];
        selectedKey = self.selectedWard;
        requiresSelection = NO;
        selectionKey = @"ward";
        
        selectionTitle = TDLocalizedStringWithDefaultValue(@"ward-select.title.ward", nil, nil, @"Ward", @"Title when selecting a ward.");
        selectionTitleLocalizationKey = @"ward-select.title.ward";
        
        selectionSubTitle = TDLocalizedStringWithDefaultValue(@"ward-select.subtitle.ward", nil, nil, @"Please select your ward from the list below:", @"Subtitle when selecting a ward.");
        selectionSubtitleLocalizationKey = @"ward-select.subtitle.ward";
    }
    
    PRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PRBasicSelectionVC"];
    // force load the view to configure the labels
    UIView *selectionView = selectionVC.view;
    [selectionVC setOptions:options withDetails:nil orderedAs:sortedKeys];
    
    if (selectedKey != nil) {
        selectionVC.selectedKeys = [NSMutableSet setWithObject:selectedKey];
    }
    
    selectionVC.requiresSelection = requiresSelection;
    selectionVC.tableView.allowsMultipleSelection = NO;
    selectionVC.delegate = self;
    selectionVC.key = selectionKey;
    selectionVC.title = selectionTitle;
    
    selectionVC.titleLabel.text = selectionTitle;
    selectionVC.titleLabel.TDLocalizedStringKey = selectionTitleLocalizationKey;
    
    selectionVC.subTitleLabel.text = selectionSubTitle;
    selectionVC.subTitleLabel.TDLocalizedStringKey = selectionSubtitleLocalizationKey;
    
    // present the configured selection vc
    selectionVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:selectionVC animated:YES completion:nil];
    
    return NO;
}

// Set the selection, clearing the hospital or ward if a corresponding parent has changed
-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    NSString *selectionKey = selectionVC.key;
    
    if ([selectionKey isEqualToString:@"trust"]) {
        NSString *newTrust = [[selectionVC selectedKeys] anyObject];
        if (![newTrust isEqualToString:self.selectedTrust]) {
            self.selectedTrust = newTrust;
            self.selectedHospital = nil;
            self.selectedWard = nil;
        }
    }
    
    if ([selectionKey isEqualToString:@"hospital"]) {
        NSString *newHospital = [[selectionVC selectedKeys] anyObject];
        if (![newHospital isEqualToString:self.selectedHospital]) {
            self.selectedHospital = newHospital;
            self.selectedWard = nil;
        }
    }
    
    if ([selectionKey isEqualToString:@"ward"]) {
        self.selectedWard = [[selectionVC selectedKeys] anyObject];
    }
    
    [self refreshViews];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
