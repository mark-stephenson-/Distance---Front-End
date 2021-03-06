// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOS.h instead.

#import <CoreData/CoreData.h>

extern const struct PRPMOSAttributes {
	__unsafe_unretained NSString *id;
} PRPMOSAttributes;

extern const struct PRPMOSRelationships {
	__unsafe_unretained NSString *questions;
} PRPMOSRelationships;

@class PRPMOSQuestion;

@interface PRPMOSID : NSManagedObjectID {}
@end

@interface _PRPMOS : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRPMOSID* objectID;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *questions;

- (NSMutableOrderedSet*)questionsSet;

@end

@interface _PRPMOS (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSOrderedSet*)value_;
- (void)removeQuestions:(NSOrderedSet*)value_;
- (void)addQuestionsObject:(PRPMOSQuestion*)value_;
- (void)removeQuestionsObject:(PRPMOSQuestion*)value_;

- (void)insertObject:(PRPMOSQuestion*)value inQuestionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromQuestionsAtIndex:(NSUInteger)idx;
- (void)insertQuestions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeQuestionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInQuestionsAtIndex:(NSUInteger)idx withObject:(PRPMOSQuestion*)value;
- (void)replaceQuestionsAtIndexes:(NSIndexSet *)indexes withQuestions:(NSArray *)values;

@end

@interface _PRPMOS (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSMutableOrderedSet*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableOrderedSet*)value;

@end
