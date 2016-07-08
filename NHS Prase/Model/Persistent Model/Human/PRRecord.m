#import "PRRecord.h"

#import <MagicalRecord/MagicalRecord.h>

#import "PRQuestion.h"
#import "PRWard.h"
#import "PRAnswerOption.h"
#import "PRPMOS.h"
#import "PRPMOSQuestion.h"
#import "PRQuestion.h"

#import <TheDistanceKit/TheDistanceKit_API.h>

NSString *const PRRecordUsernameKey = @"PRRecordUsername";

@interface PRRecord ()

// Private interface goes here. 

@end


@implementation PRRecord

// Custom logic goes here.

+(instancetype)newRecordWithWard:(PRWard *)ward
{
    PRRecord *newRecord = [PRRecord MR_createEntity];
    newRecord.ward = ward;
    
    // create a set of PRQuestions based on the PMOS. There should only ever be 1 PMOS in CoreData.
    PRPMOS *currentQuestionnaire = [PRPMOS MR_findFirst];
    //NSArray *pmosQs = [PRPMOSQuestion MR_findAll];
    NSMutableOrderedSet *recordQuestions = [NSMutableOrderedSet orderedSetWithCapacity:currentQuestionnaire.questions.count];

    NSMutableArray *allPMOSQuestions = [NSMutableArray arrayWithArray:[currentQuestionnaire.questions array]];
    
//    NSLog(@"All Questions: %@", [allPMOSQuestions valueForKeyPath:@"questionID"]);
    
    for (int q = 0; q < currentQuestionnaire.questions.count; q++) {
        NSInteger randomQuestoinIndex = arc4random() % allPMOSQuestions.count;
        
        PRPMOSQuestion *pmosQuestion = allPMOSQuestions[randomQuestoinIndex];
        [allPMOSQuestions removeObjectAtIndex:randomQuestoinIndex];
        
        PRQuestion *blankQuestion = [PRQuestion MR_createEntity];
        blankQuestion.pmosQuestion = pmosQuestion;
        
        [recordQuestions addObject:blankQuestion];
    }
    
//    NSLog(@"Random Questions: %@", [recordQuestions valueForKeyPath:@"pmosQuestion.questionID"]);
    
    newRecord.questions = [NSOrderedSet orderedSetWithOrderedSet:recordQuestions];
    
    return newRecord;
}

-(NSDictionary *)basicDataDictionary
{
    if ([self.basicData isKindOfClass:[NSDictionary class]]) {
        return self.basicData;
    }
    
    return nil;
}


-(NSInteger)answeredQuestions
{
    NSInteger answeredCount = 0;
    
    for (PRQuestion *question in self.questions) {
        if (question.answerID != nil && ![question.answerID isKindOfClass:[NSNull class]]) {
            answeredCount++;
        }
    }
    
    return answeredCount;
}


@end
