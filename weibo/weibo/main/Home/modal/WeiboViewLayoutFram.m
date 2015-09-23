//
//  WeiboViewLayoutFram.m
//  weibo
//
//  Created by 李丹阳 on 15/8/24.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "WeiboViewLayoutFram.h"
#import "WXLabel.h"
#import "RegexKitLite.h"
#import "Utility.h"

@implementation WeiboViewLayoutFram


- (void)setWeiboModel:(WeiboModel *)weiboModel{
    if (_weiboModel!= weiboModel) {
        _weiboModel = weiboModel;
        [self _loadFrame];
//        [self loadEmotions];
    }
}

- (void)_loadFrame{
    
    //根据 weiboModel计算
    
    //1.微博视图的frame
    self.frame = CGRectMake(55, 40, kScreenWidth-70, 0);
    
    //2.微博内容的frame
    //1>计算微博内容的宽度
    CGFloat textWidth = CGRectGetWidth(self.frame)-20;
    
    //2>计算微博内容的高度
    NSString *text = self.weiboModel.text;
    CGFloat textHeight = [WXLabel getTextHeight:15 width:textWidth text:text linespace:5.0];
    
#warning <#message#>
    self.textFrame = CGRectMake(40, 0, textWidth-15, textHeight+10);
    
    //3.原微博的内容frame
    if (self.weiboModel.reWeibo != nil) {
        NSString *reText = self.weiboModel.reWeibo.text;
        
        //1>宽度
        CGFloat reTextWidth = textWidth-20;
        //2>高度
        
        CGFloat textHeight = [WXLabel getTextHeight:14 width:reTextWidth text:reText linespace:5.0];
        
        //3>Y坐标
        CGFloat Y = CGRectGetMaxY(self.textFrame)+10;
        self.srTextFrame = CGRectMake(40, Y, reTextWidth, textHeight);
        
        //4.原微博的图片
        NSString *thumbnailImage = self.weiboModel.reWeibo.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat Y = CGRectGetMaxY(self.srTextFrame)+10;
            CGFloat X = CGRectGetMinX(self.srTextFrame);

            if (self.isComment) {
                self.imageFrame = CGRectMake(X, Y, CGRectGetWidth(self.frame)-20, 170);
            } else {
                self.imageFrame = CGRectMake(X, Y, 80,90);
            }
        }
        
        //4.原微博的背景
        CGFloat bgX = CGRectGetMinX(self.textFrame);
        CGFloat bgY = CGRectGetMaxY(self.textFrame);
        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
        CGFloat bgHeight = CGRectGetMaxY(self.srTextFrame);
        if (thumbnailImage != nil) {
            bgHeight = CGRectGetMaxY(self.imageFrame);
        }
        bgHeight -= CGRectGetMaxY(self.textFrame);
        bgHeight += 10;
        
        self.bgImageFrame = CGRectMake(bgX-5, bgY, bgWidth, bgHeight);
        
    } else {
        //微博图片
        NSString *thumbnailImage = self.weiboModel.thumbnailImage;
        if (thumbnailImage != nil) {
            CGFloat imgX = CGRectGetMinX(self.textFrame);
            CGFloat imgY = CGRectGetMaxY(self.textFrame)+10;

            if (self.isComment) {
                self.imageFrame = CGRectMake(imgX , imgY, CGRectGetWidth(self.frame)-40, 170);
            } else {
                self.imageFrame = CGRectMake(imgX , imgY, 80, 90);
            }
        }
        
    }
    
    //计算微博视图的高度：微博视图最底部子视图的Y坐标
    CGRect f = self.frame;
    if (self.weiboModel.reWeibo != nil) {
        f.size.height = CGRectGetMaxY(_bgImageFrame);
    }
    else if(self.weiboModel.thumbnailImage != nil) {
        f.size.height = CGRectGetMaxY(_imageFrame);
    }
    else {
        f.size.height = CGRectGetMaxY(_textFrame);
    }
    self.frame = f;
}

@end
