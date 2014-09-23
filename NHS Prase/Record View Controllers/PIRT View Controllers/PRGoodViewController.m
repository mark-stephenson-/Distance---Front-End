//
//  PRGoodViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRGoodViewController.h"

#import "PRGoodWardSelectViewController.h"
#import "PRRecord.h"

#import "PRWard.h"
#import "PRHospital.h"
#import "PRTrust.h"

@interface PRGoodViewController ()

@end

@implementation PRGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.selectedWard == nil) {
        self.selectedWard = self.record.ward;
        thisWardControl.selectedSegmentIndex = 0;
    } else {
        thisWardControl.selectedSegmentIndex = 1;
    }
    
    [self refreshViews];
}

-(void)refreshViews
{
    wardSelectionField.enabled = thisWardControl.selectedSegmentIndex != 0;
    
    if (!wardSelectionField.enabled) {
        self.selectedWard = self.record.ward;
    }
    
    wardSelectionField.text = [NSString stringWithFormat:@"%@, %@, %@", self.selectedWard.name, self.selectedWard.hospital.name, self.selectedWard.hospital.trust.name];
}

-(void)segmentChanged:(id)sender
{
    [self refreshViews];
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    PRGoodWardSelectViewController *wardSelect = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodWardSelect"];
    wardSelect.delegate = self;
    wardSelect.record = self.record;
    wardSelect.selectedWard = self.selectedWard;
    wardSelect.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:wardSelect animated:YES completion:nil];
    
    return NO;
}

#pragma mark - Selection Methods


-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    if ([selectionVC isKindOfClass:[PRGoodWardSelectViewController class]]) {
        self.selectedWard = ((PRGoodWardSelectViewController *) selectionVC).selectedWard;
        [self refreshViews];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
