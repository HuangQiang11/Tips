//
//  CartView.m
//  CartAnmation
//
//  Created by huangqiang on 16/5/18.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "HQCartView.h"

#define kCartW 20
@interface HQCartView()
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) NSMutableArray * layerArray;
@end
@implementation HQCartView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUi];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self creatUi];
    }
    return self;
}

- (void)creatUi{
    [self addSubview:self.cartImageView];
    self.backgroundColor = [UIColor grayColor];
}

#pragma mark common method
- (void)addGoodsToCartWith:(CGPoint)point onView:(UIView *)view{
    self.bezierPath = [UIBezierPath bezierPath];
    [_bezierPath moveToPoint:point];
    
    //目的位置
    CGPoint convertPoint = [self convertCartImageViewPointToView:view];
    
    // 结束的：购物车图标那里， 控制点：x屏幕中心，y比起始点Y坐标高150像素
    [_bezierPath addQuadCurveToPoint:convertPoint controlPoint:CGPointMake(point.x +(convertPoint.x -point.x)/2.0, point.y-200)];
    
    //layer
    CALayer * animationLayer = [self makeLayerWithOrigin:point];
    [view.layer addSublayer:animationLayer];
    [self.layerArray addObject:animationLayer];
    //animation
    CAAnimationGroup * animation = [self makeAnimation];
    [animationLayer addAnimation:animation forKey:@"group"];
}

#pragma mark private method
- (CGPoint)convertCartImageViewPointToView:(UIView *)view{
    CGRect rect = [self convertRect:self.cartImageView.frame toView:view];
    CGPoint rect_to = CGPointMake(rect.origin.x + rect.size.width/2.0 + kCartW, rect.origin.y);
    return rect_to;
}

- (CALayer *)makeLayerWithOrigin:(CGPoint)origin{
    CALayer * amnimationLayer = [CALayer layer];
    amnimationLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"meizi.png"].CGImage);
    amnimationLayer.contentsGravity = kCAGravityResizeAspectFill;
    amnimationLayer.bounds = CGRectMake(0, 0, kCartW, kCartW);
    amnimationLayer.cornerRadius = kCartW/2.0;
    amnimationLayer.masksToBounds = YES;
    amnimationLayer.anchorPoint = CGPointZero; // 锚点设置未零,position就相当于x y坐标
    amnimationLayer.position = origin;
    return amnimationLayer;
}

- (CAAnimationGroup *)makeAnimation{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.path = self.bezierPath.CGPath; // 添加路径
    keyframeAnimation.rotationMode = kCAAnimationRotateAuto; // 自动旋转
    
    CAAnimationGroup *animtaionGroup = [CAAnimationGroup animation];
    animtaionGroup.animations = @[keyframeAnimation];
    /*
     当group动画的时长 > 组中所有动画的最长时长, 动画的时长以组中最长的时长为准
     当group动画的时长 < 组中所有动画的最长时长, 动画的时长以group的时长为准
     最合适: group的时长 = 组中所有动画的最长时长
     */
    animtaionGroup.duration = 1.0f;
    animtaionGroup.removedOnCompletion = NO; // yes连续点击会有图片影像
    animtaionGroup.fillMode = kCAFillModeForwards;
    animtaionGroup.delegate = self;
    return animtaionGroup;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    CALayer * layer = self.layerArray.firstObject;
    if (layer) {
        [layer removeFromSuperlayer];
        [self.layerArray removeObjectAtIndex:0];
    }
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnim.duration = 0.2f;
    basicAnim.fromValue = [NSNumber numberWithFloat:1];
    basicAnim.toValue = [NSNumber numberWithFloat:1.5];
    basicAnim.autoreverses = YES;
    [self.cartImageView.layer addAnimation:basicAnim forKey:nil];
}

#pragma mark lazy
- (UIImageView *)cartImageView{
    if (!_cartImageView) {
        _cartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, -10, 40, 40)];
        _cartImageView.backgroundColor = [UIColor greenColor];
        _cartImageView.layer.cornerRadius = 20;
        _cartImageView.layer.masksToBounds = YES;
    }
    return _cartImageView;
}

- (NSMutableArray *)layerArray{
    if (!_layerArray) {
        _layerArray = [NSMutableArray array];
    }
    return _layerArray;
}
@end
