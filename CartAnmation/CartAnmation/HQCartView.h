//
//  CartView.h
//  CartAnmation
//
//  Created by huangqiang on 16/5/18.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQCartView : UIView
@property (strong, nonatomic) UIImageView * cartImageView;
- (void)addGoodsToCartWith:(CGPoint)point onView:(UIView *)view;
@end
