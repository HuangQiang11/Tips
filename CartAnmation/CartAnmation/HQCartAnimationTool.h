//
//  HQCartAnimationTool.h
//  CartAnmation
//
//  Created by huangqiang on 17/4/10.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^CartBlock)(id);
typedef NS_ENUM(NSInteger,HQCartAnimationType){
    HQCartAnimationFromRight,
    HQCartAnimationFromLeft
};

@interface HQCartAnimationTool : NSObject
@property (weak, nonatomic) UIViewController * vc;
@property (copy, nonatomic) CartBlock cartBtnClick;
@property (copy, nonatomic) CartBlock animationEndBlock;
@property (assign, nonatomic) HQCartAnimationType type;
- (void)addGoodToCartWithOriginPoint:(CGPoint)oPoint image:(UIImage*)image tipNum:(NSUInteger)num;
- (void)setupNum:(NSUInteger)num;
@end
