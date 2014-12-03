// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRNote.m instead.

#import "_PRNote.h"

const struct PRNoteAttributes PRNoteAttributes = {
	.recording = @"recording",
	.text = @"text",
};

const struct PRNoteRelationships PRNoteRelationships = {
	.concernAsPrevent = @"concernAsPrevent",
	.concernAsWhat = @"concernAsWhat",
	.concernAsWhy = @"concernAsWhy",
	.questionAsGood = @"questionAsGood",
	.questionAsNote = @"questionAsNote",
	.record = @"record",
	.recordAsGood = @"recordAsGood",
	.ward = @"ward",
};

const struct PRNoteFetchedProperties PRNoteFetchedProperties = {
};

@implementation PRNoteID
@end

@implementation _PRNote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRNote" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRNote";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRNote" inManagedObjectContext:moc_];
}

- (PRNoteID*)objectID {
	return (PRNoteID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic recording;






@dynamic text;






@dynamic concernAsPrevent;

	

@dynamic concernAsWhat;

	

@dynamic concernAsWhy;

	

@dynamic questionAsGood;

	
- (NSMutableSet*)questionAsGoodSet {
	[self willAccessValueForKey:@"questionAsGood"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"questionAsGood"];
  
	[self didAccessValueForKey:@"questionAsGood"];
	return result;
}
	

@dynamic questionAsNote;

	

@dynamic record;

	

@dynamic recordAsGood;

	

@dynamic ward;

	





@end
