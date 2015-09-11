// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.h instead.

#import <CoreData/CoreData.h>

extern const struct PRQuestionAttributes {
	__unsafe_unretained NSString *answerID;
} PRQuestionAttributes;

extern const struct PRQuestionRelationships {
	__unsafe_unretained NSString *concern;
	__unsafe_unretained NSString *concernAsPrevent;
	__unsafe_unretained NSString *concernAsSerious;
	__unsafe_unretained NSString *goodNote;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *pmosQuestion;
	__unsafe_unretained NSString *record;
} PRQuestionRelationships;

@class PRConcern;
@class PRConcern;
@class PRConcern;
@class PRNote;
@class PRNote;
@class PRPMOSQuestion;
@class PRRecord;

@interface PRQuestionID : NSManagedObjectID {}
@end

@interface _PRQuestion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRQuestionID* objectID;

@property (nonatomic, strong) NSNumber* answerID;

@property (atomic) int64_t answerIDValue;
- (int64_t)answerIDValue;
- (void)setAnswerIDValue:(int64_t)value_;

//- (BOOL)validateAnswerID:(id*)value_ error:(NSError**)error_;

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

@property (nonatomic, strong) PRPMOSQuestion *pmosQuestion;

//- (BOOL)validatePmosQuestion:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PRRecord *record;

//- (BOOL)validateRecord:(id*)value_ error:(NSError**)error_;

@end

@interface _PRQuestion (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAnswerID;
- (void)setPrimitiveAnswerID:(NSNumber*)value;

- (int64_t)primitiveAnswerIDValue;
- (void)setPrimitiveAnswerIDValue:(int64_t)value_;

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

- (PRPMOSQuestion*)primitivePmosQuestion;
- (void)setPrimitivePmosQuestion:(PRPMOSQuestion*)value;

- (PRRecord*)primitiveRecord;
- (void)setPrimitiveRecord:(PRRecord*)value;

@end
