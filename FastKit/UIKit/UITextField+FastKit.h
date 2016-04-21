//
//  UITextField+FastKit.h
//  PEPatient
//
//  Created by 李新星 on 16/4/18.
//  Copyright © 2016年 EEGSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FKBeyondLimits) (NSString * beyondText);

@interface UITextField (FastKit)


/**
*  设定Text文本内容的最大长度
*
*  @param maxLimitLength 最大长度
*  @param isAdaptive     是否针对不同的编码进行适配，一个中文字符相当于了三个英文字符
*  @param beyondLimits   超出了长度的回调
*/
- (void) limitTextMaxtLength:(NSInteger)maxLimitLength adaptationForCoding:(BOOL)isAdaptive beyondLimits:(FKBeyondLimits)beyondLimits;


@end
