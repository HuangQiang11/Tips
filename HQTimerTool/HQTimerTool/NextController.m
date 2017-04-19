//
//  NextController.m
//  HQTimerTool
//
//  Created by huangqiang on 17/4/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "NextController.h"
#import "NSTimer+H_Tool.h"
@interface NextController ()

@end

@implementation NextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) welfSelf = self;
    [NSTimer hTimerWithTimeInterval:1.0f repeats:YES target:self timerBlock:^(id sender){
        NSLog(@"timer:%@ ",welfSelf);
    }];
}

- (void)dealloc{
    NSLog(@"next dealloc");
}

@end
