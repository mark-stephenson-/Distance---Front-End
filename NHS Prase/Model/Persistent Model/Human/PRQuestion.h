#import "_PRQuestion.h"

@interface PRQuestion : _PRQuestion
{
    NSArray *answerOptions;
}

// Custom logic goes here.

//@property (nonatomic, readonly) NSArray *answerOptionsArray;
@property (nonatomic, readonly) NSString *localizationKeyForQuestion;

/// Helper method to return the indexPath of the answer in this questions options arrays.
-(NSIndexPath *)indexPathForAnswerID:(NSNumber *)answerID;

@end
