//
//  PRWardSelectViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//


#import <TheDistanceKit/TheDistanceKit_API.h>
#import "PRViewController.h"

#define ALERT_CREATE_ERROR 222

@class PRTrust;
@class PRHospital;
@class PRWard;

/*!
 * @class PRWardSelectViewController
 * @discussion Contains the logic to display lists of trusts, hospitals and wards. The hospitals are dependent on the trust selected and the wards on the hospital. A series of TDSelectionViewControllers are used to present the options. Ward selection is done in multiple places throughout the app so this class should be subclass where appropriate so only the trust-hospital-ward tree is kept in a single place in the app. Hospital and ward selection is disabled until the parent's define a single list of appropriate hospitals.
 */
@interface PRWardSelectViewController : PRViewController <UITextFieldDelegate, TDSelectionViewControllerDelegate>
{
    IBOutlet UITextField *trustField;
    IBOutlet UITextField *hospitalField;
    IBOutlet UITextField *wardField;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet TDTextField *otherWardField;

    NSArray *trusts;
    NSArray *hospitals;
    NSArray *wards;
}

@property (nonatomic, strong) PRTrust *selectedTrust;
@property (nonatomic, strong) PRHospital *selectedHospital;
@property (nonatomic, strong) PRWard *selectedWard;


-(void)refreshViews;

-(BOOL)validateSelectedWard;
-(PRWard *)blankCustomWard;
-(void)commitCustomWard;

@end
