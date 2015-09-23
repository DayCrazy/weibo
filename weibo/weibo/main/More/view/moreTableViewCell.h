//
//  moreTableViewCell.h
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLabel.h"
#import "ThemeImageView.h"


@interface moreTableViewCell : UITableViewCell

@property (nonatomic,strong) ThemeImageView* logoImage;
@property (nonatomic,strong) ThemeLabel* titleLabel;
@property (nonatomic,strong) ThemeLabel* themeName;
@end
