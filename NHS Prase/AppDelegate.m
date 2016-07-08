//
//  AppDelegate.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "AppDelegate.h"

#import "PRTheme.h"
#import <TheDistanceKit/TheDistanceKit_API.h>

#import <MagicalRecord/MagicalRecord.h>
#import <Crashlytics/Crashlytics.h>
#import "PRAPIManager.h"

NSString *const APIManagerBaseURLKey = @"APIManagerBaseURL";

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[PRTheme sharedTheme] setLanguageIdentifier:@"en"];
    
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"PRModel.sqlite"];
    
    // set up app wide inset
    [[TDTextField appearance] setTextInsets:UIEdgeInsetsMake(6, 15, 6, 15)];
    [[TDTextField appearance] setBorderColor:[[PRTheme sharedTheme] mainColor]];
    [[TDTextField appearance] setBorderWidth:1.0];
    [[TDTextField appearance] setAccessoryImage:[UIImage imageNamed:@"select"]];
    [[TDTextField appearance] setImageInsets:UIEdgeInsetsMake(4, 0, 4, 10)];
    
    [[TDSegmentedControl appearance] setTextBuffer:20];
    
    // set the base URL to be the staging / live URL depending on the release mode
    NSDictionary *serverURLs = [[NSBundle mainBundle] infoDictionary][@"PRServerURLs"];
    NSString *savedUrlKey = [[NSUserDefaults standardUserDefaults] valueForKey:APIManagerBaseURLKey];

    NSString *urlKey = nil;
#if defined(DEBUG) || defined(BETA_TESTING)
        urlKey = @"Staging";
#else 
        urlKey = @"Live";
#endif
    
    if (![savedUrlKey isEqualToString:urlKey]) {
        [[PRAPIManager sharedManager] clearAllDataAndWait];
    }
    
    NSString *urlString = serverURLs[urlKey];
    [[NSUserDefaults standardUserDefaults] setValue:urlKey forKey:APIManagerBaseURLKey];
    
    PRAPIManager *manager = [PRAPIManager sharedManager];
    manager.baseURL = [NSURL URLWithString:urlString];
    
#ifndef DEBUG
    [Crashlytics startWithAPIKey:@"015a3121c76ea8baec90c4a97c7bd1976400adad"];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    RotationPreference currentPreference = [[PRTheme sharedTheme] currentRotationPreference];
    
    NSUInteger orientation = UIInterfaceOrientationMaskAll;
    switch (currentPreference) {
        case kRotationPreferenceLandscape:
            orientation = UIInterfaceOrientationMaskLandscape;
            break;
        case kRotationPreferencePortrait:
            orientation = UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        default:
            break;
    }
    
//    NSLog(@"[%@] Getting rotation preference: %lu", self, (unsigned long)orientation);
    
    return orientation;
}


@end
