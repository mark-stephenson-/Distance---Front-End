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

const struct PRPMOSQuestionFetchedProperties PRPMOSQuestionFetchedProperties = {
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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"localizationIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"localizationID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"questionIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"questionID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




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





@dynamic questionID;



- (long long)questionIDValue {
	NSNumber *result = [self questionID];
	return [result longLongValue];
}

- (void)setQuestionIDValue:(long long)value_ {
	[self setQuestionID:[NSNumber numberWithLongLong:value_]];
}

- (long long)primitiveQuestionIDValue {
	NSNumber *result = [self primitiveQuestionID];
	return [result longLongValue];
}

- (void)setPrimitiveQuestionIDValue:(long long)value_ {
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
