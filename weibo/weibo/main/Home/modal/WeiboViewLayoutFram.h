//
//  WeiboViewLayoutFram.h
//  weibo
//
//  Created by 李丹阳 on 15/8/24.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface WeiboViewLayoutFram : NSObject
@property (nonatomic,assign) CGRect textFrame;//微博内容的fram
@property (nonatomic,assign) CGRect srTextFrame;//原微博内容的fram
@property (nonatomic,assign) CGRect bgImageFrame;//背景图片的fram
@property (nonatomic,assign) CGRect imageFrame;//微博图片的fram
@property (nonatomic,assign) CGRect frame;//整个weiboView的fram

@property (nonatomic,assign) BOOL isComment;

@property (nonatomic,strong) WeiboModel* weiboModel;

@end
