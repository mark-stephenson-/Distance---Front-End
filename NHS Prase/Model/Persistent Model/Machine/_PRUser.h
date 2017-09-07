// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRUser.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PRUserID : NSManagedObjectID {}
@end

@interface _PRUser : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRUserID *objectID;

@property (nonatomic, strong, nullable) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

@property (nonatomic, strong) NSString* password;

@property (nonatomic, strong, nullable) NSNumber* trustID;

@property (atomic) int64_t trustIDValue;
- (int64_t)trustIDValue;
- (void)setTrustIDValue:(int64_t)value_;

@property (nonatomic, strong) NSString* username;

@end

@interface _PRUser (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSString*)primitivePassword;
- (void)setPrimitivePassword:(NSString*)value;

- (NSNumber*)primitiveTrustID;
- (void)setPrimitiveTrustID:(NSNumber*)value;

- (int64_t)primitiveTrustIDValue;
- (void)setPrimitiveTrustIDValue:(int64_t)value_;

- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;

@end

@interface PRUserAttributes: NSObject 
+ (NSString *)id;
+ (NSString *)password;
+ (NSString *)trustID;
+ (NSString *)username;
@end

NS_ASSUME_NONNULL_END
