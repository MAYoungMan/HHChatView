//
//  HHMessageCell.m
//  HHChatView
//
//  Created by Sherlock on 2018/5/25.
//  Copyright © 2018 daHuiGe. All rights reserved.
//

#import "HHMessageCell.h"
#import "Masonry.h"
#import "TextCoding.h"

@interface HHMessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelTopMargin;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *otherIconImage;
@property (weak, nonatomic) IBOutlet UIButton *otherContentLabel;

@end

@implementation HHMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLabel.titleLabel.numberOfLines = 0;
    self.otherContentLabel.titleLabel.numberOfLines = 0;
}

-(void)setMessage:(HHMessageModel *)message
{
    _message = message;
    //    if (message.hiddenTime) {
    //        self.timeLabel.hidden = YES;
    //    }else{
    //        self.timeLabel.hidden = NO;
    //    }
    //隐藏timeLabel
    self.timeLabel.hidden = message.isHiddenTime;
    //改变timeLabel的高度
    if (message.hiddenTime) {
        self.timeLabelHeight.constant = 0;
        self.timeLabelTopMargin.constant = 0;
    }else{
        self.timeLabelHeight.constant = 15;
        self.timeLabelTopMargin.constant = 10;
    }
    [self.timeLabel layoutIfNeeded];
    
    self.timeLabel.text = message.time;
    if (message.type == HHMessageTypeMe) {//自己
        [self settingShowContent:self.contentLabel showIcon:self.iconImage hiddenConten:self.otherContentLabel hiddenIcon:self.otherIconImage];
    }else{
        [self settingShowContent:self.otherContentLabel showIcon:self.otherIconImage hiddenConten:self.contentLabel hiddenIcon:self.iconImage];
    }
}


-(void)settingShowContent:(UIButton *)showContent showIcon:(UIImageView *)showIcon hiddenConten:(UIButton *)hiddenConten hiddenIcon:(UIImageView *)hiddenIcon
{
    //显示
    showContent.hidden = NO;
    showIcon.hidden = NO;
    //隐藏
    hiddenConten.hidden = YES;
    hiddenIcon.hidden = YES;
    
    NSAttributedString *myStr = [HHTextCoding replaceStringToAttributedString:self.message.text];
    
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc]initWithAttributedString:myStr];
    [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,newStr.length)];
    
    //====================设置显示===================
    [showContent setAttributedTitle:newStr forState:UIControlStateNormal];
    //从新布局
    [showContent layoutIfNeeded];
    
    CGSize size = [newStr boundingRectWithSize:CGSizeMake(208, 30000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            
    [showContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width + 42);
        make.height.mas_equalTo(size.height + 42);
    }];

    [showContent layoutIfNeeded];
    //计算高度 20/35
        
    //头像的Y值最大(有无时间)
    CGFloat maxiConYWithNoTime = 20 + 56 + 10;
    CGFloat maxiConYWithTime = 35 + 56 +10;
    //内容的Y值最大(有无时间)
    CGFloat maxlabelYWithNoTime = 20 + 5 + size.height + 42 + 10;
    CGFloat maxlabelYWithTime = 35 + 5 + size.height + 42 + 10;
    
    CGFloat iconImageMaxY = self.message.isHiddenTime == true ? maxiConYWithNoTime : maxiConYWithTime;
    
    CGFloat contentLabelMaxY = self.message.isHiddenTime == true ? maxlabelYWithNoTime : maxlabelYWithTime;
    
    self.message.cellHeight = MAX(iconImageMaxY, contentLabelMaxY);
    
}

@end
