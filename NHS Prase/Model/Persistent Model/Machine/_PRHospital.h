// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRHospital.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRTrust;
@class PRWard;

@interface PRHospitalID : NSManagedObjectID {}
@end

@interface _PRHospital : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRHospitalID *objectID;

@property (nonatomic, strong, nullable) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) PRTrust *trust;

@property (nonatomic, strong, nullable) NSSet<PRWard*> *wards;
- (nullable NSMutableSet<PRWard*>*)wardsSet;

@end

@interface _PRHospital (WardsCoreDataGeneratedAccessors)
- (void)addWards:(NSSet<PRWard*>*)value_;
- (void)removeWards:(NSSet<PRWard*>*)value_;
- (void)addWardsObject:(PRWard*)value_;
- (void)removeWardsObject:(PRWard*)value_;

@end

@interface _PRHospital (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveId;
- (void)setPrimitiveId:(nullable NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (PRTrust*)primitiveTrust;
- (void)setPrimitiveTrust:(PRTrust*)value;

- (NSMutableSet<PRWard*>*)primitiveWards;
- (void)setPrimitiveWards:(NSMutableSet<PRWard*>*)value;

@end

@interface PRHospitalAttributes: NSObject 
+ (NSString *)id;
+ (NSString *)name;
@end

@interface PRHospitalRelationships: NSObject
+ (NSString *)trust;
+ (NSString *)wards;
@end

NS_ASSUME_NONNULL_END
