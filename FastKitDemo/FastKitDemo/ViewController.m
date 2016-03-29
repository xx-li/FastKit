//
//  ViewController.m
//  FastKitDemo
//
//  Created by 李新星 on 15/11/25.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import "ViewController.h"
#import "NSTimer+FastKit.h"

@interface ViewController ()

@property (weak, nonatomic) NSTimer * timer1;
@property (weak, nonatomic) NSTimer * timer2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.timer1 = [NSTimer fk_scheduledTimerWithTimeInterval:1 block:^(id userInfo) {
        NSLog(@"timer1");
    } userInfo:nil repeats:YES];
    
    self.timer2 = [NSTimer fk_scheduledTimerWithTimeInterval:1 target:self selector:@selector(test:) userInfo:nil repeats:YES];
    
    [NSTimer fk_scheduledTimerWithTimeInterval:1 block:^(id userInfo) {
        
    } userInfo:nil repeats:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timer1 invalidate];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timer2 invalidate];
    });
    
    __weak __typeof__ (self) wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@ %@", wself.timer1 , wself.timer2);
    });
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test1:) userInfo:@(1) repeats:YES];
    
}

- (void)test:(id)w {
    NSLog(@"timer2 %@", w);
}

- (void)test1:(id)w {
    NSLog(@"%@", w);
}

@end
