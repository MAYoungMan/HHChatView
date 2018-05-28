//
//  TextCoding.m
//  AttributedString
//
//  Created by wangwenke on 16/4/12.
//  Copyright © 2016年 wangwenke. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TextCoding.h"

//表情包（表情名称）
#define EMOJI     @{@"[委屈]":@"a.png",@"[愤怒]":@"b.png",@"[悲伤]":@"c.png",@"[难过]":@"d.png",@"[面无表情]":@"e.png",@"[冷汗]":@"ee.png",@"[惊讶]":@"f.png",@"[无聊]":@"g.png",@"[生病]":@"h.png",@"[亲我]":@"i.png",@"[笑哭]":@"k.png",@"[天使]":@"l.png",@"[调皮]":@"m.png",@"[大笑]":@"n.png",@"[微笑]":@"o.png",@"[坏笑]":@"p.png",@"[发呆]":@"q.png",@"[眨眼]":@"r.png",@"[满意]":@"s.png",@"[开心]":@"t.png",@"[酷]":@"u.png",@"[亲亲]":@"v.png",@"[色]":@"w.png",@"[瞌睡]":@"x.png",@"[晕]":@"xx.png",@"[流汗]":@"y.png",@"[流泪]":@"yy.png",@"[破涕为笑]":@"z.png",@"[难受]":@"zz.png"}
@interface HHTextCoding()

@end

@implementation HHTextCoding


+ (NSMutableAttributedString *)replaceStringToAttributedString:(NSString *)replaceString{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:replaceString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSParagraphStyleAttributeName:paragraphStyle}];

    //使用正则表达式遍历字符串取出格式为 "[...]" 的字符串
    NSString *pattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [regular matchesInString:attr.string options:NSMatchingReportProgress range:NSMakeRange(0, attr.string.length)];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:0];
    for (NSTextCheckingResult *result in arr) {
        NSString *matchstring = [attr.string substringWithRange:result.range];
        if ([[EMOJI allKeys] containsObject:matchstring]) {
            //将遍历出来的表情文字转化为表情富文本
            NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
            attachment.image = [UIImage imageNamed:EMOJI[matchstring]];
            //设置表情图片大小
            attachment.bounds = CGRectMake(0, -6.0, 25.0, 25.0);

            [imageArr insertObject:attachment atIndex:0];
            [rangeArr insertObject:result atIndex:0];
        }
    }
    
    int i = 0;
    
    //替换表情富文本
    for (NSTextCheckingResult *result in rangeArr) {
        NSTextAttachment *attchment = imageArr[i];
        [attr replaceCharactersInRange:result.range withAttributedString:[NSAttributedString attributedStringWithAttachment:attchment]];
        i++;
    }
    return attr;
}

+ (BOOL)getEMOJIFromString:(NSString *)replaceString{
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:replaceString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
    
    //使用正则表达式遍历字符串取出格式为 "[...]" 的字符串
    NSString *pattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [regular matchesInString:attr.string options:NSMatchingReportProgress range:NSMakeRange(0, attr.string.length)];
    for (NSTextCheckingResult *result in arr) {
        NSString *matchstring = [attr.string substringWithRange:result.range];
        if ([[EMOJI allKeys] containsObject:matchstring]) {
            return YES;
        }
    }
    
    return NO;
}



@end
