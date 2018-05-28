//
//  HHMessageModel.h
//  HHChatView
//
//  Created by Sherlock on 2018/5/25.
//  Copyright © 2018 daHuiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HHMessageType) {
    HHMessageTypeMe = 0,
    HHMessageTypeOther = 1
};

@interface HHMessageModel : NSObject
/** cell高度 */
@property(assign,nonatomic)CGFloat cellHeight;
/** 聊天内容 */
@property(copy,nonatomic)NSString * text;
/** 时间 */
@property(copy,nonatomic)NSString * time;
/** 类型 */
@property(assign,nonatomic)HHMessageType type;
/** 隐藏time */
@property(assign,nonatomic,getter=isHiddenTime)BOOL hiddenTime;

+(instancetype)messageWithDict:(NSDictionary *)dict;

@end
