//
//  HQTextField.m
//  HQTextField
//
//  Created by huangqiang on 16/9/14.
//  Copyright © 2016年 huangqiang. All rights reserved.
//

#import "HQTextField.h"
#import "SelectModel.h"
#define PhoneTitleW 55
#define VerifyBtnW  80
#define TitleLabelX 15
#define TipLabelW   20
@interface HQTextField(){
    CGFloat titleLabelW;
}
@property (strong, nonatomic) UIButton * tapButton;
@property (strong, nonatomic) UIView   * bottomLine;
@property (strong, nonatomic) UIView   * hiddenLine;
@property (strong, nonatomic) UILabel  * tipLabel;
@property (strong, nonatomic) NSTimer  * timer;
@end

@implementation HQTextField
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self creatUI];
    }
    return self;
}

#pragma mark common method
+ (HQTextField *)textFieldWithTitle:(NSString *)title placeholder:(NSString *)placeholder style:(LayoutStyle)style frame:(CGRect)rect{
    return ({
        HQTextField * TF= [[HQTextField alloc] init];
        TF.frame = rect;
        TF.textField.placeholder = placeholder;
        TF.style = style;
        TF.titleLabel.text = title;
        TF;
    });
}

- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    [self.tapButton setTitle:@"10s" forState:UIControlStateNormal];
    self.tapButton.backgroundColor = [UIColor grayColor];
    self.tapButton.enabled = NO;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)endtimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self setTapBtnData];
}

#pragma mark notification Relative

- (void)addNotification{
    [self.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSString * newKey = [change objectForKey:NSKeyValueChangeNewKey];
    CGRect rect = [newKey boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    titleLabelW = CGRectGetWidth(rect);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark all click
- (void)tapButtonAction:(UIButton *)button{
    if (self.clickDelegate) {
        [self.clickDelegate TextFieldClick:button];
    }
    
    if (self.style == NoTitleAndVerifyStyle || self.style == NormalTitleAndVerifyStyle) {
        [self.verifyDelegate TextFieldVerifyAction];
    }
}

- (void)selectButtonAction:(UIButton *)button{
    if (button.selected) {
        return;
    }
    
    NSArray * arr = [self.selectDelegate TextFieldSelectArr];
    for (int i= 0; i<arr.count; i++) {
        UIButton * allButton = [self viewWithTag:i+100];
        allButton.selected = NO;
    }
    button.selected = YES;
    if (self.selectDelegate) {
        [self.selectDelegate TextFieldDidSelectIndex:button.tag-100];
    }
}

- (void)timeAction:(NSTimer *)timer{
    int n = [self.tapButton.titleLabel.text intValue];
    n -= 1;
    if (n == 0) {
        [self endtimer];
    }else{
        [self.tapButton setTitle:[NSString stringWithFormat:@"%ds",n] forState:UIControlStateNormal];
    }
}

#pragma mark private method
- (void)creatUI{
    [self addSubview:self.textField];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.hiddenLine];
    [self addSubview:self.tapButton];
    [self addSubview:self.tipLabel];
    
    _style = NoTitleStyle;
    
    [self addNotification];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat sWidth = self.frame.size.width;
    CGFloat sHeight = self.frame.size.height;
    switch (self.style) {
        case NoTitleStyle:
            self.textField.frame  = CGRectMake(0, 0, sWidth, sHeight);
            self.bottomLine.frame = CGRectMake(0, sHeight -1, sWidth, 1);
            break;
        case PhoneTitleStyle:
            self.textField.frame  = CGRectMake(PhoneTitleW +10, 0, sWidth -(PhoneTitleW+10), sHeight);
            self.bottomLine.frame = CGRectMake(0, sHeight -1, sWidth, 1);
            self.titleLabel.frame = CGRectMake(0, 0, PhoneTitleW, sHeight);
            self.hiddenLine.frame = CGRectMake(PhoneTitleW, sHeight -1, 10, 1);
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            break;
        case ButtonStyle:
            self.textField.userInteractionEnabled = NO;
            
            self.textField.frame  = CGRectMake(0, 0, sWidth, sHeight);
            self.bottomLine.frame = CGRectMake(0, sHeight -1, sWidth, 1);
            self.tapButton.frame  = self.textField.frame;
            break;
        case NoTitleAndVerifyStyle:
            self.textField.frame  = CGRectMake(0, 0, sWidth-VerifyBtnW, sHeight);
            self.bottomLine.frame = CGRectMake(0, sHeight -1, sWidth, 1);
            self.tapButton.frame  = CGRectMake(sWidth-VerifyBtnW, 0, VerifyBtnW, sHeight);
            [self setTapBtnData];
            break;
        case NormalTitleStyle:
            self.titleLabel.frame = CGRectMake(TitleLabelX, 0, titleLabelW, sHeight);
            self.textField.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+5, 0, sWidth-(CGRectGetMaxX(self.titleLabel.frame)+5), sHeight);
            break;
        case NormalTitleAndVerifyStyle:
            self.titleLabel.frame = CGRectMake(TitleLabelX, 0, titleLabelW, sHeight);
            self.textField.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+5, 0, sWidth-(CGRectGetMaxX(self.titleLabel.frame)+5)-VerifyBtnW, sHeight);
            self.tapButton.frame  = CGRectMake(sWidth-VerifyBtnW, 0, VerifyBtnW, sHeight);
            [self setTapBtnData];
            break;
        case NormalTitleAndMoneyTipStyle:
            self.titleLabel.frame = CGRectMake(TitleLabelX, 0, titleLabelW, sHeight);
            self.tipLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+5, sHeight/2.0-15, TipLabelW, TipLabelW);
            self.textField.frame = CGRectMake(CGRectGetMaxX(self.tipLabel.frame), 0, sWidth-(CGRectGetMaxX(self.tipLabel.frame)), sHeight);
            break;
        case SelectStyle:
        {
            self.titleLabel.frame = CGRectMake(TitleLabelX, 0, titleLabelW, sHeight);
            CGFloat x = titleLabelW+TitleLabelX+10;
            NSArray * arr = [self.selectDelegate TextFieldSelectArr];
            for (int i = 0; i<arr.count; i++) {
                SelectModel * model = arr[i];
                UIView * view1 = [self viewWithTag:i+10];
                UIView * view2 = [self viewWithTag:i+100];
                view1.frame = CGRectMake(x, 0, model.buttonW, sHeight);
                view2.frame = CGRectMake(x+model.buttonW, (sHeight-20)/2.0, 20, 20);
                x+=model.buttonW;
                x+=20+10;
            }
            break;
        }
        default:
            break;
    }
}

- (void)setTapBtnData{
    [self.tapButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.tapButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.tapButton.backgroundColor = [UIColor blueColor];
    self.tapButton.enabled = YES;
}

- (void)dealloc{
    [self.titleLabel removeObserver:self forKeyPath:@"text"];
}

#pragma mark set method
- (void)setSelectDelegate:(id<HQTextFieldSelectStyleDelegate>)selectDelegate{
    _selectDelegate = selectDelegate;
    NSArray * arr = [self.selectDelegate TextFieldSelectArr];
    for (int i = 0; i<arr.count; i++) {
        SelectModel * model = arr[i];
        UIButton * button = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:model.tipName] forState:UIControlStateNormal];
            [button setTitle:model.titleName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i+10;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.userInteractionEnabled = NO;
            button;
        });
        UIButton * selectButton = ({
            UIButton * selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [selectButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
            [selectButton setImage:[UIImage imageNamed:@"choose_sel"] forState:UIControlStateSelected];
            selectButton.tag = i+100;
            [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            selectButton;
        });
        [self addSubview:button];
        [self addSubview:selectButton];
    }
    [self selectButtonAction:[self viewWithTag:100]];
}

- (void)setStyle:(LayoutStyle)style{
    _style = style;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    if (_hiddenLine) {
        _hiddenLine.backgroundColor = backgroundColor;
    }
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    if (_bottomLine) {
        _bottomLine.backgroundColor = bottomLineColor;
    }
}

#pragma mark lazy
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textColor = [UIColor blackColor];
    }
    return _textField;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIView *)hiddenLine{
    if (!_hiddenLine) {
        _hiddenLine = [[UIView alloc] init];
        _hiddenLine.backgroundColor = self.backgroundColor;
    }
    return _hiddenLine;
}

- (UIButton*)tapButton{
    if (!_tapButton) {
        _tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tapButton addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapButton;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.text = @"¥";
        _tipLabel.font = [UIFont systemFontOfSize:20];
    }
    return _tipLabel;
}
@end
