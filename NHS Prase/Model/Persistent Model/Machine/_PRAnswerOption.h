// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PRAnswerSet;

@interface PRAnswerOptionID : NSManagedObjectID {}
@end

@interface _PRAnswerOption : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PRAnswerOptionID *objectID;

@property (nonatomic, strong, nullable) NSNumber* answerID;

@property (atomic) int64_t answerIDValue;
- (int64_t)answerIDValue;
- (void)setAnswerIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSNumber* imageID;

@property (atomic) int64_t imageIDValue;
- (int64_t)imageIDValue;
- (void)setImageIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* imageName;

@property (nonatomic, strong, nullable) NSString* imageTintIdentifier;

@property (nonatomic, strong, nullable) NSNumber* localizationID;

@property (atomic) int64_t localizationIDValue;
- (int64_t)localizationIDValue;
- (void)setLocalizationIDValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) NSSet<PRAnswerSet*> *answerSet;
- (nullable NSMutableSet<PRAnswerSet*>*)answerSetSet;

@end

@interface _PRAnswerOption (AnswerSetCoreDataGeneratedAccessors)
- (void)addAnswerSet:(NSSet<PRAnswerSet*>*)value_;
- (void)removeAnswerSet:(NSSet<PRAnswerSet*>*)value_;
- (void)addAnswerSetObject:(PRAnswerSet*)value_;
- (void)removeAnswerSetObject:(PRAnswerSet*)value_;

@end

@interface _PRAnswerOption (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAnswerID;
- (void)setPrimitiveAnswerID:(NSNumber*)value;

- (int64_t)primitiveAnswerIDValue;
- (void)setPrimitiveAnswerIDValue:(int64_t)value_;

- (NSNumber*)primitiveImageID;
- (void)setPrimitiveImageID:(NSNumber*)value;

- (int64_t)primitiveImageIDValue;
- (void)setPrimitiveImageIDValue:(int64_t)value_;

- (NSString*)primitiveImageName;
- (void)setPrimitiveImageName:(NSString*)value;

- (NSString*)primitiveImageTintIdentifier;
- (void)setPrimitiveImageTintIdentifier:(NSString*)value;

- (NSNumber*)primitiveLocalizationID;
- (void)setPrimitiveLocalizationID:(NSNumber*)value;

- (int64_t)primitiveLocalizationIDValue;
- (void)setPrimitiveLocalizationIDValue:(int64_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet<PRAnswerSet*>*)primitiveAnswerSet;
- (void)setPrimitiveAnswerSet:(NSMutableSet<PRAnswerSet*>*)value;

@end

@interface PRAnswerOptionAttributes: NSObject 
+ (NSString *)answerID;
+ (NSString *)imageID;
+ (NSString *)imageName;
+ (NSString *)imageTintIdentifier;
+ (NSString *)localizationID;
+ (NSString *)title;
@end

@interface PRAnswerOptionRelationships: NSObject
+ (NSString *)answerSet;
@end

NS_ASSUME_NONNULL_END
