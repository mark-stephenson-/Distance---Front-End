// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerSet.m instead.

#import "_PRAnswerSet.h"

const struct PRAnswerSetAttributes PRAnswerSetAttributes = {
	.id = @"id",
};

const struct PRAnswerSetRelationships PRAnswerSetRelationships = {
	.options = @"options",
	.pmosQuestion = @"pmosQuestion",
};

const struct PRAnswerSetFetchedProperties PRAnswerSetFetchedProperties = {
};

@implementation PRAnswerSetID
@end

@implementation _PRAnswerSet

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRAnswerSet" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRAnswerSet";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRAnswerSet" inManagedObjectContext:moc_];
}

- (PRAnswerSetID*)objectID {
	return (PRAnswerSetID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic id;



- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithLongLong:value_]];
}





@dynamic options;

	
- (NSMutableOrderedSet*)optionsSet {
	[self willAccessValueForKey:@"options"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"options"];
  
	[self didAccessValueForKey:@"options"];
	return result;
}
	

@dynamic pmosQuestion;

	
- (NSMutableSet*)pmosQuestionSet {
	[self willAccessValueForKey:@"pmosQuestion"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pmosQuestion"];
  
	[self didAccessValueForKey:@"pmosQuestion"];
	return result;
}
	






@end
