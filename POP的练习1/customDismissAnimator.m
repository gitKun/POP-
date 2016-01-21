//
//  customDismissAnimator.m
//  POP的练习1
//
//  Created by apple on 1/8/16.
//  Copyright © 2016 CaiFu. All rights reserved.
//

#import "customDismissAnimator.h"
#import "POP.h"

@implementation customDismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIView *dimmingView = nil;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.layer.opacity<1.0f) {
            dimmingView = obj;
            *stop = YES;
        }
    }];
    POPBasicAnimation *opcityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opcityAnimation.toValue = @(0.0);
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    offscreenAnimation.toValue = @(-fromVC.view.layer.position.y);
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    [fromVC.view.layer pop_addAnimation:offscreenAnimation forKey:nil];
    [dimmingView.layer pop_addAnimation:opcityAnimation forKey:nil];
}


@end
