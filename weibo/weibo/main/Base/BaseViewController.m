//
//  BaseViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"

@interface BaseViewController ()

@end

@implementation BaseViewController{
    UIWindow* tipWindow;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadImage];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)setRootNavItem{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeDidChangeNofication object:nil];
    [self loadImage];
}

- (void)Action{
    MMDrawerController* mmDraw = self.mm_drawerController;
    NSLog(@"%@",mmDraw);
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)editAction{
    MMDrawerController* mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)loadImage{

    UIView* leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 45)];
    ThemeButton* leftButton = [[ThemeButton alloc]init];
    leftButton.normalImgName = @"group_btn_all_on_title.png";
    leftButton.normalBgImgName = @"button_title.png";
    [leftButton setTitle:@"设置" forState:UIControlStateNormal];
    [leftButton setTitleColor:[[ThemeManager ShareInstance]getThemeColor:@"Mask_Title_color" ] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton sizeToFit];
    
    [leftView addSubview:leftButton];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;
    

    
    UIView* rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
    ThemeButton* rightButton = [[ThemeButton alloc]init];
    rightButton.frame = CGRectMake(20, 0, 50, 50);
    rightButton.normalImgName = @"button_icon_plus.png";
    rightButton.normalBgImgName = @"button_m.png";
    
    [rightButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];

    [rightButton sizeToFit];
    
    [rightView addSubview:rightButton];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)setBgImage{
    ThemeManager* manager = [ThemeManager ShareInstance];
    NSString* imageName = @"mask_titlebar64.png";
    UIImage* bgimage = [manager getThemeImage:imageName];
    UIImageView* bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = bgimage;
    
    
    UIImage* imge = [manager getThemeImage:@"bg_home.jpg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:imge]];
}


- (void)showStatusTip:(NSString*)title show:(BOOL)show{
    if (tipWindow == nil) {
        tipWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        tipWindow.windowLevel = UIWindowLevelStatusBar;
        tipWindow.backgroundColor = [UIColor blackColor];
        
        UILabel* tipLabel = [[UILabel alloc]initWithFrame:tipWindow.frame];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:13.0f];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.tag = 100;
        
        [tipWindow addSubview:tipLabel];
    }
    UILabel* lable = (UILabel*)[tipWindow viewWithTag:100];
    lable.text = title;
    if (show) {
        tipWindow.hidden = NO;
    }
    else{
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }
}


- (void)removeTipWindow{
    tipWindow.hidden = YES;
    tipWindow = nil;
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
