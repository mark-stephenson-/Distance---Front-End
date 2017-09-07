// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.m instead.

#import "_PRAnswerOption.h"

@implementation PRAnswerOptionID
@end

@implementation _PRAnswerOption

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRAnswerOption" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRAnswerOption";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRAnswerOption" inManagedObjectContext:moc_];
}

- (PRAnswerOptionID*)objectID {
	return (PRAnswerOptionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"answerIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"answerID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"imageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imageID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"localizationIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"localizationID"];
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

@dynamic imageID;

- (int64_t)imageIDValue {
	NSNumber *result = [self imageID];
	return [result longLongValue];
}

- (void)setImageIDValue:(int64_t)value_ {
	[self setImageID:@(value_)];
}

- (int64_t)primitiveImageIDValue {
	NSNumber *result = [self primitiveImageID];
	return [result longLongValue];
}

- (void)setPrimitiveImageIDValue:(int64_t)value_ {
	[self setPrimitiveImageID:@(value_)];
}

@dynamic imageName;

@dynamic imageTintIdentifier;

@dynamic localizationID;

- (int64_t)localizationIDValue {
	NSNumber *result = [self localizationID];
	return [result longLongValue];
}

- (void)setLocalizationIDValue:(int64_t)value_ {
	[self setLocalizationID:@(value_)];
}

- (int64_t)primitiveLocalizationIDValue {
	NSNumber *result = [self primitiveLocalizationID];
	return [result longLongValue];
}

- (void)setPrimitiveLocalizationIDValue:(int64_t)value_ {
	[self setPrimitiveLocalizationID:@(value_)];
}

@dynamic title;

@dynamic answerSet;

- (NSMutableSet<PRAnswerSet*>*)answerSetSet {
	[self willAccessValueForKey:@"answerSet"];

	NSMutableSet<PRAnswerSet*> *result = (NSMutableSet<PRAnswerSet*>*)[self mutableSetValueForKey:@"answerSet"];

	[self didAccessValueForKey:@"answerSet"];
	return result;
}

@end

@implementation PRAnswerOptionAttributes 
+ (NSString *)answerID {
	return @"answerID";
}
+ (NSString *)imageID {
	return @"imageID";
}
+ (NSString *)imageName {
	return @"imageName";
}
+ (NSString *)imageTintIdentifier {
	return @"imageTintIdentifier";
}
+ (NSString *)localizationID {
	return @"localizationID";
}
+ (NSString *)title {
	return @"title";
}
@end

@implementation PRAnswerOptionRelationships 
+ (NSString *)answerSet {
	return @"answerSet";
}
@end

