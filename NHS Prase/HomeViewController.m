//
//  HomeViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "HomeViewController.h"

#import "PRSelectionViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hospitals = @[@"Harrogate and District"];
    wards = @{@"Harrogate and District": @[@"Bolton - Short stay",
                                           @"Farndale - Trauma and orthopeadics",
                                           @"Fountains - Short stay",
                                           @"Granby - Elderly medical",
                                           @"Harlow - Private patients",
                                           @"Littondale - Male surgical"]};
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)refreshViews
{
    hospitalField.text = selectedHospital;
    wardField.text = selectedWard;
    wardField.enabled = [hospitalField.text isNonNullString];
}

-(void)createRecord:(id)sender
{
    if ([hospitalField.text isNonNullString] && [wardField.text isNonNullString]) {
        
    } else {
        
        NSString *errorMessage = @"";
        
        if (![hospitalField.text isNonNullString]) {
            errorMessage = @"Please select your hospital.";
        }
        
        if (![wardField.text isNonNullString]) {
            errorMessage = [errorMessage stringByAppendingString:@"\nPlease select you ward."];
        }
        
        [[[UIAlertView alloc] initWithTitle:@"Cannot Create Record" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

-(void)goToLogIn:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    if (textField == hospitalField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitals.count];
        
        for (int h = 0; h < hospitals.count; h++) {
            // get localized string
            tempOptions[hospitals[h]] = hospitals[h];
        }
        
        options = tempOptions;
        sortedKeys = @[hospitals];
        selectedKey = selectedHospital;
        requiresSelection = YES;
        selectionKey = @"hospital";
        
    } else if (textField == wardField) {
        
        NSArray *hospitalWards = wards[selectedHospital];
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitalWards.count];
        
        for (int w = 0; w < hospitalWards.count; w++) {
            // get localized string
            tempOptions[hospitalWards[w]] = hospitalWards[w];
        }
        
        options = tempOptions;
        sortedKeys = @[hospitalWards];
        selectedKey = selectedWard;
        requiresSelection = NO;
        selectionKey = @"ward";
    }
    
    PRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HospitalWardSelectionVC"];
    [selectionVC setOptions:options withDetails:nil orderedAs:sortedKeys];
    
    if (selectedKey != nil) {
        selectionVC.selectedKeys = [NSMutableSet setWithObject:selectedKey];
    }
    
    selectionVC.requiresSelection = requiresSelection;
    selectionVC.tableView.allowsMultipleSelection = NO;
    selectionVC.delegate = self;
    selectionVC.key = selectionKey;
    
    // present the configured selection vc
    UINavigationController *selectionNav = [[UINavigationController alloc] initWithRootViewController:selectionVC];
    selectionNav.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentViewController:selectionNav animated:YES completion:nil];
    
    return NO;
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    NSString *selectionKey = selectionVC.key;
    
    if ([selectionKey isEqualToString:@"hospital"]) {
        NSString *newHospital = [[selectionVC selectedKeys] anyObject];
        if (![newHospital isEqualToString:selectedHospital]) {
            selectedHospital = newHospital;
            selectedWard = nil;
        }
    }
    
    if ([selectionKey isEqualToString:@"ward"]) {
        selectedWard = [[selectionVC selectedKeys] anyObject];
    }
    
    [self refreshViews];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
