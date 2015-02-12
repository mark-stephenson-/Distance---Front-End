#import "PRNote.h"

#import <TheDistanceKit/TheDistanceKit_API.h>

@interface PRNote ()

// Private interface goes here.

@end


@implementation PRNote

// Custom logic goes here.

-(BOOL)isValid
{
    return [self.text isNonNullString];
}

@end
