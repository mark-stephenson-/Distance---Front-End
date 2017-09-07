// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.h instead.

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
@class PRNote;
@class PRQuestion;
@class PRWard;

@class NSObject;

@interface PRRecordID : NSManagedObjectID {}
@end

@interface _PRRecord : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRRecordID *objectID;

@property (nonatomic, strong, nullable) id basicData;

@property (nonatomic, strong, nullable) NSString* incompleteReason;

@property (nonatomic, strong, nullable) NSString* language;

@property (nonatomic, strong, nullable) NSNumber* pmosID;

@property (atomic) int64_t pmosIDValue;
- (int64_t)pmosIDValue;
- (void)setPmosIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSDate* startDate;

@property (nonatomic, strong, nullable) NSNumber* timeAdditionalPatient;

@property (atomic) int64_t timeAdditionalPatientValue;
- (int64_t)timeAdditionalPatientValue;
- (void)setTimeAdditionalPatientValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* timeAdditionalQuestionnaire;

@property (atomic) int64_t timeAdditionalQuestionnaireValue;
- (int64_t)timeAdditionalQuestionnaireValue;
- (void)setTimeAdditionalQuestionnaireValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* timeTracked;

@property (atomic) int64_t timeTrackedValue;
- (int64_t)timeTrackedValue;
- (void)setTimeTrackedValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* user;

@property (nonatomic, strong, nullable) NSSet<PRConcern*> *concerns;
- (nullable NSMutableSet<PRConcern*>*)concernsSet;

@property (nonatomic, strong, nullable) NSSet<PRNote*> *goodNotes;
- (nullable NSMutableSet<PRNote*>*)goodNotesSet;

@property (nonatomic, strong, nullable) NSSet<PRNote*> *notes;
- (nullable NSMutableSet<PRNote*>*)notesSet;

@property (nonatomic, strong, nullable) NSOrderedSet<PRQuestion*> *questions;
- (nullable NSMutableOrderedSet<PRQuestion*>*)questionsSet;

@property (nonatomic, strong, nullable) PRWard *ward;

@end

@interface _PRRecord (ConcernsCoreDataGeneratedAccessors)
- (void)addConcerns:(NSSet<PRConcern*>*)value_;
- (void)removeConcerns:(NSSet<PRConcern*>*)value_;
- (void)addConcernsObject:(PRConcern*)value_;
- (void)removeConcernsObject:(PRConcern*)value_;

@end

@interface _PRRecord (GoodNotesCoreDataGeneratedAccessors)
- (void)addGoodNotes:(NSSet<PRNote*>*)value_;
- (void)removeGoodNotes:(NSSet<PRNote*>*)value_;
- (void)addGoodNotesObject:(PRNote*)value_;
- (void)removeGoodNotesObject:(PRNote*)value_;

@end

@interface _PRRecord (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet<PRNote*>*)value_;
- (void)removeNotes:(NSSet<PRNote*>*)value_;
- (void)addNotesObject:(PRNote*)value_;
- (void)removeNotesObject:(PRNote*)value_;

@end

@interface _PRRecord (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSOrderedSet<PRQuestion*>*)value_;
- (void)removeQuestions:(NSOrderedSet<PRQuestion*>*)value_;
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

- (NSMutableSet<PRConcern*>*)primitiveConcerns;
- (void)setPrimitiveConcerns:(NSMutableSet<PRConcern*>*)value;

- (NSMutableSet<PRNote*>*)primitiveGoodNotes;
- (void)setPrimitiveGoodNotes:(NSMutableSet<PRNote*>*)value;

- (NSMutableSet<PRNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<PRNote*>*)value;

- (NSMutableOrderedSet<PRQuestion*>*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableOrderedSet<PRQuestion*>*)value;

- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;

@end

@interface PRRecordAttributes: NSObject 
+ (NSString *)basicData;
+ (NSString *)incompleteReason;
+ (NSString *)language;
+ (NSString *)pmosID;
+ (NSString *)startDate;
+ (NSString *)timeAdditionalPatient;
+ (NSString *)timeAdditionalQuestionnaire;
+ (NSString *)timeTracked;
+ (NSString *)user;
@end

@interface PRRecordRelationships: NSObject
+ (NSString *)concerns;
+ (NSString *)goodNotes;
+ (NSString *)notes;
+ (NSString *)questions;
+ (NSString *)ward;
@end

NS_ASSUME_NONNULL_END
