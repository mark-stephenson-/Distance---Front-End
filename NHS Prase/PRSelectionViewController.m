
//
//  PRSelectionViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 12/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSelectionViewController.h"
#import "PRTheme.h"
#import "UIViewController+Scrolling.h"

@interface PRSelectionViewController ()

@end

@implementation PRSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableContainer.layer.cornerRadius = 5.0;
    tableContainer.layer.borderWidth = 2.0;
    tableContainer.layer.borderColor = [[PRTheme sharedTheme] mainColor].CGColor;
    tableContainer.clipsToBounds = YES;
    
    // ensure there are buttons if the content is very large.
    [self setupScrollingButtonsOnContainer:self.tableView];
}

-(void)dealloc
{
    [self tearDownScrollingContainer];
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
}

@end
