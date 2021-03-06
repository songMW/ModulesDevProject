//
//  STTimerTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STTimerTest.h"
#import <UIKit/UIKit.h>
#import "STProxy.h"
#import "STTimer.h"

@interface STTimerTest ()

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) dispatch_source_t cgdTimer;
@property(nonatomic,strong) CADisplayLink *displayLink;

@end

@implementation STTimerTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testTimerLocal];
    }
    return self;
}

- (void)testTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[STProxy proxyWithTarget:self] selector:@selector(timerPrint) userInfo:nil repeats:true];
}

- (void)testTimerLocal {
    STTimer *newTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerPrintLocal) userInfo:nil repeats:true];
//    [NSRunLoop.currentRunLoop addTimer:newTimer forMode:NSRunLoopCommonModes];
//    [newTimer fire];
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerPrintLocal) userInfo:nil repeats:true];
}

- (void)timerPrint {
    NSLog(@"%s", __func__);
}

- (void)timerPrintLocal {
    NSLog(@"%s", __func__);
}

- (void)testDisplayLink {
    // 保证调用评论和屏幕刷新帧率一致，60FPS
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkPrint)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
}

- (void)displayLinkPrint {
    
    NSLog(@"%s", __func__);
}

- (void)testGCD {
    dispatch_queue_t serialQueue = dispatch_queue_create("testGCD", DISPATCH_QUEUE_SERIAL);
    self.cgdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, serialQueue);
    dispatch_source_set_timer(self.cgdTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.cgdTimer, ^{
        NSLog(@"testGCD");
    });
    dispatch_resume(self.cgdTimer);
}

- (void)testAsyncTimer {
    
}

- (void)dealloc
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    
    NSLog(@"%@-%s", NSStringFromClass(self.class), __func__);
}

@end
