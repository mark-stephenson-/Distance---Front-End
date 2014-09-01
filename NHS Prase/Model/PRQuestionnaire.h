//
//  PRQuestionnaire.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRQuestionnaire : NSObject

@property (nonatomic, strong) NSArray *questions;

+(instancetype)prototypeQuestionnaire;

@end
