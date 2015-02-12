// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRTrust.m instead.

#import "_PRTrust.h"

const struct PRTrustAttributes PRTrustAttributes = {
	.id = @"id",
	.name = @"name",
};

const struct PRTrustRelationships PRTrustRelationships = {
	.hospitals = @"hospitals",
};

const struct PRTrustFetchedProperties PRTrustFetchedProperties = {
};

@implementation PRTrustID
@end

@implementation _PRTrust

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRTrust" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRTrust";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRTrust" inManagedObjectContext:moc_];
}

- (PRTrustID*)objectID {
	return (PRTrustID*)[super objectID];
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






@dynamic hospitals;

	
- (NSMutableSet*)hospitalsSet {
	[self willAccessValueForKey:@"hospitals"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"hospitals"];
  
	[self didAccessValueForKey:@"hospitals"];
	return result;
}
	






@end
