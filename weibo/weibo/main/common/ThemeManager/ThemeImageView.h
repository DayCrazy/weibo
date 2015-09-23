//
//  ThemeImageView.h
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

@interface ThemeImageView : UIImageView
@property (nonatomic,copy) NSString* imageName;
@property (nonatomic,assign) CGFloat leftCapWidth;
@property (nonatomic,assign) CGFloat topCapWidth;

@end
