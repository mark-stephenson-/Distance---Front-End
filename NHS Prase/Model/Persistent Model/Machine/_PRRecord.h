// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.h instead.

#import <CoreData/CoreData.h>


extern const struct PRRecordAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *language;
} PRRecordAttributes;

extern const struct PRRecordRelationships {
	__unsafe_unretained NSString *concerns;
	__unsafe_unretained NSString *goodNotes;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *questions;
	__unsafe_unretained NSString *ward;
} PRRecordRelationships;

extern const struct PRRecordFetchedProperties {
} PRRecordFetchedProperties;

@class PRConcern;
@class PRNote;
@class PRNote;
@class PRQuestion;
@class PRWard;




@interface PRRecordID : NSManagedObjectID {}
@end

@interface _PRRecord : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRRecordID*)objectID;





@property (nonatomic, strong) NSDate* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* language;



//- (BOOL)validateLanguage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet *concerns;

- (NSMutableOrderedSet*)concernsSet;




@property (nonatomic, strong) NSOrderedSet *goodNotes;

- (NSMutableOrderedSet*)goodNotesSet;




@property (nonatomic, strong) NSOrderedSet *notes;

- (NSMutableOrderedSet*)notesSet;




@property (nonatomic, strong) NSOrderedSet *questions;

- (NSMutableOrderedSet*)questionsSet;




@property (nonatomic, strong) PRWard *ward;

//- (BOOL)validateWard:(id*)value_ error:(NSError**)error_;





@end

@interface _PRRecord (CoreDataGeneratedAccessors)

- (void)addConcerns:(NSOrderedSet*)value_;
- (void)removeConcerns:(NSOrderedSet*)value_;
- (void)addConcernsObject:(PRConcern*)value_;
- (void)removeConcernsObject:(PRConcern*)value_;

- (void)addGoodNotes:(NSOrderedSet*)value_;
- (void)removeGoodNotes:(NSOrderedSet*)value_;
- (void)addGoodNotesObject:(PRNote*)value_;
- (void)removeGoodNotesObject:(PRNote*)value_;

- (void)addNotes:(NSOrderedSet*)value_;
- (void)removeNotes:(NSOrderedSet*)value_;
- (void)addNotesObject:(PRNote*)value_;
- (void)removeNotesObject:(PRNote*)value_;

- (void)addQuestions:(NSOrderedSet*)value_;
- (void)removeQuestions:(NSOrderedSet*)value_;
- (void)addQuestionsObject:(PRQuestion*)value_;
- (void)removeQuestionsObject:(PRQuestion*)value_;

@end

@interface _PRRecord (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSString*)primitiveLanguage;
- (void)setPrimitiveLanguage:(NSString*)value;





- (NSMutableOrderedSet*)primitiveConcerns;
- (void)setPrimitiveConcerns:(NSMutableOrderedSet*)value;



- (NSMutableOrderedSet*)primitiveGoodNotes;
- (void)setPrimitiveGoodNotes:(NSMutableOrderedSet*)value;



- (NSMutableOrderedSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableOrderedSet*)value;



- (NSMutableOrderedSet*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableOrderedSet*)value;



- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;


@end
