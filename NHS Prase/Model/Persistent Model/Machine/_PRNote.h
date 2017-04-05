// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRNote.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

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

@interface _PRNote : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRNoteID *objectID;

@property (nonatomic, strong, nullable) NSData* recording;

@property (nonatomic, strong, nullable) NSString* text;

@property (nonatomic, strong, nullable) PRConcern *concernAsPrevent;

@property (nonatomic, strong, nullable) PRConcern *concernAsWhat;

@property (nonatomic, strong, nullable) PRConcern *concernAsWhy;

@property (nonatomic, strong, nullable) NSSet<PRQuestion*> *questionAsGood;
- (nullable NSMutableSet<PRQuestion*>*)questionAsGoodSet;

@property (nonatomic, strong, nullable) PRQuestion *questionAsNote;

@property (nonatomic, strong, nullable) PRRecord *record;

@property (nonatomic, strong, nullable) PRRecord *recordAsGood;

@property (nonatomic, strong, nullable) PRWard *ward;

@end

@interface _PRNote (QuestionAsGoodCoreDataGeneratedAccessors)
- (void)addQuestionAsGood:(NSSet<PRQuestion*>*)value_;
- (void)removeQuestionAsGood:(NSSet<PRQuestion*>*)value_;
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

- (NSMutableSet<PRQuestion*>*)primitiveQuestionAsGood;
- (void)setPrimitiveQuestionAsGood:(NSMutableSet<PRQuestion*>*)value;

- (PRQuestion*)primitiveQuestionAsNote;
- (void)setPrimitiveQuestionAsNote:(PRQuestion*)value;

- (PRRecord*)primitiveRecord;
- (void)setPrimitiveRecord:(PRRecord*)value;

- (PRRecord*)primitiveRecordAsGood;
- (void)setPrimitiveRecordAsGood:(PRRecord*)value;

- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;

@end

@interface PRNoteAttributes: NSObject 
+ (NSString *)recording;
+ (NSString *)text;
@end

@interface PRNoteRelationships: NSObject
+ (NSString *)concernAsPrevent;
+ (NSString *)concernAsWhat;
+ (NSString *)concernAsWhy;
+ (NSString *)questionAsGood;
+ (NSString *)questionAsNote;
+ (NSString *)record;
+ (NSString *)recordAsGood;
+ (NSString *)ward;
@end

NS_ASSUME_NONNULL_END
