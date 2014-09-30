//
//  PRTextSizeSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 23/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit.h>

/// Value can be an NSNumber in {0...6} or one of the UIKit extension NSStrings of the form UIContentSizeCategory*
@interface PRTextSizeSelectCell : TDCell
{
    IBOutlet UILabel *smallTextLabel;
    IBOutlet UILabel *largeTextLabel;
    
    NSInteger textSizeOptionCount;
    IBOutlet UISlider *textSizeSlider;
}

-(IBAction)sliderChange:(UISlider *)sender;

@end
