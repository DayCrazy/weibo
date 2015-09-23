//
//  commentModel.h
//  weibo
//
//  Created by 李丹阳 on 15/8/28.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userModel.h"
#import "WeiboModel.h"

@interface commentModel : NSObject

@property (nonatomic,strong) NSString* commentText;
@property (nonatomic,strong) NSString* iconStr;
@property (nonatomic,strong) NSString* commentName;
@property(nonatomic,copy)NSString *idstr;


@property(nonatomic,retain)userModel *user;
@property(nonatomic,retain)WeiboModel *weibo;
@property(nonatomic,retain)commentModel *sourceComment; //源评论

@end
