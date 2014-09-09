//
//  PRRecordViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSegmentTabViewController.h"

@class PRQuestionnaire;

@interface PRRecordViewController : PRSegmentTabViewController <UIAlertViewDelegate>
{
    IBOutlet UILabel *progressLabel;
}

@property (nonatomic, strong) PRQuestionnaire *questionnaire;

-(IBAction)goHome:(id)sender;

@end
