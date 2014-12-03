// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRNote.h instead.

#import <CoreData/CoreData.h>


extern const struct PRNoteAttributes {
	__unsafe_unretained NSString *recording;
	__unsafe_unretained NSString *text;
} PRNoteAttributes;

extern const struct PRNoteRelationships {
	__unsafe_unretained NSString *concernAsPrevent;
	__unsafe_unretained NSString *concernAsWhat;
	__unsafe_unretained NSString *concernAsWhy;
	__unsafe_unretained NSString *questionAsGood;
	__unsafe_unretained NSString *questionAsNote;
	__unsafe_unretained NSString *record;
	__unsafe_unretained NSString *recordAsGood;
	__unsafe_unretained NSString *ward;
} PRNoteRelationships;

extern const struct PRNoteFetchedProperties {
} PRNoteFetchedProperties;

@class PRConcern;
@class PRConcern;
@class PRConcern;
@class PRQuestion;
@class PRQuestion;
@class PRRecord;
@class PRRecord;
@class PRWard;




@interface PRNoteID : NSManagedObjectID {}
@end

@interface _PRNote : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRNoteID*)objectID;




@property (nonatomic, strong) NSData *recording;


//- (BOOL)validateRecording:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *text;


//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PRConcern* concernAsPrevent;

//- (BOOL)validateConcernAsPrevent:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRConcern* concernAsWhat;

//- (BOOL)validateConcernAsWhat:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRConcern* concernAsWhy;

//- (BOOL)validateConcernAsWhy:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* questionAsGood;

- (NSMutableSet*)questionAsGoodSet;




@property (nonatomic, strong) PRQuestion* questionAsNote;

//- (BOOL)validateQuestionAsNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRRecord* record;

//- (BOOL)validateRecord:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRRecord* recordAsGood;

//- (BOOL)validateRecordAsGood:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PRWard* ward;

//- (BOOL)validateWard:(id*)value_ error:(NSError**)error_;




@end

@interface _PRNote (CoreDataGeneratedAccessors)

- (void)addQuestionAsGood:(NSSet*)value_;
- (void)removeQuestionAsGood:(NSSet*)value_;
- (void)addQuestionAsGoodObject:(PRQuestion*)value_;
- (void)removeQuestionAsGoodObject:(PRQuestion*)value_;

@end

@interface _PRNote (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveRecording;
- (void)setPrimitiveRecording:(NSData*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (PRConcern*)primitiveConcernAsPrevent;
- (void)setPrimitiveConcernAsPrevent:(PRConcern*)value;



- (PRConcern*)primitiveConcernAsWhat;
- (void)setPrimitiveConcernAsWhat:(PRConcern*)value;



- (PRConcern*)primitiveConcernAsWhy;
- (void)setPrimitiveConcernAsWhy:(PRConcern*)value;



- (NSMutableSet*)primitiveQuestionAsGood;
- (void)setPrimitiveQuestionAsGood:(NSMutableSet*)value;



- (PRQuestion*)primitiveQuestionAsNote;
- (void)setPrimitiveQuestionAsNote:(PRQuestion*)value;



- (PRRecord*)primitiveRecord;
- (void)setPrimitiveRecord:(PRRecord*)value;



- (PRRecord*)primitiveRecordAsGood;
- (void)setPrimitiveRecordAsGood:(PRRecord*)value;



- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;


@end
