//
//  HHMessageModel.m
//  HHChatView
//
//  Created by Sherlock on 2018/5/25.
//  Copyright © 2018 daHuiGe. All rights reserved.
//

#import "HHMessageModel.h"

@implementation HHMessageModel

+(instancetype)messageWithDict:(NSDictionary *)dict
{
    HHMessageModel * message = [[self alloc]init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}


@end
