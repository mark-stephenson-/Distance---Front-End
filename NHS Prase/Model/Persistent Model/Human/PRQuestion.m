#import "PRQuestion.h"
#import "PRAnswerOption.h"
#import "PRAPIManager.h"

#import <UIKit/UIKit.h>

@interface PRQuestion ()

// Private interface goes here.

@end


@implementation PRQuestion

// Custom logic goes here.

-(NSString *)localizationKeyForAnswerID
{
    return [[PRAPIManager sharedManager] TDCLocalizationsKeyForTDCoreIdentifier:self.answerID forEntityNamed:@"PRAnswerOption"];
}

-(NSString *)localizationKeyForQuestionID
{
    return [[PRAPIManager sharedManager] TDCLocalizationsKeyForTDCoreIdentifier:self.questionID forEntityNamed:@"PRQuestion"];
}

-(NSArray *)answerOptionsArray
{
    return self.answerOptions;
}

-(void)setAnswerOptionsArray:(NSArray *)answerOptionsArray
{
    [super setAnswerOptions:answerOptionsArray];
}

-(NSIndexPath *)indexPathForAnswerID:(NSNumber *)answerID
{
    NSIndexPath *selectedPath = nil;
    
    for (int s = 0; s < self.answerOptionsArray.count; s++) {
        NSArray *sectionOptions = self.answerOptionsArray[s];
        
        for (int r = 0 ; r < sectionOptions.count; r++) {
            PRAnswerOption *thisOption = sectionOptions[r];
            
            if ([thisOption.answerID isEqualToNumber:answerID]) {
                selectedPath = [NSIndexPath indexPathForRow:r inSection:s];
            }
        }
    }
    
    return selectedPath;
}

@end
