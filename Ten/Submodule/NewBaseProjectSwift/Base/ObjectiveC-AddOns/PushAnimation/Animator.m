//
//  Animator.m
//  Aroma - iOS
//
//  Created by Yonatan Benami on 6/7/16.
//  Copyright © 2016 Idan. All rights reserved.
//

#import "Animator.h"

@interface PushAnimator()

@end

@implementation PushAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromVCFrame = fromViewController.view.frame;
    
    CGFloat width = toViewController.view.frame.size.width;
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectOffset(fromVCFrame, -width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = CGRectOffset(fromVCFrame, width, 0);
        toViewController.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        fromViewController.view.frame = fromVCFrame;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@interface PopAnimator()

@end

@implementation PopAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromVCFrame = fromViewController.view.frame;
    
    CGFloat width = toViewController.view.frame.size.width;
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectOffset(fromVCFrame, width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = CGRectOffset(fromVCFrame, -width, 0);
        toViewController.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        fromViewController.view.frame = fromVCFrame;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
