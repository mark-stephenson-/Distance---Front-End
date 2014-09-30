#import "PRConcern.h"
#import "PRNote.h"
#import "PRQuestion.h"

@interface PRConcern ()

// Private interface goes here.

@end


@implementation PRConcern

// Custom logic goes here.

-(BOOL)isValid
{
    BOOL isValid = [self.whatNote isValid] || [self.whatNote isValid] || [self.preventNote isValid] || self.seriousQuestion.answerID != nil || self.preventQuestion.answerID != nil;
    
    return isValid;
}

@end
