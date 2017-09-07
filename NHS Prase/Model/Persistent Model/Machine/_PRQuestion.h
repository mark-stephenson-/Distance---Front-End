// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.h instead.

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
@class PRNote;
@class PRNote;
@class PRPMOSQuestion;
@class PRRecord;

@interface PRQuestionID : NSManagedObjectID {}
@end

@interface _PRQuestion : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRQuestionID *objectID;

@property (nonatomic, strong, nullable) NSNumber* answerID;

@property (atomic) int64_t answerIDValue;
- (int64_t)answerIDValue;
- (void)setAnswerIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) PRConcern *concern;

@property (nonatomic, strong, nullable) PRConcern *concernAsPrevent;

@property (nonatomic, strong, nullable) PRConcern *concernAsSerious;

@property (nonatomic, strong, nullable) PRNote *goodNote;

@property (nonatomic, strong, nullable) PRNote *note;

@property (nonatomic, strong, nullable) PRPMOSQuestion *pmosQuestion;

@property (nonatomic, strong, nullable) PRRecord *record;

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

@interface PRQuestionAttributes: NSObject 
+ (NSString *)answerID;
@end

@interface PRQuestionRelationships: NSObject
+ (NSString *)concern;
+ (NSString *)concernAsPrevent;
+ (NSString *)concernAsSerious;
+ (NSString *)goodNote;
+ (NSString *)note;
+ (NSString *)pmosQuestion;
+ (NSString *)record;
@end

NS_ASSUME_NONNULL_END
