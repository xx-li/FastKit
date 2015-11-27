//
//  UILabel+FastKit.h
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FastKit)

-(void)setText:(NSString *)text
          font:(UIFont *)font
         color:(UIColor *)color;

/**
 *  将关键字设定为制定的颜色和字体
 *
 *  @param keyWords     关键字列表
 *  @param keyWordfont  字体
 *  @param keyWordColor 颜色
 */
-(void)setKeyWords:(NSArray *)keyWords
              font:(UIFont *)keyWordfont
             color:(UIColor *)keyWordColor;

@end
