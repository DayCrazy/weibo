//
//  common.h
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#ifndef weibo_common_h
#define weibo_common_h
//#import "UIViewExt.h"

//屏幕的宽、高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define kAppKey             @"1103405017"
#define kAppSecret          @"3a052c7e806c46cf29a2cb5930c48ac7"
#define kAppRedirectURI     @"http://www.baidu.com"
#define unread_count        @"remind/unread_count.json"  //未读消息
#define home_timeline       @"statuses/home_timeline.json"  //微博列表
#define comments            @"comments/show.json"   //评论列表
//#define BaseUrl  @"https://api.weibo.com"
#define SendImage @"statuses/upload.json"//发一条带图片的微博
#define senfWeibo @"statuses/update.json"//发一条微博
#define homeLiset @"statuses/home_timeline.json"
#define geo_to_address @"location/geo/geo_to_address.json"
#define profileUrl @"https://api.weibo.com/2/users/show.json"
#define BaseUrl @"https://api.weibo.com/2/"

#define kVersion  [[UIDevice currentDevice].systemVersion floatValue]


#endif
