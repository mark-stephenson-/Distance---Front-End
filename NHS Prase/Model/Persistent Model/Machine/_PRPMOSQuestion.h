// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOSQuestion.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRAnswerSet;
@class PRPMOS;
@class PRQuestion;

@interface PRPMOSQuestionID : NSManagedObjectID {}
@end

@interface _PRPMOSQuestion : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRPMOSQuestionID *objectID;

@property (nonatomic, strong, nullable) NSNumber* localizationID;

@property (atomic) int64_t localizationIDValue;
- (int64_t)localizationIDValue;
- (void)setLocalizationIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* questionID;

@property (atomic) int64_t questionIDValue;
- (int64_t)questionIDValue;
- (void)setQuestionIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSOrderedSet<PRAnswerSet*> *answerSets;
- (nullable NSMutableOrderedSet<PRAnswerSet*>*)answerSetsSet;

@property (nonatomic, strong, nullable) PRPMOS *pmos;

@property (nonatomic, strong, nullable) NSSet<PRQuestion*> *questions;
- (nullable NSMutableSet<PRQuestion*>*)questionsSet;

@end

@interface _PRPMOSQuestion (AnswerSetsCoreDataGeneratedAccessors)
- (void)addAnswerSets:(NSOrderedSet<PRAnswerSet*>*)value_;
- (void)removeAnswerSets:(NSOrderedSet<PRAnswerSet*>*)value_;
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
- (void)addQuestions:(NSSet<PRQuestion*>*)value_;
- (void)removeQuestions:(NSSet<PRQuestion*>*)value_;
- (void)addQuestionsObject:(PRQuestion*)value_;
- (void)removeQuestionsObject:(PRQuestion*)value_;

@end

@interface _PRPMOSQuestion (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveLocalizationID;
- (void)setPrimitiveLocalizationID:(nullable NSNumber*)value;

- (int64_t)primitiveLocalizationIDValue;
- (void)setPrimitiveLocalizationIDValue:(int64_t)value_;

- (nullable NSNumber*)primitiveQuestionID;
- (void)setPrimitiveQuestionID:(nullable NSNumber*)value;

- (int64_t)primitiveQuestionIDValue;
- (void)setPrimitiveQuestionIDValue:(int64_t)value_;

- (NSMutableOrderedSet<PRAnswerSet*>*)primitiveAnswerSets;
- (void)setPrimitiveAnswerSets:(NSMutableOrderedSet<PRAnswerSet*>*)value;

- (PRPMOS*)primitivePmos;
- (void)setPrimitivePmos:(PRPMOS*)value;

- (NSMutableSet<PRQuestion*>*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableSet<PRQuestion*>*)value;

@end

@interface PRPMOSQuestionAttributes: NSObject 
+ (NSString *)localizationID;
+ (NSString *)questionID;
@end

@interface PRPMOSQuestionRelationships: NSObject
+ (NSString *)answerSets;
+ (NSString *)pmos;
+ (NSString *)questions;
@end

NS_ASSUME_NONNULL_END
