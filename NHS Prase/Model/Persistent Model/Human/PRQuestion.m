#import "PRQuestion.h"


@interface PRQuestion ()

// Private interface goes here.

@end


@implementation PRQuestion

// Custom logic goes here.

-(NSArray *)answerOptionsArray
{
    return self.answerOptions;
}

-(void)setAnswerOptionsArray:(NSArray *)answerOptionsArray
{
    [super setAnswerOptions:answerOptionsArray];
}

@end
