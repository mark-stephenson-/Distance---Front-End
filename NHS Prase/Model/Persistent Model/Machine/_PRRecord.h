// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.h instead.

#import <CoreData/CoreData.h>


extern const struct PRRecordAttributes {
	__unsafe_unretained NSString *basicData;
	__unsafe_unretained NSString *language;
	__unsafe_unretained NSString *startDate;
	__unsafe_unretained NSString *timeAdditionalPatient;
	__unsafe_unretained NSString *timeAdditionalQuestionnaire;
	__unsafe_unretained NSString *timeTracked;
} PRRecordAttributes;

extern const struct PRRecordRelationships {
	__unsafe_unretained NSString *concerns;
	__unsafe_unretained NSString *goodNotes;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *questions;
	__unsafe_unretained NSString *ward;
} PRRecordRelationships;

extern const struct PRRecordFetchedProperties {
} PRRecordFetchedProperties;

@class PRConcern;
@class PRNote;
@class PRNote;
@class PRQuestion;
@class PRWard;

@class NSObject;






@interface PRRecordID : NSManagedObjectID {}
@end

@interface _PRRecord : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRRecordID*)objectID;





@property (nonatomic, strong) id basicData;



//- (BOOL)validateBasicData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* language;



//- (BOOL)validateLanguage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* startDate;



//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* timeAdditionalPatient;



@property int64_t timeAdditionalPatientValue;
- (int64_t)timeAdditionalPatientValue;
- (void)setTimeAdditionalPatientValue:(int64_t)value_;

//- (BOOL)validateTimeAdditionalPatient:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* timeAdditionalQuestionnaire;



@property int64_t timeAdditionalQuestionnaireValue;
- (int64_t)timeAdditionalQuestionnaireValue;
- (void)setTimeAdditionalQuestionnaireValue:(int64_t)value_;

//- (BOOL)validateTimeAdditionalQuestionnaire:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* timeTracked;



@property int64_t timeTrackedValue;
- (int64_t)timeTrackedValue;
- (void)setTimeTrackedValue:(int64_t)value_;

//- (BOOL)validateTimeTracked:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *concerns;

- (NSMutableSet*)concernsSet;




@property (nonatomic, strong) NSSet *goodNotes;

- (NSMutableSet*)goodNotesSet;




@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;




@property (nonatomic, strong) NSOrderedSet *questions;

- (NSMutableOrderedSet*)questionsSet;




@property (nonatomic, strong) PRWard *ward;

//- (BOOL)validateWard:(id*)value_ error:(NSError**)error_;





@end

@interface _PRRecord (CoreDataGeneratedAccessors)

- (void)addConcerns:(NSSet*)value_;
- (void)removeConcerns:(NSSet*)value_;
- (void)addConcernsObject:(PRConcern*)value_;
- (void)removeConcernsObject:(PRConcern*)value_;

- (void)addGoodNotes:(NSSet*)value_;
- (void)removeGoodNotes:(NSSet*)value_;
- (void)addGoodNotesObject:(PRNote*)value_;
- (void)removeGoodNotesObject:(PRNote*)value_;

- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(PRNote*)value_;
- (void)removeNotesObject:(PRNote*)value_;

- (void)addQuestions:(NSOrderedSet*)value_;
- (void)removeQuestions:(NSOrderedSet*)value_;
- (void)addQuestionsObject:(PRQuestion*)value_;
- (void)removeQuestionsObject:(PRQuestion*)value_;

@end

@interface _PRRecord (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveBasicData;
- (void)setPrimitiveBasicData:(id)value;




- (NSString*)primitiveLanguage;
- (void)setPrimitiveLanguage:(NSString*)value;




- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;




- (NSNumber*)primitiveTimeAdditionalPatient;
- (void)setPrimitiveTimeAdditionalPatient:(NSNumber*)value;

- (int64_t)primitiveTimeAdditionalPatientValue;
- (void)setPrimitiveTimeAdditionalPatientValue:(int64_t)value_;




- (NSNumber*)primitiveTimeAdditionalQuestionnaire;
- (void)setPrimitiveTimeAdditionalQuestionnaire:(NSNumber*)value;

- (int64_t)primitiveTimeAdditionalQuestionnaireValue;
- (void)setPrimitiveTimeAdditionalQuestionnaireValue:(int64_t)value_;




- (NSNumber*)primitiveTimeTracked;
- (void)setPrimitiveTimeTracked:(NSNumber*)value;

- (int64_t)primitiveTimeTrackedValue;
- (void)setPrimitiveTimeTrackedValue:(int64_t)value_;





- (NSMutableSet*)primitiveConcerns;
- (void)setPrimitiveConcerns:(NSMutableSet*)value;



- (NSMutableSet*)primitiveGoodNotes;
- (void)setPrimitiveGoodNotes:(NSMutableSet*)value;



- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;



- (NSMutableOrderedSet*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableOrderedSet*)value;



- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;


@end
