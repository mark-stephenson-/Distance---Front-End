// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.m instead.

#import "_PRAnswerOption.h"

const struct PRAnswerOptionAttributes PRAnswerOptionAttributes = {
	.answerID = @"answerID",
	.image1 = @"image1",
	.image2 = @"image2",
	.imageTintIdentifier = @"imageTintIdentifier",
	.title = @"title",
};

const struct PRAnswerOptionRelationships PRAnswerOptionRelationships = {
	.question = @"question",
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






@dynamic title;






@dynamic question;

	






@end
