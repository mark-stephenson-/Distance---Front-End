// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRConcern.h instead.

#import <CoreData/CoreData.h>

extern const struct PRConcernRelationships {
	__unsafe_unretained NSString *preventNote;
	__unsafe_unretained NSString *preventQuestion;
	__unsafe_unretained NSString *question;
	__unsafe_unretained NSString *record;
	__unsafe_unretained NSString *seriousQuestion;
	__unsafe_unretained NSString *ward;
	__unsafe_unretained NSString *whatNote;
	__unsafe_unretained NSString *whyNote;
} PRConcernRelationships;

@class PRNote;
@class PRQuestion;
@class PRQuestion;
@class PRRecord;
@class PRQuestion;
@class PRWard;
@class PRNote;
@class PRNote;

@interface PRConcernID : NSManagedObjectID {}
@end

@interface _PRConcern : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRConcernID* objectID;

@property (nonatomic, strong) PRNote *preventNote;

//- (BOOL)validatePreventNote:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRQuestion *preventQuestion;

//- (BOOL)validatePreventQuestion:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRQuestion *question;

//- (BOOL)validateQuestion:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRRecord *record;

//- (BOOL)validateRecord:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRQuestion *seriousQuestion;

//- (BOOL)validateSeriousQuestion:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRWard *ward;

//- (BOOL)validateWard:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRNote *whatNote;

//- (BOOL)validateWhatNote:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRNote *whyNote;

//- (BOOL)validateWhyNote:(id*)value_ error:(NSError**)error_;

@end

@interface _PRConcern (CoreDataGeneratedPrimitiveAccessors)

- (PRNote*)primitivePreventNote;
- (void)setPrimitivePreventNote:(PRNote*)value;

- (PRQuestion*)primitivePreventQuestion;
- (void)setPrimitivePreventQuestion:(PRQuestion*)value;

- (PRQuestion*)primitiveQuestion;
- (void)setPrimitiveQuestion:(PRQuestion*)value;

- (PRRecord*)primitiveRecord;
- (void)setPrimitiveRecord:(PRRecord*)value;

- (PRQuestion*)primitiveSeriousQuestion;
- (void)setPrimitiveSeriousQuestion:(PRQuestion*)value;

- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;

- (PRNote*)primitiveWhatNote;
- (void)setPrimitiveWhatNote:(PRNote*)value;

- (PRNote*)primitiveWhyNote;
- (void)setPrimitiveWhyNote:(PRNote*)value;

@end
