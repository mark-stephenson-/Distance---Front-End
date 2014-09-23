// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRRecord.m instead.

#import "_PRRecord.h"

const struct PRRecordAttributes PRRecordAttributes = {
	.basicData = @"basicData",
	.date = @"date",
	.language = @"language",
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

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic basicData;






@dynamic date;






@dynamic language;






@dynamic concerns;

	
- (NSMutableOrderedSet*)concernsSet {
	[self willAccessValueForKey:@"concerns"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"concerns"];
  
	[self didAccessValueForKey:@"concerns"];
	return result;
}
	

@dynamic goodNotes;

	
- (NSMutableOrderedSet*)goodNotesSet {
	[self willAccessValueForKey:@"goodNotes"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"goodNotes"];
  
	[self didAccessValueForKey:@"goodNotes"];
	return result;
}
	

@dynamic notes;

	
- (NSMutableOrderedSet*)notesSet {
	[self willAccessValueForKey:@"notes"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"notes"];
  
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
