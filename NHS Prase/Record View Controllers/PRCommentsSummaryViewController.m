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
    validGoodNote = [note isValid];
    if (validGoodNote) {
        if (self.record.goodNotes.count == 0) {
            [self.record addGoodNotesObject:note];
        }
    } else {
        if (self.record.goodNotes.count > 0) {
            self.record.goodNotes = [NSSet set];
        }
    }
    
    [self refreshPIRTViews];
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.record.goodNotes.count > 0) {
            NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"question.note-added.title", nil, nil, @"Comment Saved", @"The alert title shown when a good note has been saved.");
            NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"question.note-added.message", nil, nil, @"Your comment has been saved.", @"The alert message shown when a good note has been saved.");
            [self showAlertWithTitle:alertTitle
                             message:alertMessage
                         cancelTitle:nil
                        buttonTitles:nil
                             actions:nil];
        }
    }];
}

-(void)pirtViewControllerDidFinish:(PRPIRTViewController *)pirtVC withConcern:(PRConcern *)concern
{
    validConcern = [concern isValid];
    if (validConcern) {
        if (self.record.concerns.count == 0) {
            [self.record addConcernsObject:concern];
        }
    } else {
        if (self.record.concerns.count > 0) {
            self.record.concerns = [NSSet set];
        }
    }
    
    [self refreshPIRTViews];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [pirtVC dismissViewControllerAnimated:YES completion:^{
            if (self.record.concerns.count > 0) {
                NSString *alertTitle = TDLocalizedStringWithDefaultValue(@"question.concern-added.title", nil, nil, @"Concern Saved", @"The alert title shown when a concern has been saved.");
                NSString *alertMessage = TDLocalizedStringWithDefaultValue(@"question.concern-added.message", nil, nil, @"Your concern has been saved.", @"The alert message shown when a concern has been saved.");
                [self showAlertWithTitle:alertTitle
                                 message:alertMessage
                             cancelTitle:nil
                            buttonTitles:nil
                                 actions:nil];
            }
        }];
    }];
}

-(void)addSomethingGood:(id)sender
{
    PRGoodViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodVC"];
    toPresent.delegate = self;
    toPresent.record = self.record;
    
    if (self.record.goodNotes.count > 0) {
        toPresent.note = [self.record.goodNotes anyObject];
    }
    
    // force load the view to configure the note view
    PRInputAccessoryView *accessoryView = [self accessoryView];
    if (toPresent.view != nil) {
        toPresent.titleLabel.TDLocalizedStringKey = @"good-comments.label.title";
        toPresent.titleLabel.text = TDLocalizedStringWithDefaultValue(@"good-comments.label.title", nil, nil, @"Do you want to tell us something that has been good about your care?\nWe would like to know about the good experiences of care either you, or others, have had during this hospital stay.", @"The title text when adding a good note from the comments summary tab.");
        toPresent.noteView.inputAccessoryView = accessoryView;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:toPresent animated:YES completion:nil];
        }];
    }
}

-(void)addConcern:(id)sender
{
    PRPIRTViewController *toPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"PIRTVC"];
    toPresent.record = self.record;
    toPresent.pirtDelegate = self;
    
    if (self.record.concerns.count > 0) {
        toPresent.concern = [self.record.concerns anyObject];
    }
    
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
