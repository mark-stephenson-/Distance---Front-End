//
//  PRAPIManager.h
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

extern NSString *const TDAPIErrorDomain;

typedef enum {kTDCAPIErrorUnexpectedResponse, kTDCAPIErrorUnexpectedRequest, kTDAPIErrorCommitDownloadContext} TDCAPIErrorCode;

@interface PRAPIManager : NSObject
{
    NSNumberFormatter *numberFormatter;
    NSDateFormatter *dateFormatter;
    
    AFHTTPSessionManager *sessionManager;
    
    NSMutableSet *nodesDownloading;
}


+(instancetype)sharedManager;

@property (nonatomic, strong) NSURL *baseURL;

/// Success and Failure block are called on the main thread. AlertController in the failure block is configured to have  retry button.
-(void)getTrustHierarchy;

/*!
 * @discussion Localized strings should be reference with unique keys. Each Core node object has a unique identifier. This is used as "TDC.cms.<entity_name>.<identifier>" to create a unique identifier with some context given by the entity name.
 * @param identifier The keypath which represents the unique identifying property for this CoreData class, e.g. "id", "identifier", @"productID". This can be either a string or a number, hence the parameter is specified as an NSObject.
 * @param entityName The name of the CoreData class which is prefixed to the identifier.
 * @return An NSString of the form TDC.cms.<entity_name>.<identifier> if identifier is an NSString or an NSNumber, otherwise nil.
 */
-(NSString *)TDCLocalizationsKeyForTDCoreIdentifier:(NSObject *) identifier forEntityNamed:(NSString *) entityName;

@end
