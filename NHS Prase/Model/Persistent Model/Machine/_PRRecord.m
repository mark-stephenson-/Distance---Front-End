// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.m instead.

#import "_PRRecord.h"

@implementation PRRecordID
@end

@implementation _PRRecord

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRRecord" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRRecord";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRRecord" inManagedObjectContext:moc_];
}

- (PRRecordID*)objectID {
	return (PRRecordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"pmosIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pmosID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"timeAdditionalPatientValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeAdditionalPatient"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"timeAdditionalQuestionnaireValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeAdditionalQuestionnaire"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"timeTrackedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeTracked"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic basicData;

@dynamic incompleteReason;

@dynamic language;

@dynamic pmosID;

- (int64_t)pmosIDValue {
	NSNumber *result = [self pmosID];
	return [result longLongValue];
}

- (void)setPmosIDValue:(int64_t)value_ {
	[self setPmosID:@(value_)];
}

- (int64_t)primitivePmosIDValue {
	NSNumber *result = [self primitivePmosID];
	return [result longLongValue];
}

- (void)setPrimitivePmosIDValue:(int64_t)value_ {
	[self setPrimitivePmosID:@(value_)];
}

@dynamic startDate;

@dynamic timeAdditionalPatient;

- (int64_t)timeAdditionalPatientValue {
	NSNumber *result = [self timeAdditionalPatient];
	return [result longLongValue];
}

- (void)setTimeAdditionalPatientValue:(int64_t)value_ {
	[self setTimeAdditionalPatient:@(value_)];
}

- (int64_t)primitiveTimeAdditionalPatientValue {
	NSNumber *result = [self primitiveTimeAdditionalPatient];
	return [result longLongValue];
}

- (void)setPrimitiveTimeAdditionalPatientValue:(int64_t)value_ {
	[self setPrimitiveTimeAdditionalPatient:@(value_)];
}

@dynamic timeAdditionalQuestionnaire;

- (int64_t)timeAdditionalQuestionnaireValue {
	NSNumber *result = [self timeAdditionalQuestionnaire];
	return [result longLongValue];
}

- (void)setTimeAdditionalQuestionnaireValue:(int64_t)value_ {
	[self setTimeAdditionalQuestionnaire:@(value_)];
}

- (int64_t)primitiveTimeAdditionalQuestionnaireValue {
	NSNumber *result = [self primitiveTimeAdditionalQuestionnaire];
	return [result longLongValue];
}

- (void)setPrimitiveTimeAdditionalQuestionnaireValue:(int64_t)value_ {
	[self setPrimitiveTimeAdditionalQuestionnaire:@(value_)];
}

@dynamic timeTracked;

- (int64_t)timeTrackedValue {
	NSNumber *result = [self timeTracked];
	return [result longLongValue];
}

- (void)setTimeTrackedValue:(int64_t)value_ {
	[self setTimeTracked:@(value_)];
}

- (int64_t)primitiveTimeTrackedValue {
	NSNumber *result = [self primitiveTimeTracked];
	return [result longLongValue];
}

- (void)setPrimitiveTimeTrackedValue:(int64_t)value_ {
	[self setPrimitiveTimeTracked:@(value_)];
}

@dynamic user;

@dynamic concerns;

- (NSMutableSet<PRConcern*>*)concernsSet {
	[self willAccessValueForKey:@"concerns"];

	NSMutableSet<PRConcern*> *result = (NSMutableSet<PRConcern*>*)[self mutableSetValueForKey:@"concerns"];

	[self didAccessValueForKey:@"concerns"];
	return result;
}

@dynamic goodNotes;

- (NSMutableSet<PRNote*>*)goodNotesSet {
	[self willAccessValueForKey:@"goodNotes"];

	NSMutableSet<PRNote*> *result = (NSMutableSet<PRNote*>*)[self mutableSetValueForKey:@"goodNotes"];

	[self didAccessValueForKey:@"goodNotes"];
	return result;
}

@dynamic notes;

- (NSMutableSet<PRNote*>*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet<PRNote*> *result = (NSMutableSet<PRNote*>*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@dynamic questions;

- (NSMutableOrderedSet<PRQuestion*>*)questionsSet {
	[self willAccessValueForKey:@"questions"];

	NSMutableOrderedSet<PRQuestion*> *result = (NSMutableOrderedSet<PRQuestion*>*)[self mutableOrderedSetValueForKey:@"questions"];

	[self didAccessValueForKey:@"questions"];
	return result;
}

@dynamic ward;

@end

@implementation _PRRecord (QuestionsCoreDataGeneratedAccessors)
- (void)addQuestions:(NSOrderedSet<PRQuestion*>*)value_ {
	[self.questionsSet unionOrderedSet:value_];
}
- (void)removeQuestions:(NSOrderedSet<PRQuestion*>*)value_ {
	[self.questionsSet minusOrderedSet:value_];
}
- (void)addQuestionsObject:(PRQuestion*)value_ {
	[self.questionsSet addObject:value_];
}
- (void)removeQuestionsObject:(PRQuestion*)value_ {
	[self.questionsSet removeObject:value_];
}
- (void)insertObject:(PRQuestion*)value inQuestionsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)removeObjectFromQuestionsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)insertQuestions:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)removeQuestionsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)replaceObjectInQuestionsAtIndex:(NSUInteger)idx withObject:(PRQuestion*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
}
- (void)replaceQuestionsAtIndexes:(NSIndexSet *)indexes withQuestions:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self questions]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"questions"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"questions"];
}
@end

@implementation PRRecordAttributes 
+ (NSString *)basicData {
	return @"basicData";
}
+ (NSString *)incompleteReason {
	return @"incompleteReason";
}
+ (NSString *)language {
	return @"language";
}
+ (NSString *)pmosID {
	return @"pmosID";
}
+ (NSString *)startDate {
	return @"startDate";
}
+ (NSString *)timeAdditionalPatient {
	return @"timeAdditionalPatient";
}
+ (NSString *)timeAdditionalQuestionnaire {
	return @"timeAdditionalQuestionnaire";
}
+ (NSString *)timeTracked {
	return @"timeTracked";
}
+ (NSString *)user {
	return @"user";
}
@end

@implementation PRRecordRelationships 
+ (NSString *)concerns {
	return @"concerns";
}
+ (NSString *)goodNotes {
	return @"goodNotes";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)questions {
	return @"questions";
}
+ (NSString *)ward {
	return @"ward";
}
@end

