//
//  PRCommentsSummaryViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRCommentsSummaryViewController.h"

#import "PRRecord.h"

@interface PRCommentsSummaryViewController ()

@end

@implementation PRCommentsSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    commentsTableView.layer.borderColor = self.view.tintColor.CGColor;
    commentsTableView.layer.borderWidth = 2.0;
    
    concernsTableView.layer.borderColor = self.view.tintColor.CGColor;
    concernsTableView.layer.borderWidth = 2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (goodButtonPromptLabel.preferredMaxLayoutWidth != goodButtonPromptLabel.frame.size.width) {
        goodButtonPromptLabel.preferredMaxLayoutWidth = goodButtonPromptLabel.frame.size.width;
        [self.view setNeedsLayout];
    }
    
    if (concernButtonPromptLabel.preferredMaxLayoutWidth != concernButtonPromptLabel.frame.size.width) {
        concernButtonPromptLabel.preferredMaxLayoutWidth = concernButtonPromptLabel.frame.size.width;
        [self.view setNeedsLayout];
    }
    
    [self.view layoutIfNeeded];
}

-(void)noteViewControllerDidFinish:(PRNoteViewController *)noteVC withNote:(PRNote *)note
{
    [self.record addGoodNotesObject:note];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pirtViewControllerDidFinish:(PRPIRTViewController *)pirtVC withConcern:(PRConcern *)concern
{
    [self.record addConcernsObject:concern];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [pirtVC dismissViewControllerAnimated:YES completion:nil];
    }];
}


#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *basicCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Basic"];
    
    if (tableView == commentsTableView) {
        basicCell.textLabel.text = @"No comments saved";
    } else {
        basicCell.textLabel.text = @"No concerns saved";
    }
    
    basicCell.textLabel.textColor = [UIColor lightGrayColor];
    basicCell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return basicCell;
}

@end
