// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRWard.m instead.

#import "_PRWard.h"

const struct PRWardAttributes PRWardAttributes = {
	.hospital = @"hospital",
	.trust = @"trust",
	.ward = @"ward",
};

const struct PRWardRelationships PRWardRelationships = {
	.concerns = @"concerns",
	.goodNotes = @"goodNotes",
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
	

	return keyPaths;
}




@dynamic hospital;






@dynamic trust;






@dynamic ward;






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
	

@dynamic records;

	
- (NSMutableSet*)recordsSet {
	[self willAccessValueForKey:@"records"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"records"];
  
	[self didAccessValueForKey:@"records"];
	return result;
}
	






@end
