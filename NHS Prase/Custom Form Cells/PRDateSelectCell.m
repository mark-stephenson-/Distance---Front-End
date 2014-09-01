//
//  PRDateSelectCell.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRDateSelectCell.h"



@implementation PRDateSelectCell

-(BOOL)select
{
    // present a PRDateSelectionViewController
    
    PRDateSelectionViewController *dateVC = [self.formViewController.storyboard instantiateViewControllerWithIdentifier:self.selectionIdentifier];
    
    dateVC.title = self.selectionVCTitle;
    dateVC.selectionDelegate = self;
    dateVC.selectedDate = selectedDate ? selectedDate : [NSDate date];
    
    UINavigationController *selectionNav = [[UINavigationController alloc] initWithRootViewController:dateVC];
    
    if (self.modalPresentationStyle != nil) {
        selectionNav.modalPresentationStyle = self.modalPresentationStyle.integerValue;
    } else {
        selectionNav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.formViewController presentViewController:selectionNav animated:YES completion:nil];
    }];
    
    return YES;
}

-(void)dateSelectionViewControllerRequestsDismissal:(PRDateSelectionViewController *)dateSelector
{
    selectedDate = dateSelector.selectedDate;
    self.value = selectedDate;
    
    [self.formViewController dismissViewControllerAnimated:YES completion:nil];
    [self done];
}

-(void)dateSelectionViewControllerRequestsCancel:(PRDateSelectionViewController *)dateSelector
{
    [self.formViewController dismissViewControllerAnimated:YES completion:nil];
    [self done];
}

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        selectedDate = [self.formatter dateFromString:value];
        if (selectedDate) {
            [super setValue:value];
        }
    }
    
    if ([value isKindOfClass:[NSDate class]]) {
        selectedDate = (NSDate *) value;
        [super setValue:[self.formatter stringFromDate:selectedDate]];
    }
    
    if (value == nil) {
        [super setValue:nil];
    }
}

@end
