//
//  UINavigationController+HQStatusBar.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/14.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "UINavigationController+HQStatusBar.h"

@implementation UINavigationController (HQStatusBar)
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.childViewControllers.firstObject;
}

@end
