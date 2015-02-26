//
//  UIViewController+Scrolling.m
//  NHS Prase
//
//  Created by Josh Campion on 24/02/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "UIViewController+Scrolling.h"

#import <objc/runtime.h>
#import <TheDistanceKit/TheDistanceKit_API.h>

#import "PRScrollButtonView.h"

#define SCROLL_TIME_INTERVAL 0.01
#define SCROLL_DELTA 5

@interface UIViewController ()

@property (nonatomic, retain) NSTimer *scrollingTimer;

@end

@implementation UIViewController (Scrolling)

#pragma mark - Set Up

-(void)setupScrollingButtonsOnContainer:(UIScrollView *)scrollView
{
    if (self.scrollButtonReferenceView != nil) {
        [self removeObservers];
    }
    
    self.scrollButtonReferenceView = scrollView;
    [self addObservers];
    
    [self.scrollButtonView.scrollUpButton addTarget:self
                                             action:@selector(startScrollUp:)
                                   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    
    [self.scrollButtonView.scrollDownButton addTarget:self
                                             action:@selector(startScrollDown:)
                                   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    
    [self.scrollButtonView.scrollUpButton addTarget:self
                                               action:@selector(stopScroll:)
                                     forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchDragExit];
    
    [self.scrollButtonView.scrollDownButton addTarget:self
                                               action:@selector(stopScroll:)
                                     forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchDragExit];
    
    [self refreshViews];
}

-(void)tearDownScrollingContainer
{
    [self setupScrollingButtonsOnContainer:nil];
}

-(void)addObservers
{
    // observe the offset to disable / enable the buttons based on scrolling by dragging
    [self.scrollButtonReferenceView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
    
    // observe the size to show / hide the button view appropriately.
    [self.scrollButtonReferenceView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

-(void)removeObservers
{
    [self.scrollButtonReferenceView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollButtonReferenceView removeObserver:self forKeyPath:@"contentSize"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.scrollButtonReferenceView && [@[@"contentOffset", @"contentSize"] containsString:keyPath]) {
        [self refreshViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Scrolling

-(void)startScrollUp:(id)sender
{
    if (self.scrollingTimer == nil) {
        self.scrollingTimer = [NSTimer timerWithTimeInterval:SCROLL_TIME_INTERVAL target:self selector:@selector(incrementScrollUp) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.scrollingTimer forMode:NSRunLoopCommonModes];
    }

    // prevent both buttons attempting to scroll the view at the same time
    self.scrollButtonView.scrollDownButton.userInteractionEnabled = NO;
}
                               
-(void)startScrollDown:(id)sender
{
    if (self.scrollingTimer == nil) {
        self.scrollingTimer = [NSTimer timerWithTimeInterval:SCROLL_TIME_INTERVAL target:self selector:@selector(incrementScrollDown) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.scrollingTimer forMode:NSRunLoopCommonModes];
    }
    
    // prevent both buttons attempting to scroll the view at the same time
    self.scrollButtonView.scrollUpButton.userInteractionEnabled = NO;
}

-(void)incrementScrollUp
{
    UIScrollView *scroll = self.scrollButtonReferenceView;
    CGFloat minOffsetY = -scroll.contentInset.top;
    
    // increment the scroll clipped to the top of the content
    CGPoint offset = scroll.contentOffset;
    offset.y = MAX(minOffsetY, offset.y - SCROLL_DELTA);
    scroll.contentOffset = offset;
    
    if (offset.y == minOffsetY) {
        // automatically disable the button to show when the view can't scroll any further
        [self.scrollButtonView.scrollUpButton cancelTrackingWithEvent:nil];
        [self stopScroll:nil];
    }
}

-(void)incrementScrollDown
{
    UIScrollView *scroll = self.scrollButtonReferenceView;
    CGFloat maxOffsetY = scroll.contentSize.height + scroll.contentInset.bottom - scroll.frame.size.height;
    
    // increment the scroll clipped to the bottom of the content
    CGPoint offset = self.scrollButtonReferenceView.contentOffset;
    offset.y = MIN(maxOffsetY, offset.y + SCROLL_DELTA);
    self.scrollButtonReferenceView.contentOffset = offset;
    
    if (offset.y == maxOffsetY) {
        // automatically disable the button to show when the view can't scroll any further
        [self.scrollButtonView.scrollDownButton cancelTrackingWithEvent:nil];
        [self stopScroll:nil];
    }
}

-(void)stopScroll:(id)sender
{
    if (self.scrollingTimer != nil) {
//        NSLog(@"stopping timer");
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
    }
    
    self.scrollButtonView.scrollUpButton.userInteractionEnabled = YES;
    self.scrollButtonView.scrollDownButton.userInteractionEnabled = YES;
    
    [self refreshViews];
}

#pragma mark - Layout

-(void)refreshViews
{
    UIScrollView *scroll = self.scrollButtonReferenceView;
    
    CGFloat scrollableHeight = scroll.contentSize.height + scroll.contentInset.top + scroll.contentInset.bottom;
    self.scrollButtonView.widthConstraint.priority = (scrollableHeight < scroll.frame.size.height) ? 900 : 100;
    [self.view layoutIfNeeded];
    
    CGFloat offsetY = scroll.contentOffset.y;
    CGFloat minOffsetY = -scroll.contentInset.top;
    CGFloat maxOffsetY = scroll.contentSize.height + scroll.contentInset.bottom - scroll.frame.size.height;
    
    self.scrollButtonView.scrollUpButton.enabled = offsetY > minOffsetY;
    self.scrollButtonView.scrollDownButton.enabled = offsetY < maxOffsetY;
}

#pragma mark - Setters

-(UIScrollView *)scrollButtonReferenceView
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setScrollButtonReferenceView:(UIScrollView *)scrollButtonReferenceView
{
    objc_setAssociatedObject(self, @selector(scrollButtonReferenceView), scrollButtonReferenceView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)scrollButtonView
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setScrollButtonView:(UIView *)scrollButtonView
{
    objc_setAssociatedObject(self, @selector(scrollButtonView), scrollButtonView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimer *)scrollingTimer
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setScrollingTimer:(NSTimer *)scrollingTimer
{
    objc_setAssociatedObject(self, @selector(scrollingTimer), scrollingTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
