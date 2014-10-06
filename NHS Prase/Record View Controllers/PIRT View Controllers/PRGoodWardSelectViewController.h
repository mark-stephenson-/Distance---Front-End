//
//  PRGoodWardSelectViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 19/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSelectionViewController.h"

@class PRWardSelectViewController;

@class PRRecord;
@class PRWard;

@interface PRGoodWardSelectViewController : PRSelectionViewController
{
    PRWardSelectViewController *childSelect;
}

@property (nonatomic, strong) PRWard *selectedWard;

@end
