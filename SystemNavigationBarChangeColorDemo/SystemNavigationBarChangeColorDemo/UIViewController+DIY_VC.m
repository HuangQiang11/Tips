//
//  UIViewController+DIY_VC.m
//  DIYFont
//
//  Created by huangqiang on 17/4/1.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "UIViewController+DIY_VC.h"
#import <objc/runtime.h>
static NSString * nColorKey = @"nColorKey";
@implementation UIViewController (DIY_VC)
- (void)setNColor:(UIColor *)nColor{
    objc_setAssociatedObject(self, &nColorKey, nColor, OBJC_ASSOCIATION_COPY);
    if (self.navigationController) {
        [self.navigationController.navigationBar setBarTintColor:nColor];
    }
}

- (UIColor *)nColor{
    return objc_getAssociatedObject(self, &nColorKey);
}
@end
