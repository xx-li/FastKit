//
//  UIControl+FastKit.h
//  PEPatient
//
//  Created by 李新星 on 16/3/22.
//  Copyright © 2016年 EEGSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FKControlBlock)(UIControl* control);


@interface UIControl (FastKit)

- (void)fk_addAction:(FKControlBlock)block;
- (void)fk_addAction:(FKControlBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end
