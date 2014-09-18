
//
//  PRSelectionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 12/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSelectionViewController.h"
#import "PRTheme.h"

@interface PRSelectionViewController ()

@end

@implementation PRSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.layer.cornerRadius = 5.0;
    self.tableView.layer.borderWidth = 2.0;
    self.tableView.layer.borderColor = [[PRTheme sharedTheme] mainColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // override superclasses implementation
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    TDTableViewCell *cell = (TDTableViewCell *) [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Reloading just the row or begin/endUpdates should resize cells but all appear not to. Probably a bug in iOS 8's resizing cells. Work around is to reload the entire table.
    [self.tableView reloadData];
}

@end
