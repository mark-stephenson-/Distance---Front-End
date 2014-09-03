//
//  PRInputAccessoryView.m
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRInputAccessoryView.h"

#import "PRButton.h"
#import "PRTheme.h"

@implementation PRInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
        // configure the visuals
        _nextButton = [[PRButton alloc] init];
        _nextButton.translatesAutoresizingMaskIntoConstraints = NO;
        _nextButton.cornerRadius = 0.0;
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.backgroundColor = [[PRTheme sharedTheme] neutralColor];
        _nextButton.frame = (CGRect) {CGPointZero, _nextButton.intrinsicContentSize};
        _nextButton.borderWidth = 0.0;
        
        _previousButton = [[PRButton alloc] init];
        _previousButton.cornerRadius = 0.0;
        [_previousButton setTitle:@"Previous" forState:UIControlStateNormal];
        [_previousButton setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
        [_previousButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _previousButton.backgroundColor = [[PRTheme sharedTheme] backColor];
        _previousButton.frame = (CGRect) {CGPointZero, _previousButton.intrinsicContentSize};
        _previousButton.borderWidth = 0.0;
        _previousButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        _cancelButton = [[PRButton alloc] init];
        _cancelButton.cornerRadius = 0.0;
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [[PRTheme sharedTheme] negativeColor];
        _cancelButton.frame = (CGRect) {CGPointZero, _cancelButton.intrinsicContentSize};
        _cancelButton.borderWidth = 0.0;
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_cancelButton];
        [self addSubview:_previousButton];
        [self addSubview:_nextButton];
        
        [_nextButton setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisVertical];
        [_nextButton setContentCompressionResistancePriority:752 forAxis:UILayoutConstraintAxisVertical];
        
        [_previousButton setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisVertical];
        [_previousButton setContentCompressionResistancePriority:752 forAxis:UILayoutConstraintAxisVertical];
        
        [_cancelButton setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisVertical];
        [_cancelButton setContentCompressionResistancePriority:752 forAxis:UILayoutConstraintAxisVertical];
        
        [self setContentCompressionResistancePriority:752 forAxis:UILayoutConstraintAxisVertical];
    }
    
    return self;
}

-(void)setNavigationDelegate:(id<PRInputAccessoryDelegate>)navigationDelegate
{
    
    
    // clear the old target receivers
    if (_navigationDelegate != nil) {
        // assign all the new button targerts
        [self.previousButton removeTarget:_navigationDelegate
                              action:@selector(inputAccessoryRequestsPrevious:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        [self.nextButton removeTarget:_navigationDelegate
                          action:@selector(inputAccessoryRequestsNext:)
                forControlEvents:UIControlEventTouchUpInside];
        
        [self.cancelButton removeTarget:_navigationDelegate
                            action:@selector(inputAccessoryRequestsDone:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
    _navigationDelegate = navigationDelegate;
    
    if (navigationDelegate != nil) {
        [self.previousButton addTarget:navigationDelegate
                           action:@selector(inputAccessoryRequestsPrevious:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        [self.nextButton addTarget:navigationDelegate
                       action:@selector(inputAccessoryRequestsNext:)
             forControlEvents:UIControlEventTouchUpInside];
        
        [self.cancelButton addTarget:navigationDelegate
                         action:@selector(inputAccessoryRequestsDone:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    
    delegateCanGoToNext = [self.navigationDelegate respondsToSelector:@selector(inputAccessoryCanGoToNext:)];
    delegateCanGoToPrevious = [self.navigationDelegate respondsToSelector:@selector(inputAccessoryCanGoToPrevious:)];
}

-(void)updateConstraints
{
    NSDictionary *vDict = @{@"cancel":self.cancelButton, @"prev":self.previousButton, @"next":self.nextButton};
    
    if (hConstrs == nil) {
        hConstrs = [NSLayoutConstraint constraintsWithVisualFormat:@"|[cancel]-(>=0)-[prev][next]|"
                                                           options:NSLayoutFormatAlignAllBaseline
                                                           metrics:nil
                                                             views:vDict];
        [self addConstraints:hConstrs];
    }

    if (vConstrs == nil) {
        vConstrs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancel]|"
                                                           options:0
                                                           metrics:nil
                                                             views:vDict];
        
        vConstrs = [vConstrs arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[prev]|"
                                                                                                   options:0
                                                                                                   metrics:nil
                                                                                                     views:vDict]];
        
        vConstrs = [vConstrs arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[next]|"
                                                                                                   options:0
                                                                                                   metrics:nil
                                                                                                     views:vDict]];
        [self addConstraints:vConstrs];
    }
    
    [super updateConstraints];
}

-(void)refreshBarButtonItemStatus
{
    if (delegateCanGoToNext) {
        self.nextButton.enabled = [self.navigationDelegate inputAccessoryCanGoToNext:self];
    }
    
    if (delegateCanGoToPrevious) {
        self.previousButton.enabled = [self.navigationDelegate inputAccessoryCanGoToPrevious:self];
    }
}

@end
