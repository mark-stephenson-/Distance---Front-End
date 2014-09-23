// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRWard.h instead.

#import <CoreData/CoreData.h>


extern const struct PRWardAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
} PRWardAttributes;

extern const struct PRWardRelationships {
	__unsafe_unretained NSString *concerns;
	__unsafe_unretained NSString *goodNotes;
	__unsafe_unretained NSString *hospital;
	__unsafe_unretained NSString *records;
} PRWardRelationships;

extern const struct PRWardFetchedProperties {
} PRWardFetchedProperties;

@class PRConcern;
@class PRNote;
@class PRHospital;
@class PRRecord;




@interface PRWardID : NSManagedObjectID {}
@end

@interface _PRWard : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRWardID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int16_t idValue;
- (int16_t)idValue;
- (void)setIdValue:(int16_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *concerns;

- (NSMutableSet*)concernsSet;




@property (nonatomic, strong) NSSet *goodNotes;

- (NSMutableSet*)goodNotesSet;




@property (nonatomic, strong) PRHospital *hospital;

//- (BOOL)validateHospital:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *records;

- (NSMutableSet*)recordsSet;





@end

@interface _PRWard (CoreDataGeneratedAccessors)

- (void)addConcerns:(NSSet*)value_;
- (void)removeConcerns:(NSSet*)value_;
- (void)addConcernsObject:(PRConcern*)value_;
- (void)removeConcernsObject:(PRConcern*)value_;

- (void)addGoodNotes:(NSSet*)value_;
- (void)removeGoodNotes:(NSSet*)value_;
- (void)addGoodNotesObject:(PRNote*)value_;
- (void)removeGoodNotesObject:(PRNote*)value_;

- (void)addRecords:(NSSet*)value_;
- (void)removeRecords:(NSSet*)value_;
- (void)addRecordsObject:(PRRecord*)value_;
- (void)removeRecordsObject:(PRRecord*)value_;

@end

@interface _PRWard (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int16_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int16_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveConcerns;
- (void)setPrimitiveConcerns:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGoodNotes;
- (void)setPrimitiveGoodNotes:(NSMutableSet*)value;



- (PRHospital*)primitiveHospital;
- (void)setPrimitiveHospital:(PRHospital*)value;



- (NSMutableSet*)primitiveRecords;
- (void)setPrimitiveRecords:(NSMutableSet*)value;


@end
