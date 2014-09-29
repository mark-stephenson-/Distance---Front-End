// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.m instead.

#import "_PRAnswerOption.h"

const struct PRAnswerOptionAttributes PRAnswerOptionAttributes = {
	.answerID = @"answerID",
	.image1 = @"image1",
	.image2 = @"image2",
	.imageTintIdentifier = @"imageTintIdentifier",
	.localizationID = @"localizationID",
	.title = @"title",
};

const struct PRAnswerOptionRelationships PRAnswerOptionRelationships = {
	.answerSet = @"answerSet",
};

const struct PRAnswerOptionFetchedProperties PRAnswerOptionFetchedProperties = {
};

@implementation PRAnswerOptionID
@end

@implementation _PRAnswerOption

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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
	[self setAnswerID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveAnswerIDValue {
	NSNumber *result = [self primitiveAnswerID];
	return [result longLongValue];
}

- (void)setPrimitiveAnswerIDValue:(int64_t)value_ {
	[self setPrimitiveAnswerID:[NSNumber numberWithLongLong:value_]];
}





@dynamic image1;






@dynamic image2;






@dynamic imageTintIdentifier;






@dynamic localizationID;



- (int64_t)localizationIDValue {
	NSNumber *result = [self localizationID];
	return [result longLongValue];
}

- (void)setLocalizationIDValue:(int64_t)value_ {
	[self setLocalizationID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveLocalizationIDValue {
	NSNumber *result = [self primitiveLocalizationID];
	return [result longLongValue];
}

- (void)setPrimitiveLocalizationIDValue:(int64_t)value_ {
	[self setPrimitiveLocalizationID:[NSNumber numberWithLongLong:value_]];
}





@dynamic title;






@dynamic answerSet;

	
- (NSMutableSet*)answerSetSet {
	[self willAccessValueForKey:@"answerSet"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"answerSet"];
  
	[self didAccessValueForKey:@"answerSet"];
	return result;
}
	






@end
