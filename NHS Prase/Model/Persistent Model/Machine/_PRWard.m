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

const struct PRWardFetchedProperties PRWardFetchedProperties = {
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



- (int16_t)idValue {
	NSNumber *result = [self id];
	return [result shortValue];
}

- (void)setIdValue:(int16_t)value_ {
	[self setId:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result shortValue];
}

- (void)setPrimitiveIdValue:(int16_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithShort:value_]];
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
