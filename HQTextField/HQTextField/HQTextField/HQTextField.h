//
//  HQTextField.h
//  HQTextField
//
//  Created by huangqiang on 16/9/14.
//  Copyright © 2016年 huangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectModel;

@protocol HQTextFieldClickDelegate <NSObject>
- (void)TextFieldClick:(UIButton *)button;
@end

@protocol HQTextFieldSelectStyleDelegate <NSObject>
- (NSArray<SelectModel *>*)TextFieldSelectArr;
- (void)TextFieldDidSelectIndex:(NSInteger)index;
@end

@protocol HQTextFieldVerifyDelegate <NSObject>
- (void)TextFieldVerifyAction;
@end

typedef NS_ENUM (NSUInteger, LayoutStyle){
    NoTitleStyle = 0,
    ButtonStyle,
    SelectStyle,
    PhoneTitleStyle,
    NormalTitleStyle,
    NoTitleAndVerifyStyle,
    NormalTitleAndVerifyStyle,
    NormalTitleAndMoneyTipStyle,
};
@interface HQTextField : UIView
@property (assign, nonatomic) LayoutStyle style;
@property (strong, nonatomic) UITextField * textField;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UIColor * bottomLineColor;
@property (assign, nonatomic) id<HQTextFieldSelectStyleDelegate>selectDelegate;
@property (assign, nonatomic) id<HQTextFieldClickDelegate>clickDelegate;
@property (assign, nonatomic) id<HQTextFieldVerifyDelegate>verifyDelegate;

+ (HQTextField *)textFieldWithTitle:(NSString *)title placeholder:(NSString *)placeholder style:(LayoutStyle)style frame:(CGRect)rect;
- (void)startTimer;
- (void)endtimer;
@end
