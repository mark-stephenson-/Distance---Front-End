//
//  PRRecordSummaryViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRFormViewController.h"

@class PRRecord;

@interface PRRecordSummaryViewController : PRFormViewController
{
    BOOL shouldUpdateAdditionalTime;
}
@property (nonatomic, strong) PRRecord *record;

@end
