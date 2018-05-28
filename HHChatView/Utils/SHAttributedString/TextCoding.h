//
//  TextCoding.h
//  AttributedString
//
//  Created by wangwenke on 16/4/12.
//  Copyright © 2016年 wangwenke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTextCoding : NSObject

//遍历文字内容（如果 replaceString 是从网络请求过来的字符串，请先对其编码）
+ (NSMutableAttributedString *)replaceStringToAttributedString:(NSString *)replaceString;

+ (BOOL)getEMOJIFromString:(NSString *)replaceString;

@end
