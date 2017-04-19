//
//  NSTimer+H_Tool.m
//  HQTimerTool
//
//  Created by huangqiang on 17/4/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "NSTimer+H_Tool.h"

@implementation NSTimer (H_Tool)
+ (NSTimer *)hTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target timerBlock:(TimerBlock)timerBlock{
    __weak typeof(target) weakTarget = target;
    TimerBlock block = ^(NSTimer * t){
        if (weakTarget) {
            timerBlock(nil);
        }else{
            [t invalidate];
        }
    };
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerAction:) userInfo:[block copy] repeats:repeats];
    return timer;
}

+ (void)timerAction:(NSTimer *)timer{
    TimerBlock block = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
