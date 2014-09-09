//
//  PRRecordSummaryViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRButton;

@interface PRRecordSummaryViewController : UIViewController

@property (nonatomic, strong) IBOutlet PRButton *basicDataButton;
@property (nonatomic, strong) IBOutlet UILabel *questionnaireLabel;

@end
