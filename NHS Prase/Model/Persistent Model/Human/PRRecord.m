#import "PRRecord.h"

#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "PRQuestion.h"
#import "PRWard.h"
#import "PRAnswerOption.h"
#import "PRPMOS.h"
#import "PRPMOSQuestion.h"

#import <TheDistanceKit/TheDistanceKit.h>

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

    for (int q = 0; q < currentQuestionnaire.questions.count; q++) {
        PRPMOSQuestion *pmosQuestion = currentQuestionnaire.questions[q];
        
        PRQuestion *blankQuestion = [PRQuestion MR_createEntity];
        blankQuestion.pmosQuestion = pmosQuestion;
        
        [recordQuestions addObject:blankQuestion];
    }
    
    newRecord.questions = [NSOrderedSet orderedSetWithOrderedSet:recordQuestions];
    
    return newRecord;
}

/*
+(instancetype)prototypeRecordWithWard:(PRWard *) ward
{
    PRQuestion *q0 = [[self class] likelyQuestionWithID:@"question.recommend_ward"];
    PRQuestion *q1 = [[self class] agreeQuestionWithID:@"question.different_roles"];
    PRQuestion *q2 = [[self class] agreeQuestionWithID:@"question.dignity"];
    PRQuestion *q3 = [[self class] agreeQuestionWithID:@"question.who_to_ask"];

    PRRecord *newRecord = [PRRecord MR_createEntity];
    
    newRecord.questions = [NSOrderedSet orderedSetWithArray:@[q0, q1, q2, q3]];
    newRecord.ward = ward;
    
    return newRecord;
}

+(PRQuestion *)agreeQuestionWithID:(NSString *) idString
{
    PRQuestion *question = [PRQuestion MR_createEntity];
    
    question.options = [NSOrderedSet orderedSetWithArray:[self agreeOptions]];
    question.answerOptions = @[[self agreeOptions], [self abstainOptions]];
    question.questionID = idString;
    
    return question;
}

+(PRQuestion *)likelyQuestionWithID:(NSString *) idString
{
    PRQuestion *question = [PRQuestion MR_createEntity];
    
    question.options = [NSOrderedSet orderedSetWithArray:[self likelyOptions]];
    question.answerOptions = @[[self likelyOptions], [self abstainOptions]];
    question.questionID = idString;
    
    return question;
}

+(NSArray *)agreeOptions
{
    PRAnswerOption *agree1 = [PRAnswerOption MR_createEntity];
    agree1.optionID = @"option.strongly_disagree";
    agree1.image1 = @"cross";
    agree1.image2 = @"cross";
    agree1.imageTintIdentifier = @"negative";
    
    PRAnswerOption *agree2 = [PRAnswerOption MR_createEntity];
    agree2.optionID = @"option.disagree";
    agree2.image1 = @"cross";
    agree2.imageTintIdentifier = @"negative";
    
    PRAnswerOption *agree3 = [PRAnswerOption MR_createEntity];
    agree3.optionID = @"option.neither_agree";
    agree3.image1 = @"dash";
    agree3.imageTintIdentifier = @"main";
    
    PRAnswerOption *agree4 = [PRAnswerOption MR_createEntity];
    agree4.optionID = @"option.agree";
    agree4.image1 = @"tick";
    agree4.imageTintIdentifier = @"positive";
    
    PRAnswerOption *agree5 = [PRAnswerOption MR_createEntity];
    agree5.optionID = @"option.strongly_agree";
    agree5.image1 = @"tick";
    agree5.image2 = @"tick";
    agree5.imageTintIdentifier = @"positive";
    
    return @[agree1, agree2, agree3, agree4, agree5];
}

+(NSArray *)likelyOptions
{
    PRAnswerOption *likely1 = [PRAnswerOption MR_createEntity];
    likely1.optionID = @"option.very_likely";
    likely1.image1 = @"tick";
    likely1.image2 = @"tick";
    likely1.imageTintIdentifier = @"positive";
    
    PRAnswerOption *likely2 = [PRAnswerOption MR_createEntity];
    likely2.optionID = @"option.likely";
    likely2.image1 = @"tick";
    likely2.imageTintIdentifier = @"positive";
    
    PRAnswerOption *likely3 = [PRAnswerOption MR_createEntity];
    likely3.optionID = @"option.neither_likely";
    likely3.image1 = @"dash";
    likely3.imageTintIdentifier = @"main";
    
    PRAnswerOption *likely4 = [PRAnswerOption MR_createEntity];
    likely4.optionID = @"option.unlikely";
    likely4.image1 = @"cross";
    likely4.imageTintIdentifier = @"negative";
    
    PRAnswerOption *likely5 = [PRAnswerOption MR_createEntity];
    likely5.optionID = @"option.very_unlikely";
    likely5.image1 = @"cross";
    likely5.image2 = @"cross";
    likely5.imageTintIdentifier = @"negative";
    
    return @[likely5, likely4, likely3, likely2, likely1];
}

+(NSArray *)abstainOptions
{
    PRAnswerOption *abstain1 = [PRAnswerOption MR_createEntity];
    abstain1.optionID = @"option.not_applicable";
    abstain1.image1 = @"n_a";
    abstain1.imageTintIdentifier = @"main";
    
    PRAnswerOption *abstain2 = [PRAnswerOption MR_createEntity];
    abstain2.optionID = @"option.no_answer";
    abstain2.imageTintIdentifier = @"main";
    
    return @[abstain1, abstain2];
}
*/

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
        if (question.answerID != nil) {
            answeredCount++;
        }
    }
    
    return answeredCount;
}


@end
