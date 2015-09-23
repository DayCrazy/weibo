//
//  HomeTableViewCell.h
//  weibo
//
//  Created by 李丹阳 on 15/8/23.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewLayoutFram.h"
#import "weiboView.h"
#import "ThemeLabel.h"

@interface HomeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet ThemeLabel *userName;
@property (strong, nonatomic) IBOutlet ThemeLabel *createTime;
@property (strong, nonatomic) IBOutlet ThemeLabel *commentNumber;
@property (strong, nonatomic) IBOutlet ThemeLabel *retweeted;
@property (strong, nonatomic) IBOutlet ThemeLabel *soure;


//@property (nonatomic,strong) WeiboModel *model;
@property (nonatomic,strong) WeiboViewLayoutFram * layoutMadel;
@property (nonatomic,strong) weiboView* weiboView;

@end
