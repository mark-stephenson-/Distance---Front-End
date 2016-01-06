// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.h instead.

#import <CoreData/CoreData.h>

extern const struct PRRecordAttributes {
	__unsafe_unretained NSString *basicData;
	__unsafe_unretained NSString *incompleteReason;
	__unsafe_unretained NSString *language;
	__unsafe_unretained NSString *pmosID;
	__unsafe_unretained NSString *startDate;
	__unsafe_unretained NSString *timeAdditionalPatient;
	__unsafe_unretained NSString *timeAdditionalQuestionnaire;
	__unsafe_unretained NSString *timeTracked;
	__unsafe_unretained NSString *user;
} PRRecordAttributes;

extern const struct PRRecordRelationships {
	__unsafe_unretained NSString *concerns;
	__unsafe_unretained NSString *goodNotes;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *questions;
	__unsafe_unretained NSString *ward;
} PRRecordRelationships;

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
@property (nonatomic, readonly, strong) PRRecordID* objectID;

@property (nonatomic, strong) id basicData;

//- (BOOL)validateBasicData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* incompleteReason;

//- (BOOL)validateIncompleteReason:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* language;

//- (BOOL)validateLanguage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pmosID;

@property (atomic) int64_t pmosIDValue;
- (int64_t)pmosIDValue;
- (void)setPmosIDValue:(int64_t)value_;

//- (BOOL)validatePmosID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* startDate;

//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeAdditionalPatient;

@property (atomic) int64_t timeAdditionalPatientValue;
- (int64_t)timeAdditionalPatientValue;
- (void)setTimeAdditionalPatientValue:(int64_t)value_;

//- (BOOL)validateTimeAdditionalPatient:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeAdditionalQuestionnaire;

@property (atomic) int64_t timeAdditionalQuestionnaireValue;
- (int64_t)timeAdditionalQuestionnaireValue;
- (void)setTimeAdditionalQuestionnaireValue:(int64_t)value_;

//- (BOOL)validateTimeAdditionalQuestionnaire:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeTracked;

@property (atomic) int64_t timeTrackedValue;
- (int64_t)timeTrackedValue;
- (void)setTimeTrackedValue:(int64_t)value_;

//- (BOOL)validateTimeTracked:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

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

@interface _PRRecord (ConcernsCoreDataGeneratedAccessors)
- (void)addConcerns:(NSSet*)value_;
- (void)removeConcerns:(NSSet*)value_;
- (void)addConcernsObject:(PRConcern*)value_;
- (void)removeConcernsObject:(PRConcern*)value_;

@end

@interface _PRRecord (GoodNotesCoreDataGeneratedAccessors)
- (void)addGoodNotes:(NSSet*)value_;
- (void)removeGoodNotes:(NSSet*)value_;
- (void)addGoodNotesObject:(PRNote*)value_;
- (void)removeGoodNotesObject:(PRNote*)value_;

@end

@interface _PRRecord (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(PRNote*)value_;
- (void)removeNotesObject:(PRNote*)value_;

@end

@interface _PRRecord (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSOrderedSet*)value_;
- (void)removeQuestions:(NSOrderedSet*)value_;
- (void)addQuestionsObject:(PRQuestion*)value_;
- (void)removeQuestionsObject:(PRQuestion*)value_;

- (void)insertObject:(PRQuestion*)value inQuestionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromQuestionsAtIndex:(NSUInteger)idx;
- (void)insertQuestions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeQuestionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInQuestionsAtIndex:(NSUInteger)idx withObject:(PRQuestion*)value;
- (void)replaceQuestionsAtIndexes:(NSIndexSet *)indexes withQuestions:(NSArray *)values;

@end

@interface _PRRecord (CoreDataGeneratedPrimitiveAccessors)

- (id)primitiveBasicData;
- (void)setPrimitiveBasicData:(id)value;

- (NSString*)primitiveIncompleteReason;
- (void)setPrimitiveIncompleteReason:(NSString*)value;

- (NSString*)primitiveLanguage;
- (void)setPrimitiveLanguage:(NSString*)value;

- (NSNumber*)primitivePmosID;
- (void)setPrimitivePmosID:(NSNumber*)value;

- (int64_t)primitivePmosIDValue;
- (void)setPrimitivePmosIDValue:(int64_t)value_;

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

- (NSString*)primitiveUser;
- (void)setPrimitiveUser:(NSString*)value;

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
