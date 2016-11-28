// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.m instead.

#import "_PRQuestion.h"

@implementation PRQuestionID
@end

@implementation _PRQuestion

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRQuestion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRQuestion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRQuestion" inManagedObjectContext:moc_];
}

- (PRQuestionID*)objectID {
	return (PRQuestionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"answerIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"answerID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic answerID;

- (int64_t)answerIDValue {
	NSNumber *result = [self answerID];
	return [result longLongValue];
}

- (void)setAnswerIDValue:(int64_t)value_ {
	[self setAnswerID:@(value_)];
}

- (int64_t)primitiveAnswerIDValue {
	NSNumber *result = [self primitiveAnswerID];
	return [result longLongValue];
}

- (void)setPrimitiveAnswerIDValue:(int64_t)value_ {
	[self setPrimitiveAnswerID:@(value_)];
}

@dynamic concern;

@dynamic concernAsPrevent;

@dynamic concernAsSerious;

@dynamic goodNote;

@dynamic note;

@dynamic pmosQuestion;

@dynamic record;

@end

@implementation PRQuestionAttributes 
+ (NSString *)answerID {
	return @"answerID";
}
@end

@implementation PRQuestionRelationships 
+ (NSString *)concern {
	return @"concern";
}
+ (NSString *)concernAsPrevent {
	return @"concernAsPrevent";
}
+ (NSString *)concernAsSerious {
	return @"concernAsSerious";
}
+ (NSString *)goodNote {
	return @"goodNote";
}
+ (NSString *)note {
	return @"note";
}
+ (NSString *)pmosQuestion {
	return @"pmosQuestion";
}
+ (NSString *)record {
	return @"record";
}
@end

