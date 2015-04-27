//
//  UIViewController+Scrolling.h
//  NHS Prase
//
//  Created by Josh Campion on 24/02/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRScrollButtonView;

/**
 
 This category handles showing a PRScrollButtonView based on a reference scroll view. A view controller should call setupScrollingButtonsOnContainer: to set up the necessary KVO. Based on the reference scroll view the PRScrollButtonView will appear of disappear and the buttons will be enabled / disabled correctly. As KVO is used it is important to call tearDownScrollingContainer in the dealloc method of the ViewController that set up scrolling to remove the observers.
 
 Scrolling is managed through a private NSTimer property which repeatedly calls an increment function. When scrolling with one button begins, the other's userInteractionEnabled is set to false so only one scroll action can occur at once.
 
 */
@interface UIViewController (Scrolling)

/// Set in setupScrollingButtonsOnContainer:, this view determines whether the buttons should be visible and enabled.
@property (nonatomic, strong) UIScrollView *scrollButtonReferenceView;

/// Set from the storyboard this is the view whose visibility and buttons will be set based on scrollButtonReferenceView.
@property (nonatomic, strong) IBOutlet PRScrollButtonView *scrollButtonView;


-(void)setupScrollingButtonsOnContainer:(UIScrollView *) scrollView;
-(void)tearDownScrollingContainer;

@end
