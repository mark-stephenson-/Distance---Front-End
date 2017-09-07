// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRHospital.m instead.

#import "_PRHospital.h"

@implementation PRHospitalID
@end

@implementation _PRHospital

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

@dynamic trust;

@dynamic wards;

- (NSMutableSet<PRWard*>*)wardsSet {
	[self willAccessValueForKey:@"wards"];

	NSMutableSet<PRWard*> *result = (NSMutableSet<PRWard*>*)[self mutableSetValueForKey:@"wards"];

	[self didAccessValueForKey:@"wards"];
	return result;
}

@end

@implementation PRHospitalAttributes 
+ (NSString *)id {
	return @"id";
}
+ (NSString *)name {
	return @"name";
}
@end

@implementation PRHospitalRelationships 
+ (NSString *)trust {
	return @"trust";
}
+ (NSString *)wards {
	return @"wards";
}
@end

