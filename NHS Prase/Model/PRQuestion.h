//
//  PRQuestion.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRQuestion : NSObject

@property (nonatomic, strong) NSString *questionTitle;
@property (nonatomic, strong) id answer;

+(instancetype)questionWithTitle:(NSString *) title;



@end
