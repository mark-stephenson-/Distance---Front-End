#import "PRAnswerOption.h"

#import "PRAPIManager.h"

@interface PRAnswerOption ()

// Private interface goes here.

@end


@implementation PRAnswerOption

// Custom logic goes here.

-(NSString *)localizationKeyForAnswer
{
    return [[PRAPIManager sharedManager] TDCLocalizationsKeyForTDCoreIdentifier:self.localizationID];
}

@end
