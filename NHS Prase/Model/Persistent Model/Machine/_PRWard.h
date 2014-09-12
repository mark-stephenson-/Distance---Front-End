// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRWard.h instead.

#import <CoreData/CoreData.h>


extern const struct PRWardAttributes {
	__unsafe_unretained NSString *hospital;
	__unsafe_unretained NSString *trust;
	__unsafe_unretained NSString *ward;
} PRWardAttributes;

extern const struct PRWardRelationships {
	__unsafe_unretained NSString *concerns;
	__unsafe_unretained NSString *goodNotes;
	__unsafe_unretained NSString *records;
} PRWardRelationships;

extern const struct PRWardFetchedProperties {
} PRWardFetchedProperties;

@class PRConcern;
@class PRNote;
@class PRRecord;





@interface PRWardID : NSManagedObjectID {}
@end

@interface _PRWard : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRWardID*)objectID;





@property (nonatomic, strong) NSString* hospital;



//- (BOOL)validateHospital:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* trust;



//- (BOOL)validateTrust:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* ward;



//- (BOOL)validateWard:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *concerns;

- (NSMutableSet*)concernsSet;




@property (nonatomic, strong) NSSet *goodNotes;

- (NSMutableSet*)goodNotesSet;




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


- (NSString*)primitiveHospital;
- (void)setPrimitiveHospital:(NSString*)value;




- (NSString*)primitiveTrust;
- (void)setPrimitiveTrust:(NSString*)value;




- (NSString*)primitiveWard;
- (void)setPrimitiveWard:(NSString*)value;





- (NSMutableSet*)primitiveConcerns;
- (void)setPrimitiveConcerns:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGoodNotes;
- (void)setPrimitiveGoodNotes:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRecords;
- (void)setPrimitiveRecords:(NSMutableSet*)value;


@end
