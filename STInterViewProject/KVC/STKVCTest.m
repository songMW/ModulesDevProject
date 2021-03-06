//
//  STKVCTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/19.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STKVCTest.h"
#import "STKVCModel.h"

@implementation STKVCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        STKVCModel *model = [[STKVCModel alloc]init];
        [model addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
        [model setValue:@(100) forKey:@"age"];
        NSLog(@"%@", [model valueForKey:@"age"]);
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"age"]) {
        NSLog(@"observeValueForKeyPath");
    }
}

@end
