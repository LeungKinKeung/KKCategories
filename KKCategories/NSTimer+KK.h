//
//  NSTimer+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (KK)

/// 启动
- (void)start;
/// 暂停
- (void)pause;
/// 关闭
- (void)close;

/// 定时器
/// @param interval 时间间隔（秒）
/// @param aTarget 目标对象
/// @param aSelector 目标方法
/// @param yesOrNo 是否重复执行
/// @param inMainThread 在主线程运行
+ (NSTimer *)kk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo inMainThread:(BOOL)inMainThread;

/// 定时器
/// @param interval 时间间隔（秒）
/// @param repeats 是否重复执行
/// @param block 执行代码块
+ (NSTimer *)kk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end
