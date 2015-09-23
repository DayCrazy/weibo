//
//  weiboView.m
//  weibo
//
//  Created by 李丹阳 on 15/8/24.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "weiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "WXLabel.h"
#import "ThemeManager.h"
#import "Utility.h"
#import "RegexKitLite.h"

@implementation weiboView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubview];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

- (void)_createSubview{
    
    _bgImgView = [[ThemeImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_bgImgView];
    
    _weiboText = [[WXLabel alloc]initWithFrame:CGRectZero];
    _weiboText.linespace = 5;
    _weiboText.font = [UIFont systemFontOfSize:15];
    _weiboText.wxLabelDelegate = self;

    [self addSubview:_weiboText];
    
    _sourceText = [[WXLabel alloc]initWithFrame:CGRectZero];
    _sourceText.font = [UIFont systemFontOfSize:14];
    _sourceText.wxLabelDelegate = self;

    _sourceText.linespace = 5;
    [self addSubview:_sourceText];
    
    _imgView = [[ZoomImageView alloc]initWithFrame:CGRectZero];
//    _imgView.urlString = _layoutFrame.weiboModel.originalImage;
    [self addSubview:_imgView];
    
    
    _bgImgView.leftCapWidth = 25;
    _bgImgView.topCapWidth = 25;
    _bgImgView.imageName = @"timeline_rt_border_9.png";
    
    [self themeDidChangeAction];
    
}

- (void)themeDidChangeAction{
 
    _weiboText.textColor = [[ThemeManager ShareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceText.textColor = [[ThemeManager ShareInstance]getThemeColor:@"Timeline_Retweet_color"];

    
}

- (void)setLayoutFrame:(WeiboViewLayoutFram *)layoutFrame{
    if (_layoutFrame!= layoutFrame) {
        _layoutFrame = layoutFrame;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    
    WeiboModel* weiboModel = self.layoutFrame.weiboModel;
    _weiboText.frame = self.layoutFrame.textFrame;
    _weiboText.text = self.layoutFrame.weiboModel.text;
    
    _sourceText.frame = self.layoutFrame.srTextFrame;
    NSString* reImageURl = weiboModel.reWeibo.thumbnailImage;
    NSString* imageUrl = weiboModel.thumbnailImage;
    
    if (weiboModel.reWeibo!= nil) {
        self.bgImgView.hidden = NO;
        self.sourceText.hidden = NO;
        
        self.sourceText.text = [NSString stringWithFormat:@"@%@:%@",weiboModel.reWeibo.userModel.name,weiboModel.reWeibo.text];
        self.sourceText.frame = self.layoutFrame.srTextFrame;
        self.bgImgView.frame = self.layoutFrame.bgImageFrame;
        self.bgImgView.imageName = @"timeline_rt_border_9.png";
        
        
        if (reImageURl!= nil) {
            self.imgView.hidden = NO;
            self.imgView.backgroundColor = [UIColor redColor];
            self.imgView.frame = self.layoutFrame.imageFrame;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:reImageURl]];
            self.imgView.urlString = _layoutFrame.weiboModel.reWeibo.originalImage;
        }else{
            self.imgView.hidden = YES;
        }
    }
    else{
        self.bgImgView.hidden = YES;
        self.sourceText.hidden = YES;
        
        if (imageUrl == nil) {
            self.imgView.hidden = YES;
        }
        else{
            self.imgView.hidden = NO;
            self.imgView.frame = self.layoutFrame.imageFrame;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            self.imgView.urlString = _layoutFrame.weiboModel.originalImage;
        }
    }

    
    if (self.imgView!= nil) {
        UIImageView* iconImageView = self.imgView.iconImage;
        iconImageView.frame = CGRectMake(_imgView.width-24, _imgView.height-15, 24, 15);
        
        //判断是否是gif图
        NSString* extension = [self.layoutFrame.weiboModel.thumbnailImage pathExtension];
        if ([extension isEqualToString:@"gif"]) {
            iconImageView.hidden = NO;
            
        }
        else {
            iconImageView.hidden = YES;
        }
    }

}

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{

    return  [[ThemeManager ShareInstance]getThemeColor:@"Link_color"];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    return [UIColor blueColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
