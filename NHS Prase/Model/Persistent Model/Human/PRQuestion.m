#import "PRQuestion.h"
#import "PRAnswerOption.h"

#import <UIKit/UIKit.h>

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

-(NSIndexPath *)indexPathForAnswerID:(NSString *)answerID
{
    NSIndexPath *selectedPath = nil;
    
    for (int s = 0; s < self.answerOptionsArray.count; s++) {
        NSArray *sectionOptions = self.answerOptionsArray[s];
        
        for (int r = 0 ; r < sectionOptions.count; r++) {
            PRAnswerOption *thisOption = sectionOptions[r];
            
            if ([thisOption.optionID isEqualToString:answerID]) {
                selectedPath = [NSIndexPath indexPathForRow:r inSection:s];
            }
        }
    }
    
    return selectedPath;
}

@end
