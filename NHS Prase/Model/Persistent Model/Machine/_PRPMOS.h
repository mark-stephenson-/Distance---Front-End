// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOS.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRPMOSQuestion;

@interface PRPMOSID : NSManagedObjectID {}
@end

@interface _PRPMOS : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRPMOSID *objectID;

@property (nonatomic, strong, nullable) NSOrderedSet<PRPMOSQuestion*> *questions;
- (nullable NSMutableOrderedSet<PRPMOSQuestion*>*)questionsSet;

@end

@interface _PRPMOS (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSOrderedSet<PRPMOSQuestion*>*)value_;
- (void)removeQuestions:(NSOrderedSet<PRPMOSQuestion*>*)value_;
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

- (NSMutableOrderedSet<PRPMOSQuestion*>*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableOrderedSet<PRPMOSQuestion*>*)value;

@end

@interface PRPMOSRelationships: NSObject
+ (NSString *)questions;
@end

NS_ASSUME_NONNULL_END
