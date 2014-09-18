//
//  PRFormViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TDFormKit/TDFormKit.h>

@interface PRFormViewController : TDFormViewController  <TDSelectCellDelegate>
{
    // height is constrained to be the content height at a low priority so it will never grow beyond its superview's frame but will be centered and clipped if it is smaller.
    IBOutlet NSLayoutConstraint *tableHeight;
}


@end
