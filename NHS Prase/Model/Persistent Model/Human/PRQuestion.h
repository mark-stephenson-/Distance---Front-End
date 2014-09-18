#import "_PRQuestion.h"

@interface PRQuestion : _PRQuestion {}
// Custom logic goes here.

@property (nonatomic, strong) NSArray *answerOptionsArray;

/// Helper method to return the indexPath of the answer in this questions options arrays.
-(NSIndexPath *)indexPathForAnswerID:(NSString *)answerID;

@end
