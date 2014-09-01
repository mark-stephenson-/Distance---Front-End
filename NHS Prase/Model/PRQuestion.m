//
//  PRQuestion.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestion.h"

@implementation PRQuestion

+(instancetype)questionWithTitle:(NSString *)title
{
    PRQuestion *q = [[[self class] alloc] init];
    
    q.questionTitle = title;
    
    return q;
}

@end
