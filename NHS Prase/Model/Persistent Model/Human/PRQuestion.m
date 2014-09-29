#import "PRQuestion.h"
#import "PRPMOSQuestion.h"
#import "PRAnswerSet.h"
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
    return [[PRAPIManager sharedManager] TDCLocalizationsKeyForTDCoreIdentifier:self.pmosQuestion.questionID forEntityNamed:@"PRPMOSQuestion"];
}

/*
-(NSArray *)answerOptionsArray
{
    if (answerOptions == nil) {
        NSOrderedSet *answerSets = self.pmosQuestion.answerSets;
        
        NSMutableArray *answerOptions = [NSMutableArray arrayWithCapacity:answerSets.count];
        
        for (int s = 0; s < answerSets.count; s++) {
            PRAnswerSet *thisSet = answerSets[s];
            NSMutableArray *theseOptions = [NSMutableArray arrayWithCapacity:thisSet.options.count];
            
            for (int a = 0; a < thisSet.options.count; a++) {
                [theseOptions addObject:thisSet.options[a]];
            }
            
            [answerOptions addObject:theseOptions];
        }
    }
    
    return  answerOptions;
}
*/
-(NSIndexPath *)indexPathForAnswerID:(NSNumber *)answerID
{
    NSIndexPath *selectedPath = nil;
    
    for (int s = 0; s < self.pmosQuestion.answerSets.count && selectedPath == nil; s++) {
        PRAnswerSet *thisSet = self.pmosQuestion.answerSets[s];
        
        for (int r = 0 ; r < thisSet.options.count && selectedPath == nil; r++) {
            PRAnswerOption *thisOption = thisSet.options[r];
            
            if ([thisOption.answerID isEqualToNumber:answerID]) {
                selectedPath = [NSIndexPath indexPathForRow:r inSection:s];
            }
        }
    }
    
    return selectedPath;
}

@end
