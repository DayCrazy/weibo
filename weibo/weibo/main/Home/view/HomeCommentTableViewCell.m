//
//  HomeCommentTableViewCell.m
//  weibo
//
//  Created by 李丹阳 on 15/8/28.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "HomeCommentTableViewCell.h"
#import "WXLabel.h"
#import "ThemeManager.h"

@implementation HomeCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _comment = [[WXLabel alloc] initWithFrame:CGRectZero];
        _comment.font = [UIFont systemFontOfSize:14.0f];
        _comment.linespace = 5;
        _comment.wxLabelDelegate = self;
        [self.contentView addSubview:_comment];
        

    }
    return self;
}


//- (void)setModel:(commentModel *)model{
//    if (_model!= model) {
//        _model = model;
//        [_iconImage sd_setImageWithURL:[NSURL URLWithString:_model.iconStr]];
//
//        _name.text = _model.commentName;
//        _name.font = [UIFont systemFontOfSize:17];
//        _name.lableName = @"Timeline_Name_color";
//    
//        
//        _comment.text = _model.commentText;
//        _comment.font = [UIFont systemFontOfSize:15];
//        _comment.textColor = [[ThemeManager ShareInstance] getThemeColor:@"Timeline_Content_color"];
//        _comment.wxLabelDelegate = self;
//        
//        CGFloat height = [WXLabel getTextHeight:14.0f
//                                          width:(kScreenWidth-70)
//                                           text:_model.commentText
//                                      linespace:5];
//        
//        
//        
//        
//        _comment.frame = CGRectMake(_iconImage.right+10, _name.bottom+5, kScreenWidth-70, height);
//        
//    }
//}
//

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:_model.iconStr]];
    
    _name.text = _model.commentName;
    _name.font = [UIFont systemFontOfSize:17];
    _name.lableName = @"Timeline_Name_color";
    
    
    _comment.text = _model.commentText;
    _comment.font = [UIFont systemFontOfSize:15];
    _comment.textColor = [[ThemeManager ShareInstance] getThemeColor:@"Timeline_Content_color"];
    _comment.wxLabelDelegate = self;
    
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:(kScreenWidth-70)
                                       text:_model.commentText
                                  linespace:5];
    
    
    
    
    _comment.frame = CGRectMake(_iconImage.right+10, _name.bottom+5, kScreenWidth-70, height);
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

+ (float)getCommentHeight:(commentModel *)commentModel {
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:kScreenWidth-70
                                       text:commentModel.commentText
                                  linespace:5];
    
    return height+40;
}



@end
