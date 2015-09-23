//
//  BaseNavigationViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseNavigationViewController.h"


@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}


- (void)loadImage{
    ThemeManager* manager = [ThemeManager ShareInstance];
    NSString* imageName = @"mask_titlebar64.png";
    UIImage* bgimage = [manager getThemeImage:imageName];
    
    [self.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    
    UIColor* color = [manager getThemeColor:@"Mask_Title_color"];
    
    NSDictionary* attributes = @{
                                 NSForegroundColorAttributeName:
                                 color
                                 };
    
    self.navigationBar.titleTextAttributes = attributes;
    self.navigationBar.tintColor = color;

    
    UIImage* imge = [manager getThemeImage:@"bg_home.jpg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:imge]];
    
}














/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
