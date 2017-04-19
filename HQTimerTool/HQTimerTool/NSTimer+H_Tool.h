//
//  NSTimer+H_Tool.h
//  HQTimerTool
//
//  Created by huangqiang on 17/4/19.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TimerBlock)(id);
@interface NSTimer (H_Tool)
+ (NSTimer *)hTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target timerBlock:(TimerBlock)timerBlock;
@end
