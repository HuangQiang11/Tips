//
//  HQCartAnimationTool.m
//  CartAnmation
//
//  Created by huangqiang on 17/4/10.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "HQCartAnimationTool.h"
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
CGFloat kCartImageViewH = 50;
CGFloat kTipH = 20;
CGFloat kTipLableH = 16;
NSString * kLayer = @"kLayer";
NSString * kNum = @"kNum";
@interface HQCartAnimationTool ()<CAAnimationDelegate>
@property (nonatomic, strong) UIButton * cartBtn;
@property (nonatomic, strong) NSMutableArray * layerArray;
@property (nonatomic, strong) UILabel * tipLabel;
@end
@implementation HQCartAnimationTool
#pragma mark comment method
- (void)addGoodToCartWithOriginPoint:(CGPoint)oPoint image:(UIImage*)image tipNum:(NSUInteger)num{
    if (!self.vc) {
        return;
    }
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:oPoint];
    
    CGPoint dPoint = [self convertCartImageViewInSuperView];
    CGPoint controlPoint = CGPointMake(oPoint.x+(dPoint.x-oPoint.x)/2.0, oPoint.y-200);
    [path addQuadCurveToPoint:dPoint controlPoint:controlPoint];
    
    CALayer * animationLayer = [self creatLayoutWithOriginPoint:oPoint image:image];
    [self.vc.view.layer addSublayer:animationLayer];
    [self.layerArray addObject:@{kNum:@(num),kLayer:animationLayer}];
    
    CAAnimationGroup * animation = [self creatAnimationWithBeziPath:path];
    [animationLayer addAnimation:animation forKey:@"group"];
}

- (void)setupNum:(NSUInteger)num{
    if (num<= 0) {
        self.tipLabel.hidden = YES;
    }else{
        self.tipLabel.hidden = NO;
        self.tipLabel.text = [NSString stringWithFormat:@"%zd",num];
    }
}

#pragma mark private method
- (CALayer *)creatLayoutWithOriginPoint:(CGPoint)oPoint image:(UIImage *)image{
    CALayer * amnimationLayer = [CALayer layer];
    amnimationLayer.contents = (__bridge id _Nullable)(image.CGImage);
    amnimationLayer.contentsGravity = kCAGravityResizeAspectFill;
    amnimationLayer.bounds = CGRectMake(0, 0, kTipH, kTipH);
    amnimationLayer.cornerRadius = kTipH/2.0;
    amnimationLayer.masksToBounds = YES;
    amnimationLayer.anchorPoint = CGPointZero; // 锚点设置未零,position就相当于x y坐标
    amnimationLayer.position = oPoint;
    return amnimationLayer;
}

- (CAAnimationGroup *)creatAnimationWithBeziPath:(UIBezierPath *)path{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.path = path.CGPath; // 添加路径
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

- (CGPoint)convertCartImageViewInSuperView{
    return CGPointMake(self.cartBtn.center.x+kTipH, self.cartBtn.center.y);
}

- (void)cartBtnClick:(UIButton *)button{
    if (self.cartBtnClick) {
        self.cartBtnClick(nil);
    }
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer * layer = self.layerArray.firstObject[kLayer];
    NSUInteger num = [self.layerArray.firstObject[kNum] unsignedIntegerValue];
    if (layer) {
        [layer removeFromSuperlayer];
        [self.layerArray removeObjectAtIndex:0];
    }
    
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnim.duration = 0.2f;
    basicAnim.fromValue = [NSNumber numberWithFloat:1];
    basicAnim.toValue = [NSNumber numberWithFloat:1.2];
    basicAnim.autoreverses = YES;
    [self.cartBtn.layer addAnimation:basicAnim forKey:nil];
    
    if (self.animationEndBlock) {
        self.animationEndBlock(nil);
    }
    
    [self setupNum:num];
}

#pragma mark getter and setter
- (void)setVc:(UIViewController *)vc{
    _vc = vc;
    [vc.view addSubview:self.cartBtn];
    [self.cartBtn addSubview:self.tipLabel];
}

- (UIButton *)cartBtn{
    if (!_cartBtn) {
        _cartBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kCartImageViewH-20, SCREEN_HEIGHT-kCartImageViewH-20, kCartImageViewH, kCartImageViewH)];
        [_cartBtn setBackgroundImage:[UIImage imageNamed:@"shopping-cart_background"] forState:UIControlStateNormal];
        [_cartBtn setImage:[UIImage imageNamed:@"shopping-cart"] forState:UIControlStateNormal];
        [_cartBtn addTarget:self action:@selector(cartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cartBtn;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCartImageViewH-kTipLableH-4, 5, kTipLableH, kTipLableH)];
        _tipLabel.backgroundColor = [UIColor redColor];
        _tipLabel.layer.cornerRadius = kTipLableH/2.0;
        _tipLabel.font = [UIFont systemFontOfSize:10];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.layer.masksToBounds = YES;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

- (NSMutableArray *)layerArray{
    if (!_layerArray) {
        _layerArray = [NSMutableArray array];
    }
    return _layerArray;
}

- (void)setType:(HQCartAnimationType)type{
    _type = type;
    if (type == HQCartAnimationFromRight) {
        self.cartBtn.frame = CGRectMake(20, SCREEN_HEIGHT-kCartImageViewH-20, kCartImageViewH, kCartImageViewH);
    }
}

@end
