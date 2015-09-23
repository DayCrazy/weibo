//
//  ThemeButton.m
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

- (void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
}

- (void)themeDidChangeAction:(NSNotification*)notification{
    [self loadImage]; 
}

- (void)setNormalImgName:(NSString *)normalImgName{
    if (![_normalImgName isEqualToString:normalImgName]) {
        _normalImgName = [normalImgName copy];
        [self loadImage];
    }
}

- (void)setNormalBgImgName:(NSString *)normalBgImgName{
    if (![_normalBgImgName isEqualToString:normalBgImgName]) {
        _normalBgImgName = [normalBgImgName copy];
        [self loadImage];
    }
}

//- (void)setHighLightImgName:(NSString *)highLightImgName{
//    if (![highLightImgName isEqualToString:highLightImgName]) {
//        _highLightImgName = [highLightImgName copy];
//        [self loadImage];
//    }
//}

- (void)loadImage{
    ThemeManager* manager = [ThemeManager ShareInstance];
    UIImage* normalImage = [manager getThemeImage:self.normalImgName];
    [self setImage:normalImage forState:UIControlStateNormal];
//    
    UIImage* normalBgImage = [manager getThemeImage:self.normalBgImgName];
    [self setBackgroundImage:normalBgImage forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
