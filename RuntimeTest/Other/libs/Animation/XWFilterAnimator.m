//
//  XWFilterAnimator.m
//  XWTransitionDemo
//
//  Created by wazrx on 16/6/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWFilterAnimator.h"

#import "XWFilterAnimator+XWMask.h"
#import "XWFilterAnimator+XWRipple.h"
//#import "XWFilterAnimator+XWCopyMachine.h"

@implementation XWFilterAnimator{
    UIView *_containerView;
    XWFilterAnimatorType _type;
}



+ (instancetype)xw_animatorWithType:(XWFilterAnimatorType)type {
    return[[self alloc] _initWithType:type];
}

- (instancetype)_initWithType:(XWFilterAnimatorType)type{
    self = [super init];
    if (self) {
        _type = type;
        self.needInteractiveTimer = YES;
        _revers = YES;
    }
    return self;
}

- (void)xw_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    _containerView = containerView;
    [containerView addSubview:toVC.view];
    XWFilterTransitionView *filterView = [[XWFilterTransitionView alloc] initWithFrame:containerView.bounds fromImage:[self xw_ImageFromsnapshotView:fromVC.view] toImage:[self xw_ImageFromsnapshotView:toVC.view]];
    switch (_type) {
                case XWFilterAnimatorTypeMask:{
            [self xw_maskAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration];
            break;
        }
			
        case XWFilterAnimatorTypeRipple:{
            [self xw_rippleAnimationFor:filterView transitionContext:transitionContext duration:self.toDuration];
            break;
        }
			
			default:
			break;
    }
    [containerView addSubview:filterView];
}

- (void)xw_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    _containerView = containerView;
    XWFilterTransitionView *filterView = [[XWFilterTransitionView alloc] initWithFrame:containerView.bounds fromImage:[self xw_ImageFromsnapshotView:fromVC.view] toImage:[self xw_ImageFromsnapshotView:toVC.view]];
    switch (_type) {
  
        case XWFilterAnimatorTypeMask:{
            [self xw_maskAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration];
            break;
        }
			
        case XWFilterAnimatorTypeRipple:{
            [self xw_rippleAnimationFor:filterView transitionContext:transitionContext duration:self.backDuration];
            break;
        }
    
			
			default:
			break;
    }
    [containerView addSubview:filterView];
}

- (UIImage *)xw_ImageFromsnapshotView:(UIView *)view{
    CALayer *layer = view.layer;
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)xw_interactiveTransitionWillBeginTimerAnimation:(XWInteractiveTransition *)interactiveTransition{
    _containerView.userInteractionEnabled = NO;
}

- (void)xw_interactiveTransition:(XWInteractiveTransition *)interactiveTransition willEndWithSuccessFlag:(BOOL)flag percent:(CGFloat)percent{
    _containerView.userInteractionEnabled = YES;
}

@end
