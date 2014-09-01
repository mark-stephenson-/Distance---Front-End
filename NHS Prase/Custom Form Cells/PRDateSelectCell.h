//
//  PRDateSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TDFormKit/TDFormKit.h>
#import "PRDateSelectionViewController.h"

@interface PRDateSelectCell : TDTextFieldCell <PRDateSelectionDelegate>
{
    NSDate *selectedDate;
}

@property (nonatomic, weak) NSDateFormatter *formatter;
@property (nonatomic, strong) NSString *selectionVCTitle;
@property (nonatomic, strong) NSString *selectionIdentifier;

@property (nonatomic, strong) NSNumber *modalPresentationStyle;

@end
