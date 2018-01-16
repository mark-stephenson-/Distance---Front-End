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

#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/MagicalRecord.h>
#import "PRNote.h"

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
    
    self.selectedWard = self.note.ward;
    
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

-(void)submit:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(noteViewControllerDidFinish:withNote:)]) {
        
        PRNote *newNote = [PRNote MR_createEntity];
        newNote.text = self.noteText;
        newNote.ward = self.selectedWard;
        
        [self.delegate noteViewControllerDidFinish:self withNote:newNote];
    }
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [super textFieldShouldBeginEditing:textField];
    
    canDismissKeyboard = YES;
    [self.noteView resignFirstResponder];
    
    PRGoodWardSelectViewController *wardSelect = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodWardSelect"];
    wardSelect.delegate = self;
    wardSelect.selectedWard = self.selectedWard;
    wardSelect.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:wardSelect animated:YES completion:nil];
    
    return NO;
}

#pragma mark - Selection Methods
-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    canDismissKeyboard = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        if (canShowKeyboard) {
            [self.noteView becomeFirstResponder];
        }
    }];
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    canDismissKeyboard = NO;
    
    if ([selectionVC isKindOfClass:[PRGoodWardSelectViewController class]]) {
        PRWard *newWard = ((PRGoodWardSelectViewController *) selectionVC).selectedWard;
        if (newWard != nil) {
            self.selectedWard = newWard;
            [self refreshViews];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (canShowKeyboard) {
            [self.noteView becomeFirstResponder];
        }
    }];
}

@end
