//
//  PRDateSelectionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRDateSelectionViewController.h"

@interface PRDateSelectionViewController ()

@end

@implementation PRDateSelectionViewController

-(NSDate *)selectedDate
{
    return datePicker.date;
}

-(void)setSelectedDate:(NSDate *)selectedDate
{
    datePicker.date = selectedDate;
}

-(void)dismissSelectionViewController:(id)sender
{
    [self.selectionDelegate dateSelectionViewControllerRequestsDismissal:self];
}

-(void)cancelSelectionViewController:(id)sender
{
    [self.selectionDelegate dateSelectionViewControllerRequestsCancel:self];
}

@end
