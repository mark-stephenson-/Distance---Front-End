// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRConcern.m instead.

#import "_PRConcern.h"

const struct PRConcernAttributes PRConcernAttributes = {
};

const struct PRConcernRelationships PRConcernRelationships = {
	.preventNote = @"preventNote",
	.preventQuestion = @"preventQuestion",
	.question = @"question",
	.record = @"record",
	.seriousQuestion = @"seriousQuestion",
	.ward = @"ward",
	.whatNote = @"whatNote",
	.whyNote = @"whyNote",
};

const struct PRConcernFetchedProperties PRConcernFetchedProperties = {
};

@implementation PRConcernID
@end

@implementation _PRConcern

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRConcern" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRConcern";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRConcern" inManagedObjectContext:moc_];
}

- (PRConcernID*)objectID {
	return (PRConcernID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic preventNote;

	

@dynamic preventQuestion;

	

@dynamic question;

	

@dynamic record;

	

@dynamic seriousQuestion;

	

@dynamic ward;

	

@dynamic whatNote;

	

@dynamic whyNote;

	





@end
