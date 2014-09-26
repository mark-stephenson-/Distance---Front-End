#import "_PRQuestion.h"

@interface PRQuestion : _PRQuestion {}
// Custom logic goes here.

@property (nonatomic, strong) NSArray *answerOptionsArray;
@property (nonatomic, readonly) NSString *localizationKeyForQuestionID;
@property (nonatomic, readonly) NSString *localizationKeyForAnswerID;

/// Helper method to return the indexPath of the answer in this questions options arrays.
-(NSIndexPath *)indexPathForAnswerID:(NSNumber *)answerID;

@end
