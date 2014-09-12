// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRAnswerOption.m instead.

#import "_PRAnswerOption.h"

const struct PRAnswerOptionAttributes PRAnswerOptionAttributes = {
	.image1 = @"image1",
	.image2 = @"image2",
	.imageTintIdentifier = @"imageTintIdentifier",
	.optionID = @"optionID",
};

const struct PRAnswerOptionRelationships PRAnswerOptionRelationships = {
	.question = @"question",
};

const struct PRAnswerOptionFetchedProperties PRAnswerOptionFetchedProperties = {
};

@implementation PRAnswerOptionID
@end

@implementation _PRAnswerOption

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PRAnswerOption" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PRAnswerOption";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PRAnswerOption" inManagedObjectContext:moc_];
}

- (PRAnswerOptionID*)objectID {
	return (PRAnswerOptionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic image1;






@dynamic image2;






@dynamic imageTintIdentifier;






@dynamic optionID;






@dynamic question;

	






@end
