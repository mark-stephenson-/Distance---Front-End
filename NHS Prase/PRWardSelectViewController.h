//
//  PRWardSelectViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//


#import <TheDistanceKit/TheDistanceKit.h>
#import "PRViewController.h"

/*!
 * @class PRWardSelectViewController
 * @discussion Contains the logic to display lists of trusts, hospitals and wards. The hospitals are dependent on the trust selected and the wards on the hospital. A series of TDSelectionViewControllers are used to present the options. Ward selection is done in multiple places throughout the app so this class should be subclass where appropriate so only the trust-hospital-ward tree is kept in a single place in the app. Hospital and ward selection is disabled until the parent's define a single list of appropriate hospitals.
 */
@interface PRWardSelectViewController : PRViewController <UITextFieldDelegate, TDSelectionViewControllerDelegate>
{
    IBOutlet UITextField *trustField;
    IBOutlet UITextField *hospitalField;
    IBOutlet UITextField *wardField;
    
    NSArray *trusts;
    NSDictionary *hospitals;
    NSDictionary *wards;
}

@property (nonatomic, strong) NSString *selectedTrust;
@property (nonatomic, strong) NSString *selectedHospital;
@property (nonatomic, strong) NSString *selectedWard;

-(void)refreshViews;

@end
