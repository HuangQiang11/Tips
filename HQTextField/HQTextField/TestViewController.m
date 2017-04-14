//
//  TestViewController.m
//  HQTextField
//
//  Created by huangqiang on 16/9/14.
//  Copyright © 2016年 huangqiang. All rights reserved.
//

#import "TestViewController.h"
#import "SelectModel.h"
@interface TestViewController ()<HQTextFieldSelectStyleDelegate,HQTextFieldClickDelegate,HQTextFieldVerifyDelegate>{
    HQTextField * TF;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
//    TF= [[HQTextField alloc] init];
//    TF.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 48);
//    TF.textField.placeholder = @"test";
//    TF.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:TF];
//    TF.style = self.style;
//    TF.titleLabel.text = @"支付方式:";
    TF = [HQTextField textFieldWithTitle:@"支付方式:" placeholder:@"test" style:self.style frame:CGRectMake(10, 100, self.view.frame.size.width-20, 48)];
    [self.view addSubview:TF];
    
    
    TF.backgroundColor = [UIColor whiteColor];
    if (self.style == SelectStyle) {
        TF.selectDelegate = self;
    }
    if (self.style == ButtonStyle) {
        TF.clickDelegate = self;
    }
    
    if (self.style == NormalTitleAndVerifyStyle || self.style == NoTitleAndVerifyStyle) {
        TF.verifyDelegate = self;
    }
    
    if (self.style == PhoneTitleStyle) {
        TF.titleLabel.text = @"+86";
    }
}

#pragma mark HQTextFieldVerifyDelegate
- (void)TextFieldVerifyAction{
    NSLog(@"%s",__func__);
    [TF startTimer];
}

#pragma mark HQTextFieldClickDelegate
- (void)TextFieldClick:(UIButton *)button{
    NSLog(@"%s",__func__);
}

#pragma mark HQTextFieldSelectStyleDelegate
- (NSArray<SelectModel *> *)TextFieldSelectArr{
    SelectModel * model1 = ({
        SelectModel * model1 = [SelectModel new];
        model1.tipName = @"支付宝";
        model1.titleName = @"支付宝";
        model1.buttonW = 65;
        model1;
    });
    SelectModel * model2 = ({
        SelectModel * model2 = [SelectModel new];
        model2.tipName = @"微信";
        model2.titleName = @"微信";
        model2.buttonW = 60;
        model2;
    });
    return @[model1,model2];
}

- (void)TextFieldDidSelectIndex:(NSInteger)index{
    NSLog(@"%s:%zd",__func__,index);
}

@end
