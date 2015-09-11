// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerSet.h instead.

#import <CoreData/CoreData.h>

extern const struct PRAnswerSetAttributes {
	__unsafe_unretained NSString *id;
} PRAnswerSetAttributes;

extern const struct PRAnswerSetRelationships {
	__unsafe_unretained NSString *options;
	__unsafe_unretained NSString *pmosQuestion;
} PRAnswerSetRelationships;

@class PRAnswerOption;
@class PRPMOSQuestion;

@interface PRAnswerSetID : NSManagedObjectID {}
@end

@interface _PRAnswerSet : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRAnswerSetID* objectID;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *options;

- (NSMutableOrderedSet*)optionsSet;

@property (nonatomic, strong) NSSet *pmosQuestion;

- (NSMutableSet*)pmosQuestionSet;

@end

@interface _PRAnswerSet (OptionsCoreDataGeneratedAccessors)
- (void)addOptions:(NSOrderedSet*)value_;
- (void)removeOptions:(NSOrderedSet*)value_;
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
- (void)addPmosQuestion:(NSSet*)value_;
- (void)removePmosQuestion:(NSSet*)value_;
- (void)addPmosQuestionObject:(PRPMOSQuestion*)value_;
- (void)removePmosQuestionObject:(PRPMOSQuestion*)value_;

@end

@interface _PRAnswerSet (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSMutableOrderedSet*)primitiveOptions;
- (void)setPrimitiveOptions:(NSMutableOrderedSet*)value;

- (NSMutableSet*)primitivePmosQuestion;
- (void)setPrimitivePmosQuestion:(NSMutableSet*)value;

@end
