// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRHospital.m instead.

#import "_PRHospital.h"

const struct PRHospitalAttributes PRHospitalAttributes = {
	.id = @"id",
	.name = @"name",
};

const struct PRHospitalRelationships PRHospitalRelationships = {
	.trust = @"trust",
	.wards = @"wards",
};

const struct PRHospitalFetchedProperties PRHospitalFetchedProperties = {
};

@implementation PRHospitalID
@end

@implementation _PRHospital

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRHospital" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRHospital";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRHospital" inManagedObjectContext:moc_];
}

- (PRHospitalID*)objectID {
	return (PRHospitalID*)[super objectID];
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






@dynamic trust;

	

@dynamic wards;

	
- (NSMutableSet*)wardsSet {
	[self willAccessValueForKey:@"wards"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wards"];
  
	[self didAccessValueForKey:@"wards"];
	return result;
}
	






@end
