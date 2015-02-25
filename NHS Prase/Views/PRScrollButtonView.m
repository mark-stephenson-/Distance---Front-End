//
//  PRScrollButtonView.m
//  NHS Prase
//
//  Created by Josh Campion on 24/02/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "PRScrollButtonView.h"
#import "PRTheme.h"

@implementation PRScrollButtonView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    if (self.scrollUpButton == nil) {
        self.scrollUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (self.scrollDownButton == nil) {
        self.scrollDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    // configure the common properties of the buttons
    for (UIButton *button in @[self.scrollDownButton, self.scrollUpButton]) {
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisHorizontal];
        [button setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisVertical];
        
        [button setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisHorizontal];
        [button setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisVertical];
        
        button.backgroundColor = [[PRTheme sharedTheme] mainColor];
        button.tintColor = [UIColor whiteColor];
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        [self addSubview:button];
        
        [button setTitle:@"" forState:UIControlStateDisabled];
        // observe the enabled state to simply change the colour at appropriate points.
        [button addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    [self.scrollUpButton setImage:[[UIImage imageNamed:@"up_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.scrollDownButton setImage:[[UIImage imageNamed:@"down_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

-(void)dealloc
{
    for (UIButton *button in @[self.scrollDownButton, self.scrollUpButton]) {
        [button removeObserver:self forKeyPath:@"enabled"];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ((object == self.scrollUpButton || object == self.scrollDownButton) && [keyPath isEqualToString:@"enabled"]) {
        UIButton *button = (UIButton *) object;
        button.backgroundColor = button.enabled ? [[PRTheme sharedTheme] mainColor] : [UIColor lightGrayColor];
        [button setNeedsLayout];
    }
}

-(void)updateConstraints
{
    BOOL constraintsAdded = NO;
    
    for (NSLayoutConstraint *constr in buttonConstraints) {
        if ([self.constraints containsObject:constr]) {
            constraintsAdded = YES;
        }
    }
    
    if (!constraintsAdded) {
        NSMutableArray *tempConstraints = [NSMutableArray array];
        
        NSDictionary *vDict = @{@"upButton": self.scrollUpButton,
                                @"downButton": self.scrollDownButton};
        
        [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[upButton]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:vDict]];
        
        [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[downButton]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:vDict]];
        
        [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[upButton]-(>=0)-[downButton]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:vDict]];

        if (self.widthConstraint == nil) {
            self.widthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:0.0
                                                                 constant:0.0];
            self.widthConstraint.priority = 100;
            [tempConstraints addObject:self.widthConstraint];
        }
        
        buttonConstraints = [NSArray arrayWithArray:tempConstraints];
        [self addConstraints:buttonConstraints];
    }
    
    
    
    [super updateConstraints];
}

@end
