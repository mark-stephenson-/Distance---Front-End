// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.m instead.

#import "_PRAnswerOption.h"

const struct PRAnswerOptionAttributes PRAnswerOptionAttributes = {
	.answerID = @"answerID",
	.imageID = @"imageID",
	.imageName = @"imageName",
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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"answerIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"answerID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"imageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imageID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"localizationIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"localizationID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic answerID;



- (long long)answerIDValue {
	NSNumber *result = [self answerID];
	return [result longLongValue];
}

- (void)setAnswerIDValue:(long long)value_ {
	[self setAnswerID:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveAnswerIDValue {
	NSNumber *result = [self primitiveAnswerID];
	return [result longLongValue];
}

- (void)setPrimitiveAnswerIDValue:(long long)value_ {
	[self setPrimitiveAnswerID:[NSNumber numberWithLongLong:value_]];
}





@dynamic imageID;



- (long long)imageIDValue {
	NSNumber *result = [self imageID];
	return [result longLongValue];
}

- (void)setImageIDValue:(long long)value_ {
	[self setImageID:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveImageIDValue {
	NSNumber *result = [self primitiveImageID];
	return [result longLongValue];
}

- (void)setPrimitiveImageIDValue:(long long)value_ {
	[self setPrimitiveImageID:[NSNumber numberWithLongLong:value_]];
}





@dynamic imageName;






@dynamic imageTintIdentifier;






@dynamic localizationID;



- (long long)localizationIDValue {
	NSNumber *result = [self localizationID];
	return [result longLongValue];
}

- (void)setLocalizationIDValue:(long long)value_ {
	[self setLocalizationID:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveLocalizationIDValue {
	NSNumber *result = [self primitiveLocalizationID];
	return [result longLongValue];
}

- (void)setPrimitiveLocalizationIDValue:(long long)value_ {
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
