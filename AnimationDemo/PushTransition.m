//
//  PushTransition.m
//  AnimationDemo
//
//  Created by YI on 16/10/5.
//  Copyright © 2016年 Sandro. All rights reserved.
//

#import "PushTransition.h"

@implementation PushTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 5.0f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toVc.view.frame = CGRectOffset(finalFrameForVc, 300, 20/*bounds.size.height*/);
    
    [[transitionContext containerView] addSubview:toVc.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.1
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         fromVc.view.alpha = 0.8;
                         toVc.view.frame = finalFrameForVc;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                         fromVc.view.alpha = 1.0;
                     }];
      

}
@end
