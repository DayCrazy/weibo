//
//  weiboAnnotationPerson.m
//  weibo
//
//  Created by 李丹阳 on 15/9/5.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "weiboAnnotationPerson.h"
#import "weiboAnnotation.h"

@implementation weiboAnnotationPerson

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
    
    _userName = [[UILabel alloc]initWithFrame:CGRectZero];
    _userName.backgroundColor = [ UIColor whiteColor];
    _userName.textColor = [UIColor blackColor];
    _userName.numberOfLines = 3;
    _userName.font = [UIFont systemFontOfSize:13];
    [self addSubview:_userName];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headView .frame = CGRectMake(2, 2, 40, 40);
    _userName.frame = CGRectMake(0, 43, 70, 21);
    
    
    weiboAnnotation* ann = self.annotation;
    WeiboModel* model = ann.model;
    if (model.userModel.profile_image_url) {
        [_headView sd_setImageWithURL:[NSURL URLWithString:model.userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_picture@2x"]];
    }
    _userName.text = model.userModel.screen_name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
