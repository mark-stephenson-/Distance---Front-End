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

extern const struct PRAnswerSetFetchedProperties {
} PRAnswerSetFetchedProperties;

@class PRAnswerOption;
@class PRPMOSQuestion;



@interface PRAnswerSetID : NSManagedObjectID {}
@end

@interface _PRAnswerSet : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRAnswerSetID*)objectID;




@property (nonatomic, strong) NSNumber *id;


@property long long idValue;
- (long long)idValue;
- (void)setIdValue:(long long)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet* options;

- (NSMutableOrderedSet*)optionsSet;




@property (nonatomic, strong) NSSet* pmosQuestion;

- (NSMutableSet*)pmosQuestionSet;




@end

@interface _PRAnswerSet (CoreDataGeneratedAccessors)

- (void)addOptions:(NSOrderedSet*)value_;
- (void)removeOptions:(NSOrderedSet*)value_;
- (void)addOptionsObject:(PRAnswerOption*)value_;
- (void)removeOptionsObject:(PRAnswerOption*)value_;

- (void)addPmosQuestion:(NSSet*)value_;
- (void)removePmosQuestion:(NSSet*)value_;
- (void)addPmosQuestionObject:(PRPMOSQuestion*)value_;
- (void)removePmosQuestionObject:(PRPMOSQuestion*)value_;

@end

@interface _PRAnswerSet (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (long long)primitiveIdValue;
- (void)setPrimitiveIdValue:(long long)value_;





- (NSMutableOrderedSet*)primitiveOptions;
- (void)setPrimitiveOptions:(NSMutableOrderedSet*)value;



- (NSMutableSet*)primitivePmosQuestion;
- (void)setPrimitivePmosQuestion:(NSMutableSet*)value;


@end
