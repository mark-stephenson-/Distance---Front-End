//
//  HomeViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <TheDistanceKit/TheDistanceKit.h>

@interface HomeViewController : UIViewController <UITextFieldDelegate, TDSelectionViewControllerDelegate>
{
    IBOutlet UITextField *hospitalField;
    IBOutlet UITextField *wardField;
    IBOutlet UIButton *createButton;
    
    NSArray *hospitals;
    NSDictionary *wards;
    
    NSString *selectedHospital;
    NSString *selectedWard;
}

-(IBAction)createRecord:(id)sender;
-(IBAction)goToLogIn:(id)sender;

@end
