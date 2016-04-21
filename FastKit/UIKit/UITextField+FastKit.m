//
//  UITextField+FastKit.m
//  PEPatient
//
//  Created by 李新星 on 16/4/18.
//  Copyright © 2016年 EEGSmart. All rights reserved.
//

#import "UITextField+FastKit.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (copy, nonatomic) FKBeyondLimits beyondLimit;
@property (assign, nonatomic) NSUInteger maxLimitLength;
@property (assign, nonatomic) BOOL isAdaptive;

@end


@implementation UITextField (FastKit)


#pragma mark - Setter and getter
- (void)setMaxLimitLength:(NSUInteger)maxLimitLength {
    if (self.maxLimitLength == maxLimitLength) {
        return;
    }
    objc_setAssociatedObject(self, @selector(maxLimitLength), [NSNumber numberWithUnsignedInteger:maxLimitLength], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSUInteger)maxLimitLength {
    NSNumber * result = objc_getAssociatedObject(self, @selector(maxLimitLength));
    return [result unsignedIntegerValue];
}

- (void)setIsAdaptive:(BOOL)isAdaptive {
    if (self.isAdaptive == isAdaptive) {
        return;
    }
    objc_setAssociatedObject(self, @selector(isAdaptive), [NSNumber numberWithBool:isAdaptive], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)isAdaptive {
    NSNumber *result = objc_getAssociatedObject(self, @selector(isAdaptive));
    return [result boolValue];
}

- (void)setBeyondLimit:(FKBeyondLimits)beyondLimit {
    //将之前的置为nil
    objc_setAssociatedObject(self, @selector(beyondLimit), nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //设为新值
    objc_setAssociatedObject(self, @selector(beyondLimit), beyondLimit, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (FKBeyondLimits)beyondLimit {
    return objc_getAssociatedObject(self, @selector(beyondLimit));
}

#pragma mark - Public method
- (void) limitTextMaxtLength:(NSInteger)maxLimitLength adaptationForCoding:(BOOL)isAdaptive beyondLimits:(FKBeyondLimits)beyondLimits {
    self.beyondLimit = beyondLimits;
    self.isAdaptive = isAdaptive;
    self.maxLimitLength = self.isAdaptive ? maxLimitLength * 3 : maxLimitLength;
    [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Private method
- (void)textFieldEditChanged:(UITextField *)textField
{
    NSString * oldText = textField.text;
    if (self.isAdaptive) {
        if(textField.markedTextRange == nil && [self textLengthFromString:oldText] > self.maxLimitLength)
        {
            NSString *content = [self string:oldText subStrWithUtf8Len:self.maxLimitLength];
            textField.text = content;
        }
    }
    else {
        if(textField.markedTextRange == nil && oldText.length > self.maxLimitLength)
        {
            NSString *content = [oldText substringToIndex:self.maxLimitLength];
            textField.text = content;
        }
    }
    
    if (![oldText isEqualToString:textField.text]) {
        if (self.beyondLimit) {
            self.beyondLimit(oldText);
        }
    }
}

- (NSUInteger)textLengthFromString:(NSString *)string
{
    return [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}


//test测试   9
- (NSString *)string:(NSString *)string subStrWithUtf8Len:(NSUInteger)maxLen
{
    int strlen = 0;
    NSUInteger len = [string length];
    int i= 0;
    for(i= 0; i< maxLen ; i++) {
        if(i< len) {
            unichar wchar = [string characterAtIndex:i];
            //单字节 与 ASCII兼容
            if(wchar <= 127) {
                strlen++;
            }
            //多字节，绝大部分是三个字节，也可能是2或者4字节
            else {
                strlen += 3;
            }
            if(strlen > maxLen) {
                break;
            }
        } else {
            break;
        }
    }
    if(i <= 0) {
        return string;
    }
    NSString * str = [string substringWithRange:NSMakeRange(0,i)];
    
    NSString *s = @"\U0001F30D"; // earth globe emoji 🌍
    NSLog(@"The length of %@ is %lu", s, [s length]);
    
    NSString *s1 = @"e\u0301"; // e + ´
    NSLog(@"The length of %@ is %lu", s1, [s1 length]);
    
    return str;
}


//11110000 11100000 11000000 10000000

@end
