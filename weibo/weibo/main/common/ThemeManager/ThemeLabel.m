//
//  ThemeLabel.m
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel



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

- (void)setLableName:(NSString *)lableName{
    if (![_lableName isEqualToString:lableName]) {
        _lableName = [lableName copy];
    }
    [self loadImage];
}


- (void)loadImage{
    ThemeManager* manager = [ThemeManager ShareInstance];
    UIColor* color = [manager getThemeColor:self.lableName];
    self.textColor = color;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
