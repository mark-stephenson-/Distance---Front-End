// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.h instead.

#import <CoreData/CoreData.h>


extern const struct PRAnswerOptionAttributes {
	__unsafe_unretained NSString *answerID;
	__unsafe_unretained NSString *image1;
	__unsafe_unretained NSString *image2;
	__unsafe_unretained NSString *imageTintIdentifier;
	__unsafe_unretained NSString *title;
} PRAnswerOptionAttributes;

extern const struct PRAnswerOptionRelationships {
	__unsafe_unretained NSString *question;
} PRAnswerOptionRelationships;

extern const struct PRAnswerOptionFetchedProperties {
} PRAnswerOptionFetchedProperties;

@class PRQuestion;







@interface PRAnswerOptionID : NSManagedObjectID {}
@end

@interface _PRAnswerOption : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRAnswerOptionID*)objectID;





@property (nonatomic, strong) NSNumber* answerID;



@property int64_t answerIDValue;
- (int64_t)answerIDValue;
- (void)setAnswerIDValue:(int64_t)value_;

//- (BOOL)validateAnswerID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* image1;



//- (BOOL)validateImage1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* image2;



//- (BOOL)validateImage2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* imageTintIdentifier;



//- (BOOL)validateImageTintIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PRQuestion *question;

//- (BOOL)validateQuestion:(id*)value_ error:(NSError**)error_;





@end

@interface _PRAnswerOption (CoreDataGeneratedAccessors)

@end

@interface _PRAnswerOption (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAnswerID;
- (void)setPrimitiveAnswerID:(NSNumber*)value;

- (int64_t)primitiveAnswerIDValue;
- (void)setPrimitiveAnswerIDValue:(int64_t)value_;




- (NSString*)primitiveImage1;
- (void)setPrimitiveImage1:(NSString*)value;




- (NSString*)primitiveImage2;
- (void)setPrimitiveImage2:(NSString*)value;




- (NSString*)primitiveImageTintIdentifier;
- (void)setPrimitiveImageTintIdentifier:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (PRQuestion*)primitiveQuestion;
- (void)setPrimitiveQuestion:(PRQuestion*)value;


@end
