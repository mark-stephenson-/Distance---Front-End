//
//  PRCommentsSummaryViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionViewController.h"

@class PRRecord;

@interface PRCommentsSummaryViewController : PRQuestionViewController <UITableViewDataSource>
{
    IBOutlet UITableView *commentsTableView;
    IBOutlet UITableView *concernsTableView;
    
    IBOutlet UILabel *goodButtonPromptLabel;
    IBOutlet UILabel *concernButtonPromptLabel;
}

@property (nonatomic, strong) PRRecord *record;

@end
