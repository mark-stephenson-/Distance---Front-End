// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOSQuestion.h instead.

#import <CoreData/CoreData.h>

extern const struct PRPMOSQuestionAttributes {
	__unsafe_unretained NSString *localizationID;
	__unsafe_unretained NSString *questionID;
} PRPMOSQuestionAttributes;

extern const struct PRPMOSQuestionRelationships {
	__unsafe_unretained NSString *answerSets;
	__unsafe_unretained NSString *pmos;
	__unsafe_unretained NSString *questions;
} PRPMOSQuestionRelationships;

@class PRAnswerSet;
@class PRPMOS;
@class PRQuestion;

@interface PRPMOSQuestionID : NSManagedObjectID {}
@end

@interface _PRPMOSQuestion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRPMOSQuestionID* objectID;

@property (nonatomic, strong) NSNumber* localizationID;

@property (atomic) int64_t localizationIDValue;
- (int64_t)localizationIDValue;
- (void)setLocalizationIDValue:(int64_t)value_;

//- (BOOL)validateLocalizationID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* questionID;

@property (atomic) int64_t questionIDValue;
- (int64_t)questionIDValue;
- (void)setQuestionIDValue:(int64_t)value_;

//- (BOOL)validateQuestionID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *answerSets;

- (NSMutableOrderedSet*)answerSetsSet;

@property (nonatomic, strong) PRPMOS *pmos;

//- (BOOL)validatePmos:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *questions;

- (NSMutableSet*)questionsSet;

@end

@interface _PRPMOSQuestion (AnswerSetsCoreDataGeneratedAccessors)
- (void)addAnswerSets:(NSOrderedSet*)value_;
- (void)removeAnswerSets:(NSOrderedSet*)value_;
- (void)addAnswerSetsObject:(PRAnswerSet*)value_;
- (void)removeAnswerSetsObject:(PRAnswerSet*)value_;

- (void)insertObject:(PRAnswerSet*)value inAnswerSetsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAnswerSetsAtIndex:(NSUInteger)idx;
- (void)insertAnswerSets:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAnswerSetsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAnswerSetsAtIndex:(NSUInteger)idx withObject:(PRAnswerSet*)value;
- (void)replaceAnswerSetsAtIndexes:(NSIndexSet *)indexes withAnswerSets:(NSArray *)values;

@end

@interface _PRPMOSQuestion (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSSet*)value_;
- (void)removeQuestions:(NSSet*)value_;
- (void)addQuestionsObject:(PRQuestion*)value_;
- (void)removeQuestionsObject:(PRQuestion*)value_;

@end

@interface _PRPMOSQuestion (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLocalizationID;
- (void)setPrimitiveLocalizationID:(NSNumber*)value;

- (int64_t)primitiveLocalizationIDValue;
- (void)setPrimitiveLocalizationIDValue:(int64_t)value_;

- (NSNumber*)primitiveQuestionID;
- (void)setPrimitiveQuestionID:(NSNumber*)value;

- (int64_t)primitiveQuestionIDValue;
- (void)setPrimitiveQuestionIDValue:(int64_t)value_;

- (NSMutableOrderedSet*)primitiveAnswerSets;
- (void)setPrimitiveAnswerSets:(NSMutableOrderedSet*)value;

- (PRPMOS*)primitivePmos;
- (void)setPrimitivePmos:(PRPMOS*)value;

- (NSMutableSet*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableSet*)value;

@end
