// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRNote.m instead.

#import "_PRNote.h"

@implementation PRNoteID
@end

@implementation _PRNote

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic recording;

@dynamic text;

@dynamic concernAsPrevent;

@dynamic concernAsWhat;

@dynamic concernAsWhy;

@dynamic questionAsGood;

- (NSMutableSet<PRQuestion*>*)questionAsGoodSet {
	[self willAccessValueForKey:@"questionAsGood"];

	NSMutableSet<PRQuestion*> *result = (NSMutableSet<PRQuestion*>*)[self mutableSetValueForKey:@"questionAsGood"];

	[self didAccessValueForKey:@"questionAsGood"];
	return result;
}

@dynamic questionAsNote;

@dynamic record;

@dynamic recordAsGood;

@dynamic ward;

@end

@implementation PRNoteAttributes 
+ (NSString *)recording {
	return @"recording";
}
+ (NSString *)text {
	return @"text";
}
@end

@implementation PRNoteRelationships 
+ (NSString *)concernAsPrevent {
	return @"concernAsPrevent";
}
+ (NSString *)concernAsWhat {
	return @"concernAsWhat";
}
+ (NSString *)concernAsWhy {
	return @"concernAsWhy";
}
+ (NSString *)questionAsGood {
	return @"questionAsGood";
}
+ (NSString *)questionAsNote {
	return @"questionAsNote";
}
+ (NSString *)record {
	return @"record";
}
+ (NSString *)recordAsGood {
	return @"recordAsGood";
}
+ (NSString *)ward {
	return @"ward";
}
@end

