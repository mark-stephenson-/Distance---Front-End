// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRWard.m instead.

#import "_PRWard.h"

const struct PRWardAttributes PRWardAttributes = {
	.id = @"id",
	.name = @"name",
};

const struct PRWardRelationships PRWardRelationships = {
	.concerns = @"concerns",
	.goodNotes = @"goodNotes",
	.hospital = @"hospital",
	.records = @"records",
};

@implementation PRWardID
@end

@implementation _PRWard

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRWard" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRWard";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRWard" inManagedObjectContext:moc_];
}

- (PRWardID*)objectID {
	return (PRWardID*)[super objectID];
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

@dynamic name;

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

@dynamic hospital;

@dynamic records;

- (NSMutableSet*)recordsSet {
	[self willAccessValueForKey:@"records"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"records"];

	[self didAccessValueForKey:@"records"];
	return result;
}

@end

