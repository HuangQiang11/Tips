//
//  UISearchBar+HQCancelButton.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/14.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "UISearchBar+HQCancelButton.h"

@implementation UISearchBar (HQCancelButton)
- (UIButton *)cancelBtn{
    for (id obj in [self subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    return btn;
                }
            }
        }
    }
    return nil;
}
@end
