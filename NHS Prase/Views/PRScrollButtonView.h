//
//  PRScrollButtonView.h
//  NHS Prase
//
//  Created by Josh Campion on 24/02/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Simple view to be used throughout the app when scroll buttons should be displayed. This view automatically creates its views to ensure consistency throughout the app so the properties are not IBOutlets.
@interface PRScrollButtonView : UIView
{
    /// As the view is reused from the storyboard the necessary constraints are created and stored so the view can check whether they are present before adding new ones.
    NSArray *buttonConstraints;
}

@property (nonatomic, strong) UIButton *scrollUpButton;
@property (nonatomic, strong) UIButton *scrollDownButton;

/// This is automatically created to control whether the view should be visible or not. It is created as width==0@100. The UIViewController(Scrolling) category should be used to adjust the priority of this constraint when the relevant scroll view's content is such that it should be scrolled.
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;

@end
