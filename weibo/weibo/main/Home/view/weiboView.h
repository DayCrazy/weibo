//
//  weiboView.h
//  weibo
//
//  Created by 李丹阳 on 15/8/24.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLayoutFram.h"
#import "WXLabel.h"
#import "ZoomImageView.h"

/*UIImageView 改为自定义，添加点击手势，点击一次，创建SCrollView，将原图片隐藏，添加新图片SCrollView上，并放大
 再点击一次，原图显示，removeFromSuperView;
 */

@interface weiboView : UIView<WXLabelDelegate>
@property (nonatomic,strong) WXLabel* weiboText;  //微博
@property (nonatomic,strong) WXLabel* sourceText; // 转发的微博
@property (nonatomic,strong) ZoomImageView* imgView;  // 微博里的图片
@property (nonatomic,strong) ThemeImageView* bgImgView;   // 
@property (nonatomic,strong) WeiboViewLayoutFram* layoutFrame;


@end
