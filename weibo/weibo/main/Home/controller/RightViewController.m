//
//  RightViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/22.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "sendWeiboViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseNavigationViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBgImage];
    [self addButton];
//    self.view.backgroundColor = [UIColor blueColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeDidChangeNofication object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButton{
    NSArray* buttonImgName = [NSArray arrayWithObjects: @"newbar_icon_1.png",
                                                        @"newbar_icon_2.png",
                                                        @"newbar_icon_3.png",
                                                        @"newbar_icon_4.png",
                                                        @"newbar_icon_5.png", nil];
    for (int i = 0 ; i < buttonImgName.count; i++) {
        ThemeButton* button = [[ThemeButton alloc]initWithFrame:CGRectMake(5, 64+i*(50), 60, 60)];
        button.normalImgName = buttonImgName[i];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

- (void)buttonAction:(ThemeButton*)btn{
    NSLog(@"btn----%li",btn.tag);
    if (btn.tag == 0) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            // 弹出发送微博控制器
            
            sendWeiboViewController *senderVc = [[sendWeiboViewController alloc] init];
            senderVc.title = @"发送微博";
            
            
            // 创建导航控制器
            BaseNavigationViewController *baseNav = [[BaseNavigationViewController alloc] initWithRootViewController:senderVc];
            
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }
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
