//
//  PRGoodViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRGoodViewController.h"

@interface PRGoodViewController ()

@end

@implementation PRGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.thisWard = @"Bolton - Short stay";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshViews];
}

-(void)setWard:(NSString *)ward
{
    _ward = ward;
    
    wardSelectionField.text = ward;
}

-(void)refreshViews
{
    wardSelectionField.enabled = thisWardControl.selectedSegmentIndex != 0;
    if (!wardSelectionField.enabled) {
        wardSelectionField.text = self.thisWard;
    }
}

-(void)segmentChanged:(id)sender
{
    [self refreshViews];
}

#pragma mark - TextField Delegate

-(NSDictionary *)wardOptions
{
    static NSDictionary *wards = nil;
    
    if (wards == nil) {
        wards = @{@1:@"Bolton - Short stay",
                  @2:@"Farndale - Trauma and orthopeadics",
                  @3:@"Fountains - Short stay",
                  @4:@"Granby - Elderly medical",
                  @5:@"Harlow - Private patients",
                  @6:@"Littondale - Male surgical"};
    }
    
    return wards;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    TDSelectionViewController *basicSelection = (TDSelectionViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"PRBasicSelectionVC"];
    
    basicSelection.title = @"Ward";
    
    NSDictionary *wardOptions = [self wardOptions];
    NSArray *order = @[[wardOptions.allKeys sortedArrayUsingSelector:@selector(compare:)]];
    
    [basicSelection setOptions:wardOptions
                   withDetails:nil
                     orderedAs:order];
    
    basicSelection.tableView.allowsMultipleSelection = NO;
    basicSelection.delegate = self;
    basicSelection.requiresSelection = YES;
    
    UINavigationController *selectionNav = [[UINavigationController alloc] initWithRootViewController:basicSelection];
    
    selectionNav.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentViewController:selectionNav animated:YES completion:nil];
    
    return NO;
}

#pragma mark - Selection Methods

-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    NSNumber *selected = [selectionVC.selectedKeys anyObject];
    self.ward = [self wardOptions][selected];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
