//
//  UINavigationController+DIY_NVC.m
//  DIYFont
//
//  Created by huangqiang on 17/4/1.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "UINavigationController+DIY_NVC.h"
#import <objc/runtime.h>
#import "UIViewController+DIY_VC.h"
@implementation UINavigationController (DIY_NVC)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL oMethod = NSSelectorFromString(@"_updateInteractiveTransition:");
        SEL nMethod = NSSelectorFromString(@"my_updataInteractiveTransition:");
        Method m1 = class_getInstanceMethod([self class], oMethod);
        Method m2 = class_getInstanceMethod([self class], nMethod);
        method_exchangeImplementations(m1, m2);
    });
}

#pragma mark private method
- (void)my_updataInteractiveTransition:(CGFloat)complete{
    [self my_updataInteractiveTransition:complete];
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        UIViewController * nextVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController * vc = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
        UIColor * color1 = vc.nColor;
        UIColor * color2 = nextVC.nColor;
        UIColor * color = [self mixColor1:color1 color2:color2 ratio:complete];
        [self changeColor:color];
    }
}

- (void)changeColor:(UIColor *)color{
    [self.navigationBar setBarTintColor:color];
}

- (UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio
{
    if(ratio > 1)
        ratio = 1;
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context{
    if([context isCancelled]){
        NSTimeInterval cancelDuration = [context transitionDuration] * (double)[context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            UIViewController * nextVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
            [self changeColor:nextVC.nColor];
        }];
    }else{
        NSTimeInterval finishDuration = [context transitionDuration] * (double)(1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            UIViewController * nextVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
            [self changeColor:nextVC.nColor];
        }];
    }
}

#pragma mark UINavigationBarDelegate
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    if (self.viewControllers.count >= navigationBar.items.count) {
        //点击返回按钮
        UIViewController * vc = self.viewControllers[self.viewControllers.count-2];
        [self changeColor:vc.nColor];
        [self popViewControllerAnimated:YES];
    }else{
        //使用代码返回
        UIViewController * vc = self.topViewController;
        [self changeColor:vc.nColor];
    }
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{
    return YES;
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        //添加对返回交互的监控
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            if([[UIDevice currentDevice].systemVersion doubleValue] < 10.0){
                [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context){
                    [self dealInteractionChanges:context];
                }];
            }else{
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context){
                    [self dealInteractionChanges:context];
                }];
            }
        }
    }
}
@end
