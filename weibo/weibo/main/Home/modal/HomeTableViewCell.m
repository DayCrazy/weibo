//
//  HomeTableViewCell.m
//  weibo
//
//  Created by 李丹阳 on 15/8/23.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Utills.h"
#import "weiboView.h"
#import "ThemeManager.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
//    self.backgroundColor = [UIColor clearColor];
    // Initialization code
    
    self.weiboView = [[weiboView alloc]initWithFrame:CGRectZero];
//    self.weiboView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.weiboView];
//    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLayoutMadel:(WeiboViewLayoutFram *)layoutMadel{
    if (_layoutMadel!= layoutMadel) {
        _layoutMadel = layoutMadel;
        [self setNeedsLayout];
    }
}

- (void)themeDidChangeAction{
    self.userName.textColor = [[ThemeManager ShareInstance]getThemeColor:@"Timeline_Name_color"];
    self.createTime.textColor = [[ThemeManager ShareInstance] getThemeColor:@"Timeline_Time_color"];
    self.commentNumber.textColor = [[ThemeManager ShareInstance]getThemeColor:@"Timeline_Name_color"];
    self.retweeted.textColor = [[ThemeManager ShareInstance]getThemeColor:@"Timeline_Name_color"];
    self.soure.textColor = [[ThemeManager ShareInstance]getThemeColor:@"Timeline_Time_color"];
}



-(void)layoutSubviews{
//    [self layoutSubviews];
    [super layoutSubviews];
    
    self.weiboView.layoutFrame = self.layoutMadel;
    WeiboModel* modal = self.layoutMadel.weiboModel;
    
    self.weiboView.frame = self.layoutMadel.frame;
    
    NSString* urlStr = modal.userModel.profile_image_url;
    
    [self.headImageView  sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.commentNumber.text = [NSString stringWithFormat:@"评论%@",modal.commentsCount];
    
    self.retweeted.text = [NSString stringWithFormat:@"转发%@",modal.repostsCount];
    
    self.userName.text = modal.userModel.screen_name;
    
    
    self.createTime.text = [Utills getStingWithDateSting:modal.createDate withFormatterString:@"EEE MMM dd HH:mm:ss Z yyyy" withInputString:@"MM月dd日 HH:mm"];
    self.soure.text = modal.source;
    
    self.userName.lableName = @"Timeline_Name_color";
    self.createTime.lableName = @"Timeline_Time_color";
    self.commentNumber.lableName = @"Timeline_Name_color";
    self.retweeted.lableName = @"Timeline_Name_color";
    self.soure.lableName = @"Timeline_Time_color";
    
//    [self themeDidChangeAction];
    
}




@end
