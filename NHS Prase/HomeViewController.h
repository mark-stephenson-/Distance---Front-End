//
//  HomeViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit_API.h>
#import "PRWardSelectViewController.h"

/*!
 * @class HomeViewController
 * @discussion Creates a new record based on the ward selected.
 */
@interface HomeViewController : PRWardSelectViewController <UIAlertViewDelegate>

-(IBAction)createRecord:(id)sender;
-(IBAction)goToLogIn:(id)sender;

@end
