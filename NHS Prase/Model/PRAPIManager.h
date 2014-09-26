//
//  PRAPIManager.h
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <TheDistanceKit/TheDistanceKit.h>

@interface PRAPIManager : TDAPIManager
{
   
}


/// Success and Failure block are called on the main thread. AlertController in the failure block is configured to have  retry button.
-(void)getTrustHierarchy;



@end
