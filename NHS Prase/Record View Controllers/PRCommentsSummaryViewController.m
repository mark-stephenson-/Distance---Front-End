//
//  PRCommentsSummaryViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRCommentsSummaryViewController.h"

#import "PRRecord.h"
#import "PRNote.h"
#import "PRConcern.h"

#import "PRGoodViewController.h"
#import "PRPIRTViewController.h"

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
    if ([note isValid]) {
        [self.record addGoodNotesObject:note];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pirtViewControllerDidFinish:(PRPIRTViewController *)pirtVC withConcern:(PRConcern *)concern
{
    if ([concern isValid]) {
        [self.record addConcernsObject:concern];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [pirtVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)addSomethingGood:(id)sender
{
    PRGoodViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodVC"];
    toPresent.delegate = self;
    toPresent.record = self.record;
    
    UIView *loadView = toPresent.view;
    PRInputAccessoryView *accessoryView = [self accessoryView];
    toPresent.noteView.inputAccessoryView = accessoryView;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:toPresent animated:YES completion:nil];
    }];
}

-(void)addConcern:(id)sender
{
    PRPIRTViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"PIRTVC"];
    toPresent.record = self.record;
    toPresent.pirtDelegate = self;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:toPresent animated:YES completion:nil];
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
