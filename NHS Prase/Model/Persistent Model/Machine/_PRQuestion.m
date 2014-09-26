// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.m instead.

#import "_PRQuestion.h"

const struct PRQuestionAttributes PRQuestionAttributes = {
	.answerID = @"answerID",
	.answerOptions = @"answerOptions",
	.questionID = @"questionID",
	.title = @"title",
};

const struct PRQuestionRelationships PRQuestionRelationships = {
	.concern = @"concern",
	.concernAsPrevent = @"concernAsPrevent",
	.concernAsSerious = @"concernAsSerious",
	.goodNote = @"goodNote",
	.note = @"note",
	.options = @"options",
	.record = @"record",
};

const struct PRQuestionFetchedProperties PRQuestionFetchedProperties = {
};

@implementation PRQuestionID
@end

@implementation _PRQuestion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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
	if ([key isEqualToString:@"questionIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"questionID"];
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





@dynamic answerOptions;






@dynamic questionID;



- (int64_t)questionIDValue {
	NSNumber *result = [self questionID];
	return [result longLongValue];
}

- (void)setQuestionIDValue:(int64_t)value_ {
	[self setQuestionID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveQuestionIDValue {
	NSNumber *result = [self primitiveQuestionID];
	return [result longLongValue];
}

- (void)setPrimitiveQuestionIDValue:(int64_t)value_ {
	[self setPrimitiveQuestionID:[NSNumber numberWithLongLong:value_]];
}





@dynamic title;






@dynamic concern;

	

@dynamic concernAsPrevent;

	

@dynamic concernAsSerious;

	

@dynamic goodNote;

	

@dynamic note;

	

@dynamic options;

	
- (NSMutableOrderedSet*)optionsSet {
	[self willAccessValueForKey:@"options"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"options"];
  
	[self didAccessValueForKey:@"options"];
	return result;
}
	

@dynamic record;

	






@end
