//
//  PRWardSelectViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//


#import <TheDistanceKit/TheDistanceKit.h>

@interface PRWardSelectViewController : UIViewController <UITextFieldDelegate, TDSelectionViewControllerDelegate>
{
    IBOutlet UITextField *trustField;
    IBOutlet UITextField *hospitalField;
    IBOutlet UITextField *wardField;
    
    NSArray *trusts;
    NSDictionary *hospitals;
    NSDictionary *wards;
    
}

-(void)refreshViews;

@property (nonatomic, strong) NSString *selectedTrust;
@property (nonatomic, strong) NSString *selectedHospital;
@property (nonatomic, strong) NSString *selectedWard;

@end
