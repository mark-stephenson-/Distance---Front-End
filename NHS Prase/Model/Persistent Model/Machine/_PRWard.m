// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRWard.m instead.

#import "_PRWard.h"

@implementation PRWardID
@end

@implementation _PRWard

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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
	[self setId:@(value_)];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:@(value_)];
}

@dynamic name;

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

@dynamic hospital;

@dynamic records;

- (NSMutableSet<PRRecord*>*)recordsSet {
	[self willAccessValueForKey:@"records"];

	NSMutableSet<PRRecord*> *result = (NSMutableSet<PRRecord*>*)[self mutableSetValueForKey:@"records"];

	[self didAccessValueForKey:@"records"];
	return result;
}

@end

@implementation PRWardAttributes 
+ (NSString *)id {
	return @"id";
}
+ (NSString *)name {
	return @"name";
}
@end

@implementation PRWardRelationships 
+ (NSString *)concerns {
	return @"concerns";
}
+ (NSString *)goodNotes {
	return @"goodNotes";
}
+ (NSString *)hospital {
	return @"hospital";
}
+ (NSString *)records {
	return @"records";
}
@end

