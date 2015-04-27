// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRTrust.h instead.

#import <CoreData/CoreData.h>


extern const struct PRTrustAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
} PRTrustAttributes;

extern const struct PRTrustRelationships {
	__unsafe_unretained NSString *hospitals;
} PRTrustRelationships;

extern const struct PRTrustFetchedProperties {
} PRTrustFetchedProperties;

@class PRHospital;




@interface PRTrustID : NSManagedObjectID {}
@end

@interface _PRTrust : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRTrustID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *hospitals;

- (NSMutableSet*)hospitalsSet;





@end

@interface _PRTrust (CoreDataGeneratedAccessors)

- (void)addHospitals:(NSSet*)value_;
- (void)removeHospitals:(NSSet*)value_;
- (void)addHospitalsObject:(PRHospital*)value_;
- (void)removeHospitalsObject:(PRHospital*)value_;

@end

@interface _PRTrust (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveHospitals;
- (void)setPrimitiveHospitals:(NSMutableSet*)value;


@end
