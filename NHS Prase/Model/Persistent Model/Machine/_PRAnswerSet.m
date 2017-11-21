// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerSet.m instead.

#import "_PRAnswerSet.h"

@implementation PRAnswerSetID
@end

@implementation _PRAnswerSet

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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
	[self setId:@(value_)];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:@(value_)];
}

@dynamic options;

- (NSMutableOrderedSet<PRAnswerOption*>*)optionsSet {
	[self willAccessValueForKey:@"options"];

	NSMutableOrderedSet<PRAnswerOption*> *result = (NSMutableOrderedSet<PRAnswerOption*>*)[self mutableOrderedSetValueForKey:@"options"];

	[self didAccessValueForKey:@"options"];
	return result;
}

@dynamic pmosQuestion;

- (NSMutableSet<PRPMOSQuestion*>*)pmosQuestionSet {
	[self willAccessValueForKey:@"pmosQuestion"];

	NSMutableSet<PRPMOSQuestion*> *result = (NSMutableSet<PRPMOSQuestion*>*)[self mutableSetValueForKey:@"pmosQuestion"];

	[self didAccessValueForKey:@"pmosQuestion"];
	return result;
}

@end

@implementation _PRAnswerSet (OptionsCoreDataGeneratedAccessors)
- (void)addOptions:(NSOrderedSet<PRAnswerOption*>*)value_ {
	[self.optionsSet unionOrderedSet:value_];
}
- (void)removeOptions:(NSOrderedSet<PRAnswerOption*>*)value_ {
	[self.optionsSet minusOrderedSet:value_];
}
- (void)addOptionsObject:(PRAnswerOption*)value_ {
	[self.optionsSet addObject:value_];
}
- (void)removeOptionsObject:(PRAnswerOption*)value_ {
	[self.optionsSet removeObject:value_];
}
- (void)insertObject:(PRAnswerOption*)value inOptionsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"options"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self options] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"options"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"options"];
}
- (void)removeObjectFromOptionsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"options"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self options] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"options"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"options"];
}
- (void)insertOptions:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"options"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self options] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"options"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"options"];
}
- (void)removeOptionsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"options"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self options] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"options"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"options"];
}
- (void)replaceObjectInOptionsAtIndex:(NSUInteger)idx withObject:(PRAnswerOption*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"options"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self options] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"options"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"options"];
}
- (void)replaceOptionsAtIndexes:(NSIndexSet *)indexes withOptions:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"options"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self options] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"options"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"options"];
}
@end

@implementation PRAnswerSetAttributes 
+ (NSString *)id {
	return @"id";
}
@end

@implementation PRAnswerSetRelationships 
+ (NSString *)options {
	return @"options";
}
+ (NSString *)pmosQuestion {
	return @"pmosQuestion";
}
@end

