//
//  HHMessageCell.h
//  HHChatView
//
//  Created by Sherlock on 2018/5/25.
//  Copyright © 2018 daHuiGe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHMessageModel.h"

@interface HHMessageCell : UITableViewCell

/** 模型  */
@property(nonatomic,strong)HHMessageModel * message;

@end
