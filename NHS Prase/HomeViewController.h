//
//  HomeViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit.h>
#import "PRWardSelectViewController.h"

@interface HomeViewController : PRWardSelectViewController <UIAlertViewDelegate>
{
    IBOutlet UIButton *createButton;
}

-(IBAction)createRecord:(id)sender;
-(IBAction)goToLogIn:(id)sender;
-(IBAction)toggleLanguage:(id)sender;

@end
