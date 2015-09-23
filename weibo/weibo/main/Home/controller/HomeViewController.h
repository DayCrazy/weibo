//
//  HomeViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"

@interface HomeViewController : BaseViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate>

@property(nonatomic,strong) NSMutableArray* data;

@end
