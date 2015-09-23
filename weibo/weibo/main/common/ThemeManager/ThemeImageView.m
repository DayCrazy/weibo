//
//  ThemeImageView.m
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView



- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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

- (void)setImageName:(NSString *)imageName{
    if (![_imageName isEqualToString:imageName]) {
        _imageName = [imageName copy];
        [self loadImage];
    }
}

- (void)loadImage{
    ThemeManager* manager = [ThemeManager ShareInstance];
    UIImage* image = [manager getThemeImage:_imageName];
    
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
    
    [self setImage:image];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
