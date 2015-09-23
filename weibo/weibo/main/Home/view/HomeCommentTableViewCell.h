//
//  HomeCommentTableViewCell.h
//  weibo
//
//  Created by 李丹阳 on 15/8/28.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLabel.h"
#import "WXLabel.h"
#import "commentModel.h"

@interface HomeCommentTableViewCell : UITableViewCell<WXLabelDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet ThemeLabel *name;
@property (strong, nonatomic) IBOutlet WXLabel *comment;
@property (strong, nonatomic) commentModel* model;

+ (float)getCommentHeight:(commentModel *)commentModel ;

@end
