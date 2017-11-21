// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRConcern.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRNote;
@class PRQuestion;
@class PRQuestion;
@class PRRecord;
@class PRQuestion;
@class PRWard;
@class PRNote;
@class PRNote;

@interface PRConcernID : NSManagedObjectID {}
@end

@interface _PRConcern : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRConcernID *objectID;

@property (nonatomic, strong, nullable) PRNote *preventNote;

@property (nonatomic, strong, nullable) PRQuestion *preventQuestion;

@property (nonatomic, strong, nullable) PRQuestion *question;

@property (nonatomic, strong, nullable) PRRecord *record;

@property (nonatomic, strong, nullable) PRQuestion *seriousQuestion;

@property (nonatomic, strong, nullable) PRWard *ward;

@property (nonatomic, strong, nullable) PRNote *whatNote;

@property (nonatomic, strong, nullable) PRNote *whyNote;

@end

@interface _PRConcern (CoreDataGeneratedPrimitiveAccessors)

- (PRNote*)primitivePreventNote;
- (void)setPrimitivePreventNote:(PRNote*)value;

- (PRQuestion*)primitivePreventQuestion;
- (void)setPrimitivePreventQuestion:(PRQuestion*)value;

- (PRQuestion*)primitiveQuestion;
- (void)setPrimitiveQuestion:(PRQuestion*)value;

- (PRRecord*)primitiveRecord;
- (void)setPrimitiveRecord:(PRRecord*)value;

- (PRQuestion*)primitiveSeriousQuestion;
- (void)setPrimitiveSeriousQuestion:(PRQuestion*)value;

- (PRWard*)primitiveWard;
- (void)setPrimitiveWard:(PRWard*)value;

- (PRNote*)primitiveWhatNote;
- (void)setPrimitiveWhatNote:(PRNote*)value;

- (PRNote*)primitiveWhyNote;
- (void)setPrimitiveWhyNote:(PRNote*)value;

@end

@interface PRConcernRelationships: NSObject
+ (NSString *)preventNote;
+ (NSString *)preventQuestion;
+ (NSString *)question;
+ (NSString *)record;
+ (NSString *)seriousQuestion;
+ (NSString *)ward;
+ (NSString *)whatNote;
+ (NSString *)whyNote;
@end

NS_ASSUME_NONNULL_END
