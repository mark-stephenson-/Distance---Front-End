// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOS.m instead.

#import "_PRPMOS.h"

@implementation PRPMOSID
@end

@implementation _PRPMOS

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRPMOS" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRPMOS";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRPMOS" inManagedObjectContext:moc_];
}

- (PRPMOSID*)objectID {
	return (PRPMOSID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic questions;

- (NSMutableOrderedSet<PRPMOSQuestion*>*)questionsSet {
	[self willAccessValueForKey:@"questions"];

	NSMutableOrderedSet<PRPMOSQuestion*> *result = (NSMutableOrderedSet<PRPMOSQuestion*>*)[self mutableOrderedSetValueForKey:@"questions"];

	[self didAccessValueForKey:@"questions"];
	return result;
}

@end

@implementation _PRPMOS (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSOrderedSet<PRPMOSQuestion*>*)value_ {
	[self.questionsSet unionOrderedSet:value_];
}
- (void)removeQuestions:(NSOrderedSet<PRPMOSQuestion*>*)value_ {
	[self.questionsSet minusOrderedSet:value_];
}
- (void)addQuestionsObject:(PRPMOSQuestion*)value_ {
	[self.questionsSet addObject:value_];
}
- (void)removeQuestionsObject:(PRPMOSQuestion*)value_ {
	[self.questionsSet removeObject:value_];
}
- (void)insertObject:(PRPMOSQuestion*)value inQuestionsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)removeObjectFromQuestionsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)insertQuestions:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)removeQuestionsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)replaceObjectInQuestionsAtIndex:(NSUInteger)idx withObject:(PRPMOSQuestion*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)replaceQuestionsAtIndexes:(NSIndexSet *)indexes withQuestions:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
}
@end

@implementation PRPMOSRelationships 
+ (NSString *)questions {
	return @"questions";
}
@end

