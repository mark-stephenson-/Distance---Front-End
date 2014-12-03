// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.h instead.

#import <CoreData/CoreData.h>


extern const struct PRAnswerOptionAttributes {
	__unsafe_unretained NSString *answerID;
	__unsafe_unretained NSString *imageID;
	__unsafe_unretained NSString *imageName;
	__unsafe_unretained NSString *imageTintIdentifier;
	__unsafe_unretained NSString *localizationID;
	__unsafe_unretained NSString *title;
} PRAnswerOptionAttributes;

extern const struct PRAnswerOptionRelationships {
	__unsafe_unretained NSString *answerSet;
} PRAnswerOptionRelationships;

extern const struct PRAnswerOptionFetchedProperties {
} PRAnswerOptionFetchedProperties;

@class PRAnswerSet;








@interface PRAnswerOptionID : NSManagedObjectID {}
@end

@interface _PRAnswerOption : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRAnswerOptionID*)objectID;




@property (nonatomic, strong) NSNumber *answerID;


@property long long answerIDValue;
- (long long)answerIDValue;
- (void)setAnswerIDValue:(long long)value_;

//- (BOOL)validateAnswerID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *imageID;


@property long long imageIDValue;
- (long long)imageIDValue;
- (void)setImageIDValue:(long long)value_;

//- (BOOL)validateImageID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *imageName;


//- (BOOL)validateImageName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *imageTintIdentifier;


//- (BOOL)validateImageTintIdentifier:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *localizationID;


@property long long localizationIDValue;
- (long long)localizationIDValue;
- (void)setLocalizationIDValue:(long long)value_;

//- (BOOL)validateLocalizationID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* answerSet;

- (NSMutableSet*)answerSetSet;




@end

@interface _PRAnswerOption (CoreDataGeneratedAccessors)

- (void)addAnswerSet:(NSSet*)value_;
- (void)removeAnswerSet:(NSSet*)value_;
- (void)addAnswerSetObject:(PRAnswerSet*)value_;
- (void)removeAnswerSetObject:(PRAnswerSet*)value_;

@end

@interface _PRAnswerOption (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAnswerID;
- (void)setPrimitiveAnswerID:(NSNumber*)value;

- (long long)primitiveAnswerIDValue;
- (void)setPrimitiveAnswerIDValue:(long long)value_;




- (NSNumber*)primitiveImageID;
- (void)setPrimitiveImageID:(NSNumber*)value;

- (long long)primitiveImageIDValue;
- (void)setPrimitiveImageIDValue:(long long)value_;




- (NSString*)primitiveImageName;
- (void)setPrimitiveImageName:(NSString*)value;




- (NSString*)primitiveImageTintIdentifier;
- (void)setPrimitiveImageTintIdentifier:(NSString*)value;




- (NSNumber*)primitiveLocalizationID;
- (void)setPrimitiveLocalizationID:(NSNumber*)value;

- (long long)primitiveLocalizationIDValue;
- (void)setPrimitiveLocalizationIDValue:(long long)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveAnswerSet;
- (void)setPrimitiveAnswerSet:(NSMutableSet*)value;


@end
