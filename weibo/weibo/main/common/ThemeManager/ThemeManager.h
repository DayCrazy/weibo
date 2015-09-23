//
//  ThemeManager.h
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNofication @"kThemeDidChangeNofication"
#define kdefualtThemeName @"cat"


@interface ThemeManager : NSObject
@property (nonatomic,strong) NSDictionary* themeConfig;
@property (nonatomic,copy) NSString* themeName;
@property (nonatomic,strong) NSDictionary* themeColorConfig;



+ (ThemeManager*)ShareInstance;

- (UIImage*)getThemeImage:(NSString*)imageName;

- (UIColor*)getThemeColor:(NSString*)colorName;

@end