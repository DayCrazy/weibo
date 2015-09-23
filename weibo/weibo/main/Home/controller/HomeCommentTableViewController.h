//
//  HomeCommentTableViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/8/28.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewLayoutFram.h"
#import "SinaWeibo.h"

@interface HomeCommentTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate>
@property (strong, nonatomic) WeiboViewLayoutFram* layoutFrame;

@end
