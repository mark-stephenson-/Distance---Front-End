// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPMOS.m instead.

#import "_PRPMOS.h"

const struct PRPMOSAttributes PRPMOSAttributes = {
};

const struct PRPMOSRelationships PRPMOSRelationships = {
	.questions = @"questions",
};

const struct PRPMOSFetchedProperties PRPMOSFetchedProperties = {
};

@implementation PRPMOSID
@end

@implementation _PRPMOS

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRPMOS" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRPMOS";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRPMOS" inManagedObjectContext:moc_];
}

- (PRPMOSID*)objectID {
	return (PRPMOSID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic questions;

	
- (NSMutableOrderedSet*)questionsSet {
	[self willAccessValueForKey:@"questions"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"questions"];
  
	[self didAccessValueForKey:@"questions"];
	return result;
}
	





@end
