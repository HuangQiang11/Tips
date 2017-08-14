//
//  UIViewController+HQRect.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/14.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "UIViewController+HQRect.h"
#import <objc/runtime.h>
@implementation UIViewController (HQRect)
+ (void)load{
    SEL s_method = NSSelectorFromString(@"viewDidLayoutSubviews");
    SEL c_method = NSSelectorFromString(@"HQ_viewDidLayoutSubviews");
    Method s = class_getInstanceMethod(self, s_method);
    Method c = class_getInstanceMethod(self, c_method);
    method_exchangeImplementations(s,c);
}

- (void)HQ_viewDidLayoutSubviews{
    [self HQ_viewDidLayoutSubviews];
    if (!CGRectIsEmpty(self.highlightRect)) {
        self.view.frame = self.highlightRect;
    }
}

- (void)setHighlightRect:(CGRect)highlightRect{
    objc_setAssociatedObject(self, @selector(highlightRect), [NSValue valueWithCGRect:highlightRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)highlightRect{
    NSValue * value = objc_getAssociatedObject(self, @selector(highlightRect));
    return [value CGRectValue];
}
@end
