#import "PRAnswerOption.h"

#import "PRAPIManager.h"

@interface PRAnswerOption ()

// Private interface goes here.

@end


@implementation PRAnswerOption

// Custom logic goes here.

-(NSString *)localizationKeyForAnswerID
{
    return [[PRAPIManager sharedManager] TDCLocalizationsKeyForTDCoreIdentifier:self.answerID forEntityNamed:@"PRAnswerOption"];
}

@end
