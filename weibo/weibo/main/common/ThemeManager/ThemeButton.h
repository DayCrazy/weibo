//
//  ThemeButton.h
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

@interface ThemeButton : UIButton

@property (nonatomic,copy)NSString* normalImgName;
@property (nonatomic,copy)NSString* highLightImgName;
@property (nonatomic,copy)NSString* normalBgImgName;
@property (nonatomic,copy)NSString* highLightBgImgName;

- (void)loadImage;

@end
