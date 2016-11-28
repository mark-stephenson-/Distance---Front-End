// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRTrust.m instead.

#import "_PRTrust.h"

@implementation PRTrustID
@end

@implementation _PRTrust

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

@dynamic hospitals;

- (NSMutableSet<PRHospital*>*)hospitalsSet {
	[self willAccessValueForKey:@"hospitals"];

	NSMutableSet<PRHospital*> *result = (NSMutableSet<PRHospital*>*)[self mutableSetValueForKey:@"hospitals"];

	[self didAccessValueForKey:@"hospitals"];
	return result;
}

@end

@implementation PRTrustAttributes 
+ (NSString *)id {
	return @"id";
}
+ (NSString *)name {
	return @"name";
}
@end

@implementation PRTrustRelationships 
+ (NSString *)hospitals {
	return @"hospitals";
}
@end

