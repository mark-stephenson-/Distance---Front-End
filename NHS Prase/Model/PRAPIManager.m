//
//  PRAPIManager.m
//  NHS Prase
//
//  Created by Josh Campion on 24/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRAPIManager.h"

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <TheDistanceKit/TheDistanceKit.h>

#import "PRTrust.h"
#import "PRHospital.h"
#import "PRWard.h"

#define PR_COLLECTION_TOKEN @"26e72f9ad86c8ef4802bc5cdaccf58cf"
#define PR_API_KEY @"a7ceffb72de96b5c17f3d70a76853348"

#define NODE_TYPE_TRUST 2
#define NODE_TYPE_HOSPITAL 3
#define NODE_TYPE_WARD 4

#define NODE_TYPE_QUESTION 1
#define NODE_TYPE_ANSWER_TYPE 6
#define NODE_TYPE_OPTION 5

NSString *const TDAPIErrorDomain = @"TDAPIManagerError";

@implementation PRAPIManager

+(instancetype)sharedManager
{
    static PRAPIManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
        sharedManager.baseURL = [NSURL URLWithString:@"http://prase.staging2.thedistance.co.uk"];
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    return self;
}

-(void)setBaseURL:(NSURL *)baseURL
{
    _baseURL = baseURL;
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:sessionConfig];
    // create a new background queue to return API calls from as most API calls will perform some work on the download response, e.g. CoreData saving / file writing
    [sessionManager setCompletionQueue:dispatch_queue_create("com.TheDistance.TDAPISessionCompletionQueue", NULL)];
    
    // configure the serializations
    AFJSONRequestSerializer *jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    [jsonRequestSerializer setValue:PR_COLLECTION_TOKEN forHTTPHeaderField:@"Collection-Token"];
    [jsonRequestSerializer setAuthorizationHeaderFieldWithUsername:PR_API_KEY password:@"password"];
    [jsonRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [jsonRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    sessionManager.requestSerializer = jsonRequestSerializer;
    
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    jsonResponseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json"]];
    
    sessionManager.responseSerializer = jsonResponseSerializer;
}

-(void)getTrustHierarchy
{
    [self TDCGetCommitAndLinkRelatedObjectsOfNodes:@[@"trust", @"hospital", @"ward"] withCompletion:^(BOOL success, NSArray *errors) {
        if (success) {
            NSLog(@"Got trust Hierarchy.");
        } else {
            NSLog(@"Failed to get trust Hierarchy: %@", errors);
        }
    }];
}

-(void)getQuestionHierarchy
{
    
}

#pragma mark - TDAPIManager Methods

#pragma mark Core Data Object Manipulation

/*!
 * @discussion Helper method to convert between NSStrings, NSNumbers, and NSDates, to translate safely to attributes on CoreData objects. This is done by checking the proposed value for a keypath against the NSAttributeType for the EntityDescirption. The dateFormatter ivar should be configured with the correct dateFormat variable in order for dates to be translated correctly.
 * @param entityDescription The description of the CoreData class to check the proposed value type for the given keypath against.
 * @param keyPath The keypath to check the attribute type against.
 * @param proposedValue The proposed value to set as the value for the keypath.
 * @return id A translated value which should be the correct class for setting on a CoreData object with given by the entityDescription parameter.
 */
-(id)safeValueForEntityDescription:(NSEntityDescription *) entityDescription withKeypath:(NSString *) keypath andProposedValue:(id) proposedValue
{
    NSDictionary *objectAttributes = entityDescription.attributesByName;
    NSString *entityKeypath = [self TDCEntityKeyForTDCKey:keypath forEntityNamed:entityDescription.name];
    
    if (objectAttributes[entityKeypath] != nil && proposedValue != [NSNull null] && proposedValue != nil) {
        
        id value = proposedValue;
        NSAttributeType attributeType = [objectAttributes[entityKeypath] attributeType];
        
        // convert between strings and numbers if appropriate
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = @([value  integerValue]);
        } else if ((attributeType == NSFloatAttributeType) && ([value isKindOfClass:[NSString class]])) {
            value = @([value doubleValue]);
        } else if (attributeType == NSDateAttributeType && [value isKindOfClass:[NSString class]]) {
            value = [dateFormatter dateFromString:(NSString *)value];
        }
        
        return value;
    } else {
        return nil;
    }
}

/*!
 * @discussion Helper method to allow automatic creation and configuring of CoreData objects from a dictionary of parameters, such as those return from JSON. If a CoreData object can be found with the same value for the identifier as the valie in the attributes dictionary, that object is fetched and configured with the remaining attributes.
 * @param attributes A dictionary containing a unique identifier, specfied by the identifier parameter. Other keys should be either keypaths of attributes on the CoreData object or accessible through the TDCKeyForEntityKeyPath:forEntityNamed: method.
 * @param identifier The key in the relationships dictionary which uniquely identifiers the CoreData object to set the attributes on. This should correspond to a keypath on the CoreData object, or accessible through the TDCEntityKeyForTDCKey:forEntityNamed: method. This determines whether an object will be fecthed and updated or created. It is thus assumed that the values for this property uniquely identify an object in the CoreData database.
 * @param context The context to create the relationships in. This will typically be a temporary download context.
 */
-(void)safeWriteAttributes:(NSDictionary *) attributes toManagedObject:(NSManagedObject *) object
{
    NSDictionary *objectAttributes = object.entity.attributesByName;
    
    for (NSString *attribute in objectAttributes.allKeys) {
        
        NSString *attributeKey = [self TDCKeyForEntityKeyPath:attribute forEntityNamed:object.entity.name];
        id value = attributes[attribute] ? : attributes[attributeKey];
        
        value = [self safeValueForEntityDescription:object.entity withKeypath:attribute andProposedValue:value];
        
        @try {
            [object setValue:value forKeyPath:attribute];
        }
        @catch (NSException *exception) {
            [self logErrorFromSelector:_cmd withFormat:@"%@", exception.description];
        }
    }
}

/*!
 * @discussion Helper method to allow automatic linking of CoreData objects through CoreData relationships.
 * @param relationships A dictionary containing a unique identifier, specfied by the identifier parameter. Other keys should be either keypaths of relationships on the CoreData object or accessible through the TDCKeyForEntityKeyPath:forEntityNamed: method.
 * @param identifier The key in the relationships dictionary which uniquely identifiers the CoreData object to set the relationships on. This should correspond to a keypath on the CoreData object, or accessible through the TDCEntityKeyForTDCKey:forEntityNamed: method.
 * @param context The context to create the relationships in. This will typically be a temporary download context.
 */
-(void)safeLinkRelationships:(NSDictionary *) relationships forManagedObject:(NSManagedObject *) object withIdentifierKey:(NSString *) identifier inContext:(NSManagedObjectContext *) context
{
    NSDictionary *objectRelationships = object.entity.relationshipsByName;
    
    for (NSString *relationship in objectRelationships.allKeys) {
        // should be a comma separate list of values
        
        NSString *relationshipIdentifierKey = [self TDCKeyForEntityKeyPath:relationship forEntityNamed:object.entity.name];
        NSString *relationshipIdentifierString = relationships[relationship] ? : relationships[relationshipIdentifierKey];
        
        NSString *destinationRelationshipClass = ((NSRelationshipDescription *)objectRelationships[relationship]).destinationEntity.managedObjectClassName;
        
        NSArray *relationshipIdentifiers = [relationshipIdentifierString componentsSeparatedByString:@","];
        for (NSString *identifierValueString in relationshipIdentifiers) {
            if ([identifierValueString isNonNullString]) {
                // convert from the string to a possible number if appropriate to uniquely identifier the destination object
                id identifierValue = [self safeValueForEntityDescription:[NSEntityDescription entityForName:destinationRelationshipClass inManagedObjectContext:context] withKeypath:identifier andProposedValue:identifierValueString];
                
                NSFetchRequest *relationshipValueRequest = [NSFetchRequest fetchRequestWithEntityName:destinationRelationshipClass];
                // identifier should be unique so once found we should stop looking for performance
                relationshipValueRequest.fetchLimit = 1;
                relationshipValueRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", identifier, identifierValue];
                
                NSManagedObject *value = [[NSManagedObject MR_executeFetchRequest:relationshipValueRequest inContext:context] firstObject];
                if (value != nil && [value isKindOfClass:NSClassFromString(destinationRelationshipClass)]) {
                    @try {
                        [object setValue:value forKey:relationship];
                    }
                    @catch (NSException *exception) {
                        [self logErrorFromSelector:_cmd withFormat:@"%@", exception.description];
                    }
                }
            }
        }
    }
}

#pragma mark CoreData Object Creation & Linking

/*!
 * @discussion Either creates, of fetches and updates CoreData objects sepcified by the keys in the dictionary parameter and sets their attributes using safeWriteAttributes:toManagedObject:.
 * @param dictionary Should contain keys uniquely identifiing a CoreData object (looked up using entityName and identifier) and values as NSDictionaries to be passed to safeWriteAttributes:toManagedObject:.
 * @param identifier The keypath that the objects will be looked up on for updating.
 * @param entityName The CoreData entity name whose relationships should be updated.
 * @param context The context to create the relationships in. This will typically be a temporary download context.
 */
///
-(void)commitObjectsWithAttributeInfo:(NSDictionary *) dictionary forEntityNamed:(NSString *) entityName withIdentifier:(NSString *) identifier inContext:(NSManagedObjectContext *) context
{
    // fetch all the existing objects in a single request rather than multiple requests
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSArray *allEntities = [NSManagedObject MR_executeFetchRequest:request inContext:context];
    
    // update or create all NSManagedObjects whose identifier is in the dictionary parameter
    NSArray *objectKeys = dictionary.allKeys;
    for (NSString *idKey in objectKeys) {
        
        id identifierValue = [self safeValueForEntityDescription:[NSEntityDescription entityForName:entityName inManagedObjectContext:context] withKeypath:identifier andProposedValue:idKey];
        NSManagedObject *thisObject = [[allEntities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", identifier, identifierValue]] firstObject];
        
        if (thisObject == nil) {
            // no existing saved entity so create one
            thisObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
        }
        
        // commit the new values
        NSDictionary *thisObjectInfo = dictionary[idKey];
        [self safeWriteAttributes:thisObjectInfo toManagedObject:thisObject];
    }
}

/*!
 * @discussion Fetches and Links CoreData objects sepcified by the keys in the dictionary parameter and links them using safeLinkRelationships:forManagedObject:withIdentifierKey:inContext:. All objects to be linked should already have been created, probably using commitObjectsWithAttributeInfo:forEntityNamed:inContext:.
 * @param dictionary Should contain keys uniquely identifiing a CoreData object (looked up using entityName and identifier) and values as NSDictionaries to be passed to safeLinkRelationships:forManagedObject:withIdentifierKey:inContext:.
 * @param identifier The keypath that the objects will be looked up on for creating the relationships.
 * @param entityName The CoreData entity name whose relationships should be updated.
 * @param context The context to create the relationships in. This will typically be a temporary download context.
 */
-(void)linkObjectsWithRelationshipInfo:(NSDictionary *) dictionary forEntityNamed:(NSString *) entityName withIdentifier:(NSString *) identifier inContext:(NSManagedObjectContext *) context
{
    // fetch all the existing objects in a single request rather than multiple requests
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSArray *allEntities = [NSManagedObject MR_executeFetchRequest:request inContext:context];
    
    // update all NSManagedObjects whose "id" are in the dictionary parameter
    NSArray *objectKeys = dictionary.allKeys;
    for (NSString *idKey in objectKeys) {
        
        id identifierValue = [self safeValueForEntityDescription:[NSEntityDescription entityForName:entityName inManagedObjectContext:context] withKeypath:identifier andProposedValue:idKey];
        
        
        // get the managed object for this idKey, i.e. the managed object represented by this dictionary
        NSManagedObject *thisObject = [[allEntities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", identifier, identifierValue]] firstObject];
        NSDictionary *thisObjectInfo = dictionary[idKey];
        
        if (thisObject == nil) {
            // no existing saved entity so create one
            [self logErrorFromSelector:_cmd withFormat:@"Cannot link to objects as no saved entity found for info: %@", thisObjectInfo];
        } else {
            [self safeLinkRelationships:thisObjectInfo forManagedObject:thisObject withIdentifierKey:@"id" inContext:context];
        }
    }
}

#pragma mark - The Core Integration

/*!
 * @discussion Makes a sequence of TDCGetCoreNode:withSuccess:andFailure: calls to get the nodes given in the nodes parameter. If all operations complete successfully the downloaded json is parsed into CoreData objects using the safe* TDAPIManager methods, commitObjectsWithAttributeInfo:forEntityNamed:withIdentifier:inContext:, and linkObjectsWithRelationshipInfo:forEntityNamed:withIdentifier:inContext:. Completion is called when all request tasks have completed and each download has been processed. If TheCore nodes are related using node-lookups and those relationships should be maintained in the CoreData data model, these should be downloaded in one single call to this method, to ensure they are linked properly after all download operations have been committed to the CoreData context.
 * @param nodes An array of node objects to send to TDCGetCoreNode:withSuccess:andFailure:, thus each entry can be an NSString representing a node name or an NSNumber representing a nodeType.
 * @param completion The block to run once all download opertaions have completed. If an error occurs, the errors property will be populated with the error objects returned. These should be parsed by the caller and presented to the user appropriately.
 */
-(void)TDCGetCommitAndLinkRelatedObjectsOfNodes:(NSArray *) nodes withCompletion:(void (^)(BOOL success, NSArray *errors)) completion
{
    if (nodesDownloading == nil) {
        nodesDownloading = [NSMutableSet set];
    }
    
    // ensure a node is only requested for download once.
    BOOL isUpdating = NO;
    for (NSObject *node in nodes) {
        if ([nodesDownloading containsObject:node]) {
            isUpdating = YES;
            [self logErrorFromSelector:_cmd withFormat:@"Cannot start downloading nodes as one node type is already downloading\nRequested: %@\nDownloading: %@", node, nodesDownloading];
        }
    }
    
    if (!isUpdating) {
        // store the objects requested to prevent duplicated downloading
        [nodesDownloading addObjectsFromArray:nodes];
        
        // create a dictionary to store the download results against each node key
        NSMutableDictionary *nodeDictionaries = [NSMutableDictionary dictionaryWithCapacity:nodes.count];
        NSMutableArray *errors = [NSMutableArray arrayWithCapacity:nodes.count];
        
        void (^configureNodes)() = ^{
            // check each GET request has completed
            if (nodeDictionaries.count == nodes.count) {
                
                [self logErrorFromSelector:_cmd withFormat:@"All requests complete."];
                
                if (![nodeDictionaries.allValues containsObject:[NSNull null]]) {
                    // if NSNull entries then there has been an error so only go to complete properly if all operations have completed correctly to prevent a partially correct database which could have incorrect links
                    
                    // create an explicit new 'download' context to continue writing in the background
                    NSManagedObjectContext *context = [NSManagedObjectContext MR_context];
                    [context MR_setWorkingName:@"TDCAPIGetNodes"];
                    
                    // update / create all the entities requested
                    for (NSObject *node in nodes) {
                        NSDictionary *nodeInfo = nodeDictionaries[node];
                        NSString *entityName = [self TDCEntityNameForNode:node];
                        NSString *objectIdentifier = [self TDCEntityKeyForTDCKey:@"id" forEntityNamed:entityName];
                        [self commitObjectsWithAttributeInfo:nodeInfo forEntityNamed:entityName withIdentifier:objectIdentifier inContext:context];
                    }
                    
                    // once all these related entities have been created and commited to the CoreData context, the relationships can be linnked
                    for (NSObject *node in nodes) {
                        NSDictionary *nodeInfo = nodeDictionaries[node];
                        NSString *entityName = [self TDCEntityNameForNode:node];
                        NSString *objectIdentifier = [self TDCEntityKeyForTDCKey:@"id" forEntityNamed:entityName];
                        [self linkObjectsWithRelationshipInfo:nodeInfo forEntityNamed:entityName withIdentifier:objectIdentifier inContext:context];
                    }
                    
                    // once everything has been created / updated and linked merge this creation context to the main UI context and write to disk by saving. MR has a
                    // Note: This completion is always called back on the main thread.
                    [context MR_saveToPersistentStoreWithCompletion:^(BOOL savedSuccess, NSError *commitError) {
                        if (savedSuccess) {
                            // clear the current thread's context to prevent any downloaded data from remaining in this context if this thread is reused for another download completion
                            if (completion != nil) {
                                completion(YES, nil);
                            }
                            
                        } else {
                            
                            [self logErrorFromSelector:_cmd withFormat:@"Could not save download context."];
                            
                            NSString *failureReason = @"";
                            
                            if (commitError != nil) {
                                failureReason = [NSString stringWithFormat:@"Core Data Error: %@", commitError];
                            }
                            
                            NSError *coreDataError = [NSError errorWithDomain:TDAPIErrorDomain
                                                                         code:kTDAPIErrorCommitDownloadContext
                                                                     userInfo:@{NSLocalizedDescriptionKey: @"Unable to save the downloaded data.",
                                                                                NSLocalizedFailureReasonErrorKey:failureReason}];
                            
                            [errors addObject:coreDataError];
                            if (completion != nil) {
                                completion(NO, errors);
                            }
                        }
                    }];
                    
                    
                } else {
                    if (completion != nil) {
                        completion(NO, errors);
                    }
                }
                
                // once all download requests have been processed, remove the reference to these nodes to allow them to be re-downloaded
                for (NSObject *node in nodes) {
                    [nodesDownloading removeObject:node];
                }
            }
        };
        
        // get each node type, configure once the request completes, successfully or not.
        for (id node in nodes) {
            [self TDCGetCoreNode:node withSuccess:^(NSURLSessionDataTask *task, NSDictionary *objectsInfo) {
                nodeDictionaries[node] = objectsInfo;
                NSLog(@"Got node: %@", node);
                configureNodes();
            } andFailure:^(NSURLSessionDataTask *task, NSError *error) {
                nodeDictionaries[node] = [NSNull null];
                [self logErrorFromSelector:_cmd withFormat:@"Could not get node %@: %@", node, error];
                [errors addObject:error];
                configureNodes();
            }];
        }
    }
}

/*!
 * @discussion Helper Method to automate the process of downloading a node from The Core. It is assumed that the sessionManager ivar is set up as default, it performs a GET request with parameters based on the node property. 
 * @param node Can be an NSString (used in the GET request with ?name=<name>) or an NSNumber (used with ?nodeType=<number>) to specify which Core node object to download.
 * @param success Block called if the GET request is successful. objectsInfo is an NSDictionary where keys are the node object's "id" property and the values are the json dictioanries for the nodes for easy access of specific objects if required. 
 * @param failure The failure block is called with the TDAPIErrorDomain if node is not an NSString or an NSNumber, or if the object returned from the GET request is not an NSDictionary. If the GET request fails, the AFNetworking error is returned in the failure block.
 */
/// nodeType should be a string representing a Node name or a number representing the nodeType
-(void)TDCGetCoreNode:(NSObject *) node withSuccess:(void (^)(NSURLSessionDataTask *task, NSDictionary *objectsInfo)) success andFailure:(void (^)(NSURLSessionDataTask *task, NSError *error)) failure
{
    NSDictionary *params = nil;
    
    if ([node isKindOfClass:[NSNumber class]]) {
        params = @{@"nodeType":node};
    } else if ([node isKindOfClass:[NSString class]]) {
        params = @{@"name": node};
    } else {
        
        NSError *error = [NSError errorWithDomain:TDAPIErrorDomain
                                             code:kTDCAPIErrorUnexpectedRequest
                                         userInfo:@{NSLocalizedDescriptionKey: @"Internal App Error Occured.",
                                                    NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Cannot get node with non-number/non-string node type: %@", node]}];
        failure(nil, error);
        return;
    }
    
    [sessionManager GET:@"api/node" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // response should be a dictionary with a single key value pair where the key is a plural form of the node type and the value is an array of those node types
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *responseDict = (NSDictionary *) responseObject;
            NSArray *cmsObjects = [responseDict.allValues firstObject];
            //[self logErrorFromSelector:_cmd withFormat:@"Got %@: %@", [responseDict.allKeys firstObject], cmsObjects];
            
            NSDictionary *objectsByID = [NSDictionary dictionaryWithObjects:cmsObjects forKeys:[cmsObjects valueForKeyPath:@"id"]];
            
            success(task, objectsByID);
            
        } else {
            
            //[self logErrorFromSelector:_cmd withFormat:@"Unexpected response type from requests: \nOriginal: %@\nCurrent: %@", task.originalRequest, task.currentRequest];
            
            NSString *failureReason = [NSString stringWithFormat:@"Unexpected response type from request: %@", task.currentRequest];
            NSError *error = [NSError errorWithDomain:TDAPIErrorDomain
                                                 code:kTDCAPIErrorUnexpectedResponse
                                             userInfo:@{NSLocalizedDescriptionKey: @"Internal service error occured.",
                                                        NSLocalizedFailureReasonErrorKey: failureReason}];
            
            failure(task, error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //[self logErrorFromSelector:_cmd withFormat:@"Unable to get node type %lu: %@", nodeType, error];
        
        failure(task, error);
    }];
}

#pragma mark Helper Methods

-(NSString *)TDCLocalizationsKeyForTDCoreIdentifier:(NSObject *) identifier forEntityNamed:(NSString *) entityName
{
    if ([identifier isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"TDC.cms.%@.%lu", entityName, ((NSNumber *) identifier).integerValue];
    } else if ([identifier isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"TDC.cms.%@.%@", entityName, (NSString *) identifier];
    } else {
        [self logErrorFromSelector:_cmd withFormat:@"Cannot convert TDCore identifier %@ to localization key", identifier];
    }
    
    return nil;
}

/*!
 * @discussion Helper method to allow automated methods to translate between TheCore node names or nodeTypes and CoreData class names. Subclasses should override this to provide translations, e.g. through a static NSDictionary object.
 * @param node Can be an NSNumber or an NSString represent either a Core node's nodeType or node name property.
 * @return NSString The CoreData entity name corresponding to the node parameter.
 */
-(NSString *)TDCEntityNameForNode:(NSObject *) node
{
    static NSDictionary *nodeInfo = nil;
    
    if (nodeInfo == nil) {
        nodeInfo = @{@"trust": @"PRTrust",
                     @"hospital":@"PRHospital",
                     @"ward":@"PRWard",
                     @"question":@"PRPMOSQuestion",
                     @"answer-type":@"PRPMOSAnswerType",
                     @"option": @"PRAnswerOption"};
    }
    
    return nodeInfo[node] != nil ? nodeInfo[node] : node;
}


/*!
 * @discussion A helper method to convert from The Core node's property names to the app's data model's property names. The default implementation returns the tdcKey parameter. Subclasses should override this method to return any custom names e.g. id -> productID
 * @param tdcKey A property key as in the json dictionary returned from The Core
 * @param entityName The name of the CoreData entity. This is passed in to allow conditional changing of keys, e.g. id -> productID and id -> categoryID
 * @return NSString * The default implementation returns tdcKey. Subclasses should return CoreData specific keys as appropriate.
 */
-(NSString *)TDCEntityKeyForTDCKey:(NSString *) tdcKey forEntityNamed:(NSString *) entityName
{
    if ([entityName isEqualToString:@"PRQuestion"]) {
        if ([tdcKey isEqualToString:@"id"]) {
            return @"questionID";
        }
    }
    
    if ([entityName isEqualToString:@"PRAnswerOption"]) {
        if ([tdcKey isEqualToString:@"id"]) {
            return @"answerID";
        }
    }
    
    return tdcKey;
}

/*!
 * @discussion A helper method to convert from the app's data model's property names to The Core node's property names. This should be the opposite of TDCEntityKeyForTDCKey:forEntityNamed:. The default implementation returns the entityKeyPath parameter. Subclasses should override this method to return any custom names e.g. productID -> id
 * @param entityKeyPath A property key as in the json dictionary returned from The Core
 * @param entityName The name of the CoreData entity. This is passed in to allow conditional changing of keys, e.g. productID -> id and categoryID -> id
 * @return NSString * The default implementation returns tdcKey. Subclasses should return CoreData specific keys as appropriate.
 */
-(NSString *)TDCKeyForEntityKeyPath:(NSString *) entityKeyPath forEntityNamed:(NSString *) entityName
{
    
    if ([entityName isEqualToString:@"PRQuestion"]) {
        if ([entityKeyPath isEqualToString:@"questionID"]) {
            return @"id";
        }
    }
    
    if ([entityName isEqualToString:@"PRAnswerOption"]) {
        if ([entityKeyPath isEqualToString:@"answerID"]) {
            return @"id";
        }
    }
    
    return entityKeyPath;
}



@end
