#import "_PRRecord.h"

@interface PRRecord : _PRRecord
// Custom logic goes here.

extern NSString *const PRRecordUsernameKey;

@property (nonatomic, readonly) NSDictionary *basicDataDictionary;

+(instancetype)newRecordWithWard:(PRWard *) ward;

/// Helper method to return the number of questions answered by checking each answerID on each question using isNonNull
-(NSInteger)answeredQuestions;



@end
