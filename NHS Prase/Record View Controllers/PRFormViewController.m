//
//  PRFormViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRFormViewController.h"

#import "UIViewController+Scrolling.h"

@interface PRFormViewController ()

@end

@implementation PRFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // ensure there are buttons if the content is very large.
    if (self.tableView != nil) {
        [self setupScrollingButtonsOnContainer:self.tableView];
    }
}

-(void)dealloc
{
    [self tearDownScrollingContainer];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.view) {
        if ([keyPath isEqualToString:@"frame"]) {
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
                CGRect oldFrame = [change[@"old"] CGRectValue];
                CGRect newFrame = [change[@"new"] CGRectValue];
                
                if (!CGSizeEqualToSize(oldFrame.size, newFrame.size)) {
                    NSLog(@"%@ -> %@", NSStringFromCGRect(oldFrame), NSStringFromCGRect(newFrame));
                    [self.tableView reloadData];
                }
            }
            
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (willAppear && !hasAppeared && NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        // only force reload if using self-sizing cells on iOS 8 as the cells are initially calculated to be the wrong height.
        [self clearSizingCache];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
