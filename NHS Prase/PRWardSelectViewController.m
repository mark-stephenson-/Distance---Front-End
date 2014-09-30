//
//  PRWardSelectViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRWardSelectViewController.h"

#import "PRSelectionViewController.h"

#import "PRTrust.h"
#import "PRHospital.h"
#import "PRWard.h"

#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation PRWardSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    trusts = [PRTrust MR_findAllSortedBy:@"name" ascending:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshViews];
}

-(void)refreshViews
{
    trustField.text = self.selectedTrust.name;
    hospitalField.text = self.selectedHospital.name;
    wardField.text = self.selectedWard.name;
    
    trustField.enabled = YES;
    hospitalField.enabled = self.selectedTrust != nil;
    wardField.enabled = self.selectedHospital != nil;
}

#pragma mark - Delegate Methods

// Show a TDSelectionViewController and prevent a keyboard from showing;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSDictionary *options;
    NSArray *sortedKeys;
    id<NSCopying> selectedKey;
    BOOL requiresSelection;
    NSString *selectionKey;
    
    NSString *selectionTitle;
    NSString *selectionTitleLocalizationKey;
    
    NSString *selectionSubTitle;
    NSString *selectionSubtitleLocalizationKey;
    
    if (textField == trustField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:trusts.count];
        
        for (int t = 0; t < trusts.count; t++) {
            PRTrust *thisTrust = trusts[t];
            tempOptions[thisTrust.id] = thisTrust.name;
        }
        
        options = tempOptions;
        sortedKeys = @[[trusts valueForKeyPath:@"id"]];
        selectedKey = self.selectedTrust.id;
        requiresSelection = YES;
        
        selectionKey = @"trust";
        
        selectionTitle = TDLocalizedStringWithDefaultValue(@"ward-select.title.trust", nil, nil, @"Trust", @"Title when selecting a trust.");
        selectionTitleLocalizationKey = @"ward-select.title.trust";
        
        selectionSubTitle = TDLocalizedStringWithDefaultValue(@"ward-select.subtitle.trust", nil, nil, @"Please select your trust from the list below:", @"Subtitle when selecting a trust.");
        selectionSubtitleLocalizationKey = @"ward-select.subtitle.trust";
        
    } else if (textField == hospitalField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitals.count];
        
        for (int h = 0; h < hospitals.count; h++) {
            PRHospital *thisHospital = hospitals[h];
            tempOptions[thisHospital.id] = thisHospital.name;
        }
        
        options = tempOptions;
        sortedKeys = @[[hospitals valueForKeyPath:@"id"]];
        selectedKey = self.selectedHospital.id;
        requiresSelection = YES;
        selectionKey = @"hospital";
        
        selectionTitle = TDLocalizedStringWithDefaultValue(@"ward-select.title.hospital", nil, nil, @"Hospital", @"Title when selecting a hospital.");
        selectionTitleLocalizationKey = @"ward-select.title.hospital";
        
        selectionSubTitle = TDLocalizedStringWithDefaultValue(@"ward-select.subtitle.hospital", nil, nil, @"Please select your hospital from the list below:", @"Subtitle when selecting a hospital.");
        selectionSubtitleLocalizationKey = @"ward-select.subtitle.hospital";
        
    } else if (textField == wardField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:wards.count];
        
        for (int w = 0; w < wards.count; w++) {
            PRWard *thisWard = wards[w];
            tempOptions[thisWard.id] = thisWard.name;
        }
        
        options = tempOptions;
        sortedKeys = @[[wards valueForKeyPath:@"id"]];
        selectedKey = self.selectedWard.id;
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
        NSNumber *newTrustID = [[selectionVC selectedKeys] anyObject];
        
        
        if (self.selectedTrust == nil || ![newTrustID isEqualToNumber:self.selectedTrust.id]) {
            PRTrust *newTrust = [[trusts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", newTrustID]] firstObject];
            self.selectedTrust = newTrust;
            
            // clear the existing hospital and ward as they will not be under this trust
            self.selectedHospital = nil;
            self.selectedWard = nil;
        }
    }
    
    if ([selectionKey isEqualToString:@"hospital"]) {
        NSNumber *newHospitalID = [[selectionVC selectedKeys] anyObject];
        
        if (self.selectedHospital == nil || ![newHospitalID isEqualToNumber:self.selectedHospital.id]) {
            
            PRHospital *newHospital = [[hospitals filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", newHospitalID]] firstObject];
            self.selectedHospital = newHospital;
            
            // clear the existing ward as it will not be under this hospital
            self.selectedWard = nil;
        }
    }
    
    if ([selectionKey isEqualToString:@"ward"]) {
        
        NSNumber *newWardID = [[selectionVC selectedKeys] anyObject];
        
        if (self.selectedWard == nil ||  ![newWardID isEqualToNumber:self.selectedWard.id]) {
            PRWard *newWard = [[wards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", newWardID]] firstObject];
            
            self.selectedWard = newWard;
        }
        
    }
    
    [self refreshViews];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setters

-(void)setSelectedTrust:(PRTrust *)selectedTrust
{
    if (_selectedTrust != selectedTrust) {
        // only change and pull the new hospitals if changed to prevent too much CoreData work
        _selectedTrust = selectedTrust;
        
        if (selectedTrust != nil) {
            hospitals = [selectedTrust.hospitals sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        } else {
            hospitals = nil;
        }
    }
}

-(void)setSelectedHospital:(PRHospital *)selectedHospital
{
    if (_selectedHospital != selectedHospital) {
        // only change and pull the new wards if changed to prevent too much CoreData work
        _selectedHospital = selectedHospital;
        
        if (selectedHospital != nil) {
            wards = [selectedHospital.wards sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        } else {
            wards = nil;
        }
    }
    
    if (self.selectedTrust == nil) {
        self.selectedTrust = selectedHospital.trust;
    }
}

-(void)setSelectedWard:(PRWard *)selectedWard
{
    _selectedWard = selectedWard;
    
    if (self.selectedHospital == nil) {
        self.selectedHospital = selectedWard.hospital;
    }
    
}

@end
