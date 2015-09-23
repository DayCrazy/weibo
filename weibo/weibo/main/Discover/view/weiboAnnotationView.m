//
//  weiboAnnotationView.m
//  weibo
//
//  Created by 李丹阳 on 15/9/2.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "weiboAnnotationView.h"
#import "weiboAnnotation.h"
#import "WeiboModel.h"


@implementation weiboAnnotationView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;
}

- (void)_createSubView{
    _headView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_headView];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _textLabel.backgroundColor = [ UIColor whiteColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.numberOfLines = 3;
    _textLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_textLabel];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headView .frame = CGRectMake(8, 10, 36, 36);
    _textLabel.frame = CGRectMake(48, 10, 108, 36);

    
    weiboAnnotation* ann = self.annotation;
    WeiboModel* model = ann.model;
    if (model.userModel.profile_image_url) {
        [_headView sd_setImageWithURL:[NSURL URLWithString:model.userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_picture@2x"]];
    }
    _textLabel.text = model.text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
