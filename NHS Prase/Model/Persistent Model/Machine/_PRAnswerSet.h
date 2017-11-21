// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerSet.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRAnswerOption;
@class PRPMOSQuestion;

@interface PRAnswerSetID : NSManagedObjectID {}
@end

@interface _PRAnswerSet : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRAnswerSetID *objectID;

@property (nonatomic, strong, nullable) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSOrderedSet<PRAnswerOption*> *options;
- (nullable NSMutableOrderedSet<PRAnswerOption*>*)optionsSet;

@property (nonatomic, strong, nullable) NSSet<PRPMOSQuestion*> *pmosQuestion;
- (nullable NSMutableSet<PRPMOSQuestion*>*)pmosQuestionSet;

@end

@interface _PRAnswerSet (OptionsCoreDataGeneratedAccessors)
- (void)addOptions:(NSOrderedSet<PRAnswerOption*>*)value_;
- (void)removeOptions:(NSOrderedSet<PRAnswerOption*>*)value_;
- (void)addOptionsObject:(PRAnswerOption*)value_;
- (void)removeOptionsObject:(PRAnswerOption*)value_;

- (void)insertObject:(PRAnswerOption*)value inOptionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromOptionsAtIndex:(NSUInteger)idx;
- (void)insertOptions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeOptionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInOptionsAtIndex:(NSUInteger)idx withObject:(PRAnswerOption*)value;
- (void)replaceOptionsAtIndexes:(NSIndexSet *)indexes withOptions:(NSArray *)values;

@end

@interface _PRAnswerSet (PmosQuestionCoreDataGeneratedAccessors)
- (void)addPmosQuestion:(NSSet<PRPMOSQuestion*>*)value_;
- (void)removePmosQuestion:(NSSet<PRPMOSQuestion*>*)value_;
- (void)addPmosQuestionObject:(PRPMOSQuestion*)value_;
- (void)removePmosQuestionObject:(PRPMOSQuestion*)value_;

@end

@interface _PRAnswerSet (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveId;
- (void)setPrimitiveId:(nullable NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSMutableOrderedSet<PRAnswerOption*>*)primitiveOptions;
- (void)setPrimitiveOptions:(NSMutableOrderedSet<PRAnswerOption*>*)value;

- (NSMutableSet<PRPMOSQuestion*>*)primitivePmosQuestion;
- (void)setPrimitivePmosQuestion:(NSMutableSet<PRPMOSQuestion*>*)value;

@end

@interface PRAnswerSetAttributes: NSObject 
+ (NSString *)id;
@end

@interface PRAnswerSetRelationships: NSObject
+ (NSString *)options;
+ (NSString *)pmosQuestion;
@end

NS_ASSUME_NONNULL_END
