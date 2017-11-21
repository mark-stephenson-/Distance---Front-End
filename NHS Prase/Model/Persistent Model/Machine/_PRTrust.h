// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRTrust.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRHospital;

@interface PRTrustID : NSManagedObjectID {}
@end

@interface _PRTrust : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRTrustID *objectID;

@property (nonatomic, strong, nullable) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSSet<PRHospital*> *hospitals;
- (nullable NSMutableSet<PRHospital*>*)hospitalsSet;

@end

@interface _PRTrust (HospitalsCoreDataGeneratedAccessors)
- (void)addHospitals:(NSSet<PRHospital*>*)value_;
- (void)removeHospitals:(NSSet<PRHospital*>*)value_;
- (void)addHospitalsObject:(PRHospital*)value_;
- (void)removeHospitalsObject:(PRHospital*)value_;

@end

@interface _PRTrust (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveId;
- (void)setPrimitiveId:(nullable NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (NSMutableSet<PRHospital*>*)primitiveHospitals;
- (void)setPrimitiveHospitals:(NSMutableSet<PRHospital*>*)value;

@end

@interface PRTrustAttributes: NSObject 
+ (NSString *)id;
+ (NSString *)name;
@end

@interface PRTrustRelationships: NSObject
+ (NSString *)hospitals;
@end

NS_ASSUME_NONNULL_END
