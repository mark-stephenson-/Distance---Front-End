// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOSQuestion.m instead.

#import "_PRPMOSQuestion.h"

const struct PRPMOSQuestionAttributes PRPMOSQuestionAttributes = {
	.localizationID = @"localizationID",
	.questionID = @"questionID",
};

const struct PRPMOSQuestionRelationships PRPMOSQuestionRelationships = {
	.answerSets = @"answerSets",
	.pmos = @"pmos",
	.questions = @"questions",
};

@implementation PRPMOSQuestionID
@end

@implementation _PRPMOSQuestion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRPMOSQuestion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRPMOSQuestion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRPMOSQuestion" inManagedObjectContext:moc_];
}

- (PRPMOSQuestionID*)objectID {
	return (PRPMOSQuestionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"localizationIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"localizationID"];
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

@dynamic answerSets;

- (NSMutableOrderedSet*)answerSetsSet {
	[self willAccessValueForKey:@"answerSets"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"answerSets"];

	[self didAccessValueForKey:@"answerSets"];
	return result;
}

@dynamic pmos;

@dynamic questions;

- (NSMutableSet*)questionsSet {
	[self willAccessValueForKey:@"questions"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"questions"];

	[self didAccessValueForKey:@"questions"];
	return result;
}

@end

@implementation _PRPMOSQuestion (AnswerSetsCoreDataGeneratedAccessors)
- (void)addAnswerSets:(NSOrderedSet*)value_ {
	[self.answerSetsSet unionOrderedSet:value_];
}
- (void)removeAnswerSets:(NSOrderedSet*)value_ {
	[self.answerSetsSet minusOrderedSet:value_];
}
- (void)addAnswerSetsObject:(PRAnswerSet*)value_ {
	[self.answerSetsSet addObject:value_];
}
- (void)removeAnswerSetsObject:(PRAnswerSet*)value_ {
	[self.answerSetsSet removeObject:value_];
}
- (void)insertObject:(PRAnswerSet*)value inAnswerSetsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"answerSets"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self answerSets]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"answerSets"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"answerSets"];
}
- (void)removeObjectFromAnswerSetsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"answerSets"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self answerSets]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"answerSets"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"answerSets"];
}
- (void)insertAnswerSets:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"answerSets"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self answerSets]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"answerSets"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"answerSets"];
}
- (void)removeAnswerSetsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"answerSets"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self answerSets]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"answerSets"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"answerSets"];
}
- (void)replaceObjectInAnswerSetsAtIndex:(NSUInteger)idx withObject:(PRAnswerSet*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"answerSets"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self answerSets]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"answerSets"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"answerSets"];
}
- (void)replaceAnswerSetsAtIndexes:(NSIndexSet *)indexes withAnswerSets:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"answerSets"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self answerSets]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"answerSets"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"answerSets"];
}
@end

