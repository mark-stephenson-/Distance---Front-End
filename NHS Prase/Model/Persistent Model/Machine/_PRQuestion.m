// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRQuestion.m instead.

#import "_PRQuestion.h"

const struct PRQuestionAttributes PRQuestionAttributes = {
	.answerID = @"answerID",
	.answerOptions = @"answerOptions",
	.questionID = @"questionID",
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
	

	return keyPaths;
}




@dynamic answerID;






@dynamic answerOptions;






@dynamic questionID;






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
