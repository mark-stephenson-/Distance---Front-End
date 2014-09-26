// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.h instead.

#import <CoreData/CoreData.h>


extern const struct PRQuestionAttributes {
	__unsafe_unretained NSString *answerID;
	__unsafe_unretained NSString *answerOptions;
	__unsafe_unretained NSString *questionID;
	__unsafe_unretained NSString *title;
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





@property (nonatomic, strong) NSNumber* answerID;



@property int64_t answerIDValue;
- (int64_t)answerIDValue;
- (void)setAnswerIDValue:(int64_t)value_;

//- (BOOL)validateAnswerID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id answerOptions;



//- (BOOL)validateAnswerOptions:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* questionID;



@property int64_t questionIDValue;
- (int64_t)questionIDValue;
- (void)setQuestionIDValue:(int64_t)value_;

//- (BOOL)validateQuestionID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





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


- (NSNumber*)primitiveAnswerID;
- (void)setPrimitiveAnswerID:(NSNumber*)value;

- (int64_t)primitiveAnswerIDValue;
- (void)setPrimitiveAnswerIDValue:(int64_t)value_;




- (id)primitiveAnswerOptions;
- (void)setPrimitiveAnswerOptions:(id)value;




- (NSNumber*)primitiveQuestionID;
- (void)setPrimitiveQuestionID:(NSNumber*)value;

- (int64_t)primitiveQuestionIDValue;
- (void)setPrimitiveQuestionIDValue:(int64_t)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





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
