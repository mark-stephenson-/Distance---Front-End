// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRWard.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRConcern;
@class PRNote;
@class PRHospital;
@class PRRecord;

@interface PRWardID : NSManagedObjectID {}
@end

@interface _PRWard : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRWardID *objectID;

@property (nonatomic, strong, nullable) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSSet<PRConcern*> *concerns;
- (nullable NSMutableSet<PRConcern*>*)concernsSet;

@property (nonatomic, strong, nullable) NSSet<PRNote*> *goodNotes;
- (nullable NSMutableSet<PRNote*>*)goodNotesSet;

@property (nonatomic, strong, nullable) PRHospital *hospital;

@property (nonatomic, strong, nullable) NSSet<PRRecord*> *records;
- (nullable NSMutableSet<PRRecord*>*)recordsSet;

@end

@interface _PRWard (ConcernsCoreDataGeneratedAccessors)
- (void)addConcerns:(NSSet<PRConcern*>*)value_;
- (void)removeConcerns:(NSSet<PRConcern*>*)value_;
- (void)addConcernsObject:(PRConcern*)value_;
- (void)removeConcernsObject:(PRConcern*)value_;

@end

@interface _PRWard (GoodNotesCoreDataGeneratedAccessors)
- (void)addGoodNotes:(NSSet<PRNote*>*)value_;
- (void)removeGoodNotes:(NSSet<PRNote*>*)value_;
- (void)addGoodNotesObject:(PRNote*)value_;
- (void)removeGoodNotesObject:(PRNote*)value_;

@end

@interface _PRWard (RecordsCoreDataGeneratedAccessors)
- (void)addRecords:(NSSet<PRRecord*>*)value_;
- (void)removeRecords:(NSSet<PRRecord*>*)value_;
- (void)addRecordsObject:(PRRecord*)value_;
- (void)removeRecordsObject:(PRRecord*)value_;

@end

@interface _PRWard (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveId;
- (void)setPrimitiveId:(nullable NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (NSMutableSet<PRConcern*>*)primitiveConcerns;
- (void)setPrimitiveConcerns:(NSMutableSet<PRConcern*>*)value;

- (NSMutableSet<PRNote*>*)primitiveGoodNotes;
- (void)setPrimitiveGoodNotes:(NSMutableSet<PRNote*>*)value;

- (PRHospital*)primitiveHospital;
- (void)setPrimitiveHospital:(PRHospital*)value;

- (NSMutableSet<PRRecord*>*)primitiveRecords;
- (void)setPrimitiveRecords:(NSMutableSet<PRRecord*>*)value;

@end

@interface PRWardAttributes: NSObject 
+ (NSString *)id;
+ (NSString *)name;
@end

@interface PRWardRelationships: NSObject
+ (NSString *)concerns;
+ (NSString *)goodNotes;
+ (NSString *)hospital;
+ (NSString *)records;
@end

NS_ASSUME_NONNULL_END
