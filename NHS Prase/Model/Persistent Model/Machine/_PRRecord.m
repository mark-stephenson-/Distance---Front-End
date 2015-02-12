// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.m instead.

#import "_PRRecord.h"

const struct PRRecordAttributes PRRecordAttributes = {
	.basicData = @"basicData",
	.language = @"language",
	.startDate = @"startDate",
	.timeAdditionalPatient = @"timeAdditionalPatient",
	.timeAdditionalQuestionnaire = @"timeAdditionalQuestionnaire",
	.timeTracked = @"timeTracked",
	.user = @"user",
};

const struct PRRecordRelationships PRRecordRelationships = {
	.concerns = @"concerns",
	.goodNotes = @"goodNotes",
	.notes = @"notes",
	.questions = @"questions",
	.ward = @"ward",
};

const struct PRRecordFetchedProperties PRRecordFetchedProperties = {
};

@implementation PRRecordID
@end

@implementation _PRRecord

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"timeAdditionalPatientValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeAdditionalPatient"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"timeAdditionalQuestionnaireValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeAdditionalQuestionnaire"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"timeTrackedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeTracked"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic basicData;






@dynamic language;






@dynamic startDate;






@dynamic timeAdditionalPatient;



- (long long)timeAdditionalPatientValue {
	NSNumber *result = [self timeAdditionalPatient];
	return [result longLongValue];
}

- (void)setTimeAdditionalPatientValue:(long long)value_ {
	[self setTimeAdditionalPatient:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveTimeAdditionalPatientValue {
	NSNumber *result = [self primitiveTimeAdditionalPatient];
	return [result longLongValue];
}

- (void)setPrimitiveTimeAdditionalPatientValue:(long long)value_ {
	[self setPrimitiveTimeAdditionalPatient:[NSNumber numberWithLongLong:value_]];
}





@dynamic timeAdditionalQuestionnaire;



- (long long)timeAdditionalQuestionnaireValue {
	NSNumber *result = [self timeAdditionalQuestionnaire];
	return [result longLongValue];
}

- (void)setTimeAdditionalQuestionnaireValue:(long long)value_ {
	[self setTimeAdditionalQuestionnaire:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveTimeAdditionalQuestionnaireValue {
	NSNumber *result = [self primitiveTimeAdditionalQuestionnaire];
	return [result longLongValue];
}

- (void)setPrimitiveTimeAdditionalQuestionnaireValue:(long long)value_ {
	[self setPrimitiveTimeAdditionalQuestionnaire:[NSNumber numberWithLongLong:value_]];
}





@dynamic timeTracked;



- (long long)timeTrackedValue {
	NSNumber *result = [self timeTracked];
	return [result longLongValue];
}

- (void)setTimeTrackedValue:(long long)value_ {
	[self setTimeTracked:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveTimeTrackedValue {
	NSNumber *result = [self primitiveTimeTracked];
	return [result longLongValue];
}

- (void)setPrimitiveTimeTrackedValue:(long long)value_ {
	[self setPrimitiveTimeTracked:[NSNumber numberWithLongLong:value_]];
}





@dynamic user;






@dynamic concerns;

	
- (NSMutableSet*)concernsSet {
	[self willAccessValueForKey:@"concerns"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"concerns"];
  
	[self didAccessValueForKey:@"concerns"];
	return result;
}
	

@dynamic goodNotes;

	
- (NSMutableSet*)goodNotesSet {
	[self willAccessValueForKey:@"goodNotes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"goodNotes"];
  
	[self didAccessValueForKey:@"goodNotes"];
	return result;
}
	

@dynamic notes;

	
- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];
  
	[self didAccessValueForKey:@"notes"];
	return result;
}
	

@dynamic questions;

	
- (NSMutableOrderedSet*)questionsSet {
	[self willAccessValueForKey:@"questions"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"questions"];
  
	[self didAccessValueForKey:@"questions"];
	return result;
}
	

@dynamic ward;

	





@end
