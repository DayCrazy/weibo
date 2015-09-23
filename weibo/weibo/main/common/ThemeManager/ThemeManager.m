//
//  ThemeManager.m
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "ThemeManager.h"
#define kThemeSave  @"kThemeSave"

@implementation ThemeManager

+ (ThemeManager *)ShareInstance{
    
    static ThemeManager* instance;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [[[self class]alloc ]init];
    });
    return instance;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _themeName = kdefualtThemeName;
        NSString* saveName = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeSave];
        if (saveName.length>0) {
            _themeName = saveName;
        }
        NSString* configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        NSString* themePath = [self themePath];
        
        NSString* filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        
        self.themeColorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return  self;
}

- (void)setThemeName:(NSString *)themeName{
    if (![_themeName isEqualToString:themeName]) {
        
        _themeName = [themeName copy];
        
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeSave];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ///------------------------------------
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        
        self.themeColorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        //---------------------------------------
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNofication object:nil];
    }

}


- (NSString *)themePath{
    
    NSString* bundlePath = [[NSBundle mainBundle]resourcePath];
    NSString* themePath = [self.themeConfig objectForKey:_themeName];
    NSString* path = [bundlePath stringByAppendingPathComponent:themePath];
    
    return path;
}


- (UIImage*)getThemeImage:(NSString*)imageName{
    if (imageName.length == 0) {
        return  nil;
    }
    NSString* themePath = [self themePath];
    NSString* filePath = [themePath stringByAppendingPathComponent:imageName];
    UIImage* themeImage = [UIImage imageWithContentsOfFile:filePath];
    return  themeImage;
}

- (UIColor*)getThemeColor:(NSString*)colorName{
    if (colorName.length == 0) {
        return  nil;
    }
    NSDictionary* rgbDic = [self.themeColorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    CGFloat alpha = [rgbDic[@"alpha"] floatValue];
    
    if (rgbDic[@"alpha"] == nil) {
        alpha = 1;
    }
    
    
    UIColor* color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];

    return  color;
}
@end
