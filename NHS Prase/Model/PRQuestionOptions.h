//
//  PRQuestionAgree.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestion.h"

@interface PRQuestionOptions : PRQuestion

/*!
 @property options 
 
 An array of dictionaries of the form:
        
        @{@"title":<NSString *: option_title>, 
          @"image": <NSString *: image_title>}
 */
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, assign) BOOL showsNA;

@end
