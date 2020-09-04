//
//  NSTimer+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSTimer+KK.h"

@implementation NSTimer (KK)

- (void)start
{
    [self setFireDate:[NSDate distantPast]];
}

- (void)pause
{
    [self setFireDate:[NSDate distantFuture]];
}

- (void)close
{
    [self setFireDate:[NSDate distantFuture]];
    [self invalidate];
}

+ (NSTimer *)kk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo inMainThread:(BOOL)inMainThread
{
    if (inMainThread && ![NSThread isMainThread])
    {
        NSTimer *timer =
        [self timerWithTimeInterval:interval
                             target:aTarget
                           selector:aSelector
                           userInfo:nil
                            repeats:yesOrNo];
        
        [[NSRunLoop mainRunLoop] addTimer:timer
                                  forMode:NSDefaultRunLoopMode];
        
        return timer;
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:aTarget
                                       selector:aSelector
                                       userInfo:nil
                                        repeats:yesOrNo];
}

+ (NSTimer *)kk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block
{
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(kk_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)kk_blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
