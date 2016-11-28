// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRUser.m instead.

#import "_PRUser.h"

@implementation PRUserID
@end

@implementation _PRUser

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRUser" inManagedObjectContext:moc_];
}

- (PRUserID*)objectID {
	return (PRUserID*)[super objectID];
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

@dynamic password;

@dynamic username;

@end

@implementation PRUserAttributes 
+ (NSString *)id {
	return @"id";
}
+ (NSString *)password {
	return @"password";
}
+ (NSString *)username {
	return @"username";
}
@end

