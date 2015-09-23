//
//  ProfileViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeLabel.h"
//#import "WeiboModel.h"
#import "weiboView.h"
#import "WeiboViewLayoutFram.h"
#import "ThemeButton.h"
#import "SinaWeiboRequest.h"

@interface ProfileViewController : BaseViewController<SinaWeiboRequestDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;//用户头像
@property (strong, nonatomic) IBOutlet ThemeLabel *NameLabel;//用户名
@property (strong, nonatomic) IBOutlet ThemeLabel *oweDescription;//用户描述
@property (strong, nonatomic) ThemeButton* weiboNumber;//已发微博数量
@property (strong, nonatomic) ThemeButton* fansNumber;//粉丝数
@property (strong, nonatomic) ThemeButton* friendsNumber;//关注数


@property (strong, nonatomic) WeiboModel* model;
@property (strong, nonatomic)WeiboViewLayoutFram* layoutFrame;

@end
