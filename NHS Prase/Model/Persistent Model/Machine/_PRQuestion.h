// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.h instead.

#import <CoreData/CoreData.h>


extern const struct PRQuestionAttributes {
	__unsafe_unretained NSString *answerID;
	__unsafe_unretained NSString *answerOptions;
	__unsafe_unretained NSString *questionID;
} PRQuestionAttributes;

extern const struct PRQuestionRelationships {
	__unsafe_unretained NSString *concern;
	__unsafe_unretained NSString *concernAsPrevent;
	__unsafe_unretained NSString *concernAsSerious;
	__unsafe_unretained NSString *goodNote;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *options;
	__unsafe_unretained NSString *record;
} PRQuestionRelationships;

extern const struct PRQuestionFetchedProperties {
} PRQuestionFetchedProperties;

@class PRConcern;
@class PRConcern;
@class PRConcern;
@class PRNote;
@class PRNote;
@class PRAnswerOption;
@class PRRecord;


@class NSObject;


@interface PRQuestionID : NSManagedObjectID {}
@end

@interface _PRQuestion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRQuestionID*)objectID;





@property (nonatomic, strong) NSString* answerID;



//- (BOOL)validateAnswerID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id answerOptions;



//- (BOOL)validateAnswerOptions:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* questionID;



//- (BOOL)validateQuestionID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PRConcern *concern;

//- (BOOL)validateConcern:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRConcern *concernAsPrevent;

//- (BOOL)validateConcernAsPrevent:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRConcern *concernAsSerious;

//- (BOOL)validateConcernAsSerious:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRNote *goodNote;

//- (BOOL)validateGoodNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRNote *note;

//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSOrderedSet *options;

- (NSMutableOrderedSet*)optionsSet;




@property (nonatomic, strong) PRRecord *record;

//- (BOOL)validateRecord:(id*)value_ error:(NSError**)error_;





@end

@interface _PRQuestion (CoreDataGeneratedAccessors)

- (void)addOptions:(NSOrderedSet*)value_;
- (void)removeOptions:(NSOrderedSet*)value_;
- (void)addOptionsObject:(PRAnswerOption*)value_;
- (void)removeOptionsObject:(PRAnswerOption*)value_;

@end

@interface _PRQuestion (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAnswerID;
- (void)setPrimitiveAnswerID:(NSString*)value;




- (id)primitiveAnswerOptions;
- (void)setPrimitiveAnswerOptions:(id)value;




- (NSString*)primitiveQuestionID;
- (void)setPrimitiveQuestionID:(NSString*)value;





- (PRConcern*)primitiveConcern;
- (void)setPrimitiveConcern:(PRConcern*)value;



- (PRConcern*)primitiveConcernAsPrevent;
- (void)setPrimitiveConcernAsPrevent:(PRConcern*)value;



- (PRConcern*)primitiveConcernAsSerious;
- (void)setPrimitiveConcernAsSerious:(PRConcern*)value;



- (PRNote*)primitiveGoodNote;
- (void)setPrimitiveGoodNote:(PRNote*)value;



- (PRNote*)primitiveNote;
- (void)setPrimitiveNote:(PRNote*)value;



- (NSMutableOrderedSet*)primitiveOptions;
- (void)setPrimitiveOptions:(NSMutableOrderedSet*)value;



- (PRRecord*)primitiveRecord;
- (void)setPrimitiveRecord:(PRRecord*)value;


@end
