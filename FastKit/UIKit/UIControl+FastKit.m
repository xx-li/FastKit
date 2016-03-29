//
//  UIControl+FastKit.m
//  PEPatient
//
//  Created by 李新星 on 16/3/22.
//  Copyright © 2016年 EEGSmart. All rights reserved.
//

#import "UIControl+FastKit.h"
#import <objc/runtime.h>

@implementation UIControl (FastKit)

- (void)fk_addAction:(FKControlBlock)block
{
    objc_setAssociatedObject(self, @selector(fk_addAction:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)fk_addAction:(FKControlBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, @selector(fk_addAction:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    FKControlBlock blockAction = (FKControlBlock)objc_getAssociatedObject(self, @selector(fk_addAction:));
    if (blockAction)
    {
        blockAction(self);
    }
}


@end
