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
#import <MagicalRecord/MagicalRecord.h>

@implementation PRWardSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    trusts = [PRTrust MR_findAllSortedBy:@"name" ascending:YES];
    otherWardField.accessoryImage = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshViews];
    
    if (otherWardField != nil) {
        self.components = @[otherWardField];
        self.scrollContainer = scrollView;
    }
    
    // reload the ward component incase any new custom wards have been created for this hospital
    if (self.selectedHospital != nil) {
        wards = [self.selectedHospital.wards sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.scrollContainer = nil;
    
    // if the user has created a custom ward but not chosen it the id will still be -1. Delete this now so it doesn't show up in later ward selection screens
    NSArray *emptyCustomWards = [PRWard MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", @(-1)]];
    NSLog(@"Deleting %ld custom wards", (long) emptyCustomWards.count);
    for (PRWard *emptyCustomWard in emptyCustomWards) {
        [emptyCustomWard MR_deleteEntity];
    }
}

-(void)refreshViews
{
    trustField.text = self.selectedTrust.name;
    hospitalField.text = self.selectedHospital.name;
    trustField.enabled = YES;
    hospitalField.enabled = self.selectedTrust != nil;
    wardField.enabled = self.selectedHospital != nil;

    // show / hide the custom ward text field
    if (self.selectedWard.id.integerValue < 0) {
        otherWardField.enabled = YES;
        otherWardField.hidden = NO;
        otherWardField.text = self.selectedWard.name;
        wardField.text = @"Other";
    } else {
        otherWardField.hidden = YES;
        otherWardField.text = @"";
        wardField.text = self.selectedWard.name;
    }
}

-(BOOL)validateSelectedWard
{
    if (self.selectedWard == nil) {
        NSString *errorMessage = @"";
        
        if (self.selectedTrust == nil) {
            errorMessage = TDLocalizedStringWithDefaultValue(@"home.create-error.no-trust", nil, nil, @"Please select a trust.", @"The error shown in the user tries to create a new record without selecting a trust.");
        }
        
        if (self.selectedHospital == nil) {
            
            if (errorMessage.length > 0) {
                errorMessage = [errorMessage stringByAppendingString:@"\n"];
            }
            
            NSString *hospitalError = TDLocalizedStringWithDefaultValue(@"home.create-error.no-hospital", nil, nil, @"Please select a hospital.", @"The error shown in the user tries to create a new record without selecting a trust.");
            errorMessage = [errorMessage stringByAppendingString:hospitalError];
        }
        
        if (self.selectedWard == nil) {
            
            if (errorMessage.length > 0) {
                errorMessage = [errorMessage stringByAppendingString:@"\n"];
            }
            
            NSString *wardError = TDLocalizedStringWithDefaultValue(@"home.create-error.no-ward", nil, nil, @"Please select a ward.", @"The error shown in the user tries to create a new record without selecting a ward.");
            errorMessage = [errorMessage stringByAppendingString:wardError];
        }
        
        NSString *errorTitle = TDLocalizedStringWithDefaultValue(@"home.create-error.title", nil, nil, @"Invalid Ward", @"Error title when the user has only partially selected a ward.");
        
        [self showAlertWithTitle:errorTitle
                         message:errorMessage
                     cancelTitle:nil
                    buttonTitles:nil
                         actions:nil];
        return NO;
    } else if ([self.selectedWard.id isEqualToNumber:@(-1)] && ![self.selectedWard.name isNonNullString]) {
        
        NSString *errorTitle = TDLocalizedStringWithDefaultValue(@"home.create-error.invalid-custom-ward.title", nil, nil, @"Invalid Ward", @"Error title shown when the user hasn't entered a name for a custom ward.");
        NSString *errorMessage = TDLocalizedStringWithDefaultValue(@"home.create-error.invalid-custom-ward.messgae", nil, nil, @"Please enter a name for this ward.", @"The error message shown when the user hasn't entered a name for a custom ward.");
        
        [self showAlertWithTitle:errorTitle
                         message:errorMessage
                     cancelTitle:nil
                    buttonTitles:nil
                         actions:nil];
        return NO;
    } else {
        return YES;
    }
}

-(PRWard *)blankCustomWard
{
    PRWard *blankWard = [PRWard MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", @(-1)]];
    
    if (blankWard == nil) {
        blankWard = [PRWard MR_createEntity];
        blankWard.id = @(-1);
    }
    
    blankWard.hospital = self.selectedHospital;

    return blankWard;
}

-(void)commitCustomWard
{
    if ([self.selectedWard.id isEqualToNumber:@(-1)] && [self.selectedWard.name isNonNullString]) {
        NSInteger customWardCount = [PRWard MR_countOfEntitiesWithPredicate:[NSPredicate predicateWithFormat:@"id < %@", @0]];
        
        if (self.selectedWard.id != nil) {
            // account for this ward already being in the count
            customWardCount--;
        }
        self.selectedWard.id = @(-2 - customWardCount);
        wards = [wards arrayByAddingObject:self.selectedWard];
        
        NSLog(@"Setting ward [%@] as id [%@]", self.selectedWard.name, self.selectedWard.id);
    }
}

#pragma mark - Delegate Methods

// Show a TDSelectionViewController and prevent a keyboard from showing;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == otherWardField) {
        return [super textFieldShouldBeginEditing:textField];
    } else {
        [self.view endEditing:YES];
    }
    
    NSDictionary *options;
    NSArray *sortedKeys;
    id<NSCopying> selectedKey;
    BOOL requiresSelection;
    NSString *selectionKey;
    
    NSString *selectionTitle;
    NSString *selectionTitleLocalizationKey;
    
    NSString *selectionSubTitle;
    NSString *selectionSubtitleLocalizationKey;
    
    // The custom wards show a detail sting to imply they are custom
    NSMutableDictionary *optionDetails = [NSMutableDictionary dictionary];

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
            if (thisWard.id.integerValue < 0) {
                optionDetails[thisWard.id] = TDLocalizedStringWithDefaultValue(@"ward-select.custom-ward.label", nil, nil, @"User Ward", @"The label shown to indicate that a ward has been entered using the \"Other\" field.");
            }
        }
        
        // add an option for the user to select a different ward
        tempOptions[@(-1)] = TDLocalizedStringWithDefaultValue(@"ward-select.ward.other", nil, nil, @"Other", @"Selection option to enter a ward not in the CMS.");
        
        options = tempOptions;
        sortedKeys = [wards valueForKeyPath:@"id"];
        sortedKeys = [sortedKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger id1 = ((NSNumber *)obj1).integerValue;
            NSInteger id2 = ((NSNumber *)obj2).integerValue;
            
            if (id1 < 0 && id2 > 0) {
                return NSOrderedAscending;
            } else if (id1 > 0 && id2 < 0) {
                return NSOrderedDescending;
            } else {
                NSString *ward1Name = tempOptions[obj1];
                NSString *ward2Name = tempOptions[obj2];
                
                return [ward1Name compare:ward2Name];
            }
        }];
        sortedKeys = @[[sortedKeys arrayByAddingObject:@(-1)]];
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
    if (selectionVC.view != nil) {
        [selectionVC setOptions:options withDetails:optionDetails orderedAs:sortedKeys];
        
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
    }
    
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [super textFieldDidEndEditing:textField];
    
    if (textField == otherWardField) {
        self.selectedWard.name = textField.text;
    }
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
        
        if ([newWardID isEqualToNumber:@(-1)]) {
            // create / load a blank custom ward
            PRWard *customWard = [self blankCustomWard];
            self.selectedWard = customWard;
            
        } else {
            
            if (self.selectedWard == nil ||  ![newWardID isEqualToNumber:self.selectedWard.id]) {
                PRWard *newWard = [[wards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", newWardID]] firstObject];
                
                self.selectedWard = newWard;
            }
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
