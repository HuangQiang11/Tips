//
//  NextController.m
//  DIYFont
//
//  Created by huangqiang on 17/4/1.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "NextController.h"
#import "UIViewController+DIY_VC.h"
@interface NextController ()

@end

@implementation NextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
