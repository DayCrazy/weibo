//
//  AppDelegate.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainTabBarController.h"
#import "MainViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    MainViewController* mainTabBar = [[MainViewController alloc]init];
//    
//    self.window.rootViewController = mainTabBar;
    
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    //查看本地是否有上次的登陆纪录
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
        
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
        _sinaweibo.refreshToken = [sinaweiboInfo objectForKey:@"refresh_token"];
        //----------jia nwejfn wjefw=-----------
    }
    
    LeftViewController* leftVC = [[LeftViewController alloc]init];
    RightViewController* rightVC = [[RightViewController alloc]init];
    MainViewController* mainVC = [[MainViewController alloc]init];
    
    MMDrawerController* drawVC = [[MMDrawerController alloc]initWithCenterViewController:mainVC leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
    
    //设置比例
    [drawVC setMaximumLeftDrawerWidth:100];
    [drawVC setMaximumRightDrawerWidth:70];
    //设置手势区域
    [drawVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll ];
    [drawVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画类型
    [[MMExampleDrawerVisualStateManager  sharedManager]setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    
    [[MMExampleDrawerVisualStateManager sharedManager]setRightDrawerAnimationType:MMDrawerAnimationTypeParallax];
    //设置动画效果
    [drawVC setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
         
    }];
    
    
    self.window.rootViewController = drawVC;
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"登陆成功");
    
    NSDictionary* authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken,@"AccessTokenKey",
                              sinaweibo.expirationDate,@"ExpirationDateKey",
                              sinaweibo.userID,@"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    
    [[NSUserDefaults standardUserDefaults]setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"已经登出");
}



@end
