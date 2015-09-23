//
//  moreTableViewCell.m
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "moreTableViewCell.h"
#import "ThemeManager.h"

@implementation moreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
        [self themeChangeAction];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}


- (void)themeChangeAction{
    
    self.backgroundColor =
    [[ThemeManager ShareInstance]getThemeColor:@"More_Item_color"];

}


- (void)createSubView{
    _logoImage = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    _titleLabel = [[ThemeLabel alloc]initWithFrame:CGRectMake(40, 5, 200, 30)];
    _themeName = [[ThemeLabel alloc]initWithFrame:CGRectMake(230, 5, 100, 30)];
    
    
    _titleLabel.lableName = @"More_Item_Text_color";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    _themeName.lableName = @"More_Item_Text_color";
    _themeName.textAlignment = NSTextAlignmentRight;
    _themeName.font = [UIFont systemFontOfSize:16];
    _themeName.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:_logoImage];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_themeName];
    
    

}






@end
