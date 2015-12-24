// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRUser.h instead.

#import <CoreData/CoreData.h>

extern const struct PRUserAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *password;
	__unsafe_unretained NSString *trustID;
	__unsafe_unretained NSString *username;
} PRUserAttributes;

@interface PRUserID : NSManagedObjectID {}
@end

@interface _PRUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRUserID* objectID;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* password;

//- (BOOL)validatePassword:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* trustID;

@property (atomic) int64_t trustIDValue;
- (int64_t)trustIDValue;
- (void)setTrustIDValue:(int64_t)value_;

//- (BOOL)validateTrustID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;

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
