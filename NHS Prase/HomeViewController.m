//
//  HomeViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "HomeViewController.h"

#define ALERT_GO_TITLE 111

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hospitals = @[@"Harrogate and District"];
    wards = @{@"Harrogate and District": @[@"Bolton - Short stay",
                                           @"Farndale - Trauma and orthopeadics",
                                           @"Fountains - Short stay",
                                           @"Granby - Elderly medical",
                                           @"Harlow - Private patients",
                                           @"Littondale - Male surgical"]};
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyTheme) name:TDThemeLanguageChange object:nil];
    
    [self applyTheme];
    [self refreshViews];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TDThemeLanguageChange object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Language Methods

-(void)toggleLanguage:(id)sender
{
    static BOOL isFrench = NO;
    
    [[TDTheme sharedTheme] setLanguageIdentifier:isFrench ? @"en" : @"fr"];
    isFrench = !isFrench;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)refreshViews
{
    hospitalField.text = selectedHospital;
    wardField.text = selectedWard;
    wardField.enabled = [hospitalField.text isNonNullString];
}

-(void)createRecord:(id)sender
{
    if (true) { //[hospitalField.text isNonNullString] && [wardField.text isNonNullString]) {
        
        [self performSegueWithIdentifier:@"CreateRecord" sender:self];
        
    } else {
        
        NSString *errorMessage = @"";
        
        if (![hospitalField.text isNonNullString]) {
            
            errorMessage = TDLocalizedString(@"home.error.no-hospital", @"Error message shown when the user has not selected a hospital.");
        }
        
        if (![wardField.text isNonNullString]) {
            if (![hospitalField.text isNonNullString]) {
                errorMessage = [errorMessage stringByAppendingString:@"\n"];
            }

            errorMessage = [errorMessage stringByAppendingString:TDLocalizedString(@"home.error.no-ward", @"Error message shown when the user has not selected a ward.")];
        }
        
        NSString *errorTitle = TDLocalizedString(@"home.error.create-record", @"Error title when the user cannot create a record.");
        [[[UIAlertView alloc] initWithTitle:errorTitle message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

#pragma mark - Delegate Methods

// Show a TDSelectionViewController and prevent a keyboard from showing;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSDictionary *options;
    NSArray *sortedKeys;
    NSString *selectedKey;
    BOOL requiresSelection;
    NSString *selectionKey;
    
    if (textField == hospitalField) {
        
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitals.count];
        
        for (int h = 0; h < hospitals.count; h++) {
            // get localized string
            tempOptions[hospitals[h]] = hospitals[h];
        }
        
        options = tempOptions;
        sortedKeys = @[hospitals];
        selectedKey = selectedHospital;
        requiresSelection = YES;
        selectionKey = @"hospital";
        
    } else if (textField == wardField) {
        
        NSArray *hospitalWards = wards[selectedHospital];
        NSMutableDictionary *tempOptions = [NSMutableDictionary dictionaryWithCapacity:hospitalWards.count];
        
        for (int w = 0; w < hospitalWards.count; w++) {
            // get localized string
            tempOptions[hospitalWards[w]] = hospitalWards[w];
        }
        
        options = tempOptions;
        sortedKeys = @[hospitalWards];
        selectedKey = selectedWard;
        requiresSelection = NO;
        selectionKey = @"ward";
    }
    
    TDSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PRBasicSelectionVC"];
    [selectionVC setOptions:options withDetails:nil orderedAs:sortedKeys];
    
    if (selectedKey != nil) {
        selectionVC.selectedKeys = [NSMutableSet setWithObject:selectedKey];
    }
    
    selectionVC.requiresSelection = requiresSelection;
    selectionVC.tableView.allowsMultipleSelection = NO;
    selectionVC.delegate = self;
    selectionVC.key = selectionKey;
    
    // present the configured selection vc
    UINavigationController *selectionNav = [[UINavigationController alloc] initWithRootViewController:selectionVC];
    selectionNav.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentViewController:selectionNav animated:YES completion:nil];
    
    return NO;
}

-(void)selectionViewControllerRequestsDismissal:(TDSelectionViewController *)selectionVC
{
    NSString *selectionKey = selectionVC.key;
    
    if ([selectionKey isEqualToString:@"hospital"]) {
        NSString *newHospital = [[selectionVC selectedKeys] anyObject];
        if (![newHospital isEqualToString:selectedHospital]) {
            selectedHospital = newHospital;
            selectedWard = nil;
        }
    }
    
    if ([selectionKey isEqualToString:@"ward"]) {
        selectedWard = [[selectionVC selectedKeys] anyObject];
    }
    
    [self refreshViews];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionViewControllerRequestsCancel:(TDSelectionViewController *)selectionVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation Methods

-(void)goToLogIn:(id)sender
{
    NSString *alertTitle = @"Cancel Record";
    NSString *alertMessage = @"Returning to the title screen will delete any entered data. Are you sure you want to continue?";
    NSString *buttonTitle = @"Cancel Record";
    NSString *cancelTitle = @"Continue";
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        // iOS 8 Deprecation
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:self
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:buttonTitle, nil];
        alert.tag = ALERT_GO_TITLE;
        [alert show];
    }
}

// iOS 8 Deprecation
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == ALERT_GO_TITLE) {
            [self continueTitle];
        }
    }
}

// iOS 8 Deprecation
-(void)continueTitle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
