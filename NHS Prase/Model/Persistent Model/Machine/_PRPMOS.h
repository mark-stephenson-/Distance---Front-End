// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOS.h instead.

#import <CoreData/CoreData.h>


extern const struct PRPMOSAttributes {
} PRPMOSAttributes;

extern const struct PRPMOSRelationships {
	__unsafe_unretained NSString *questions;
} PRPMOSRelationships;

extern const struct PRPMOSFetchedProperties {
} PRPMOSFetchedProperties;

@class PRPMOSQuestion;


@interface PRPMOSID : NSManagedObjectID {}
@end

@interface _PRPMOS : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRPMOSID*)objectID;





@property (nonatomic, strong) NSOrderedSet *questions;

- (NSMutableOrderedSet*)questionsSet;





@end

@interface _PRPMOS (CoreDataGeneratedAccessors)

- (void)addQuestions:(NSOrderedSet*)value_;
- (void)removeQuestions:(NSOrderedSet*)value_;
- (void)addQuestionsObject:(PRPMOSQuestion*)value_;
- (void)removeQuestionsObject:(PRPMOSQuestion*)value_;

@end

@interface _PRPMOS (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableOrderedSet*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableOrderedSet*)value;


@end
