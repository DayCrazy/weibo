//
//  MainViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    ThemeImageView* _tableView;
    ThemeImageView* _selectView;
    ThemeImageView* _bageImage;
    ThemeLabel* _bageLabel;
}

- (void)viewDidLoad {
    [self createViewController];
    [self createTabBarView];
    [super viewDidLoad];
    
    //增加定时器，用来定时请求网络申请
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTabBarView{
    
    for (UIView* view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    //_tableView 高 49 －》40
    _tableView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth, 40)];
    _tableView.userInteractionEnabled = YES;
    [_tableView setImageName:@"mask_navbar.png"];
    
    //图片格式改为全铺
    _tableView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tabBar addSubview:_tableView];
    
    _selectView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, 0, 64, 49)];
    _selectView.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectView];
    
    NSArray *imgNames = @[
                          @"home_tab_icon_1.png",
                          @"home_tab_icon_2.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_5.png",
                          ];
    CGFloat buttonWide = kScreenWidth/5.0;
    
    for ( int i = 0; i < imgNames.count; i++) {
        
        ThemeButton* button = [[ThemeButton alloc]initWithFrame:CGRectMake(i*buttonWide, 0, buttonWide, 49)];
        NSString* name = imgNames[i];
        
        button.normalImgName = name;
//        [button loadImage];
        button.tag = i;
        [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }
    
}

- (void)createViewController{
    NSArray* storyNames = @[@"HomeStoryboard",@"MessageStoryboard",@"ProfileStoryboard",@"DiscoverStoryboard",@"MoreStoryboard"];
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for (int i = 0;  i< storyNames.count; i++) {
        NSString* name = storyNames[i];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavigationViewController* baseNav = [storyboard instantiateInitialViewController];
        [array addObject:baseNav];
        //把每一个 storyboard的navigationController 都拿出来放到相当于TabBar的子视图控制器中。
        //[self addChildViewController:baseNav];
    }
    
    self.viewControllers = array;
//    UIViewController* firstView = self.childViewControllers[0];
//    [self.view insertSubview:firstView.view belowSubview:_tableView];
    
}

//点击切换视图
- (void)setSelectIndex:(NSInteger)SelectIndex{
    
    if (self.selectedIndex!= SelectIndex) {
        UIViewController* lastVC = self.childViewControllers[self.selectedIndex];
        UIViewController* currentVC = self.childViewControllers[SelectIndex];
        
        [lastVC.view removeFromSuperview];
        
        [self.view insertSubview:currentVC.view belowSubview:_tableView];
        self.selectedIndex = SelectIndex;
    }
}

- (void)selectTab:(UIButton*)button{
    [UIView animateWithDuration:.2 animations:^{
        _selectView.center = button.center;
    }];
    [self setSelectIndex:button.tag];
}

- (void)timerAction{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate
    ;
    SinaWeibo* sinaWeibo = appDelegate.sinaweibo;
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    CGFloat taBarButtonWidth = kScreenWidth/5;
    
    if (_bageImage == nil) {
        _bageImage = [[ThemeImageView alloc]initWithFrame:CGRectMake(taBarButtonWidth-32, 0, 32, 32)];
        _bageImage.imageName = @"number_notify_9.png  ";
        [self.tabBar addSubview:_bageImage];
        
        _bageLabel = [[ThemeLabel alloc]initWithFrame:_bageImage.bounds];
        _bageLabel.backgroundColor = [UIColor clearColor];
        _bageLabel.textAlignment = NSTextAlignmentCenter;
        _bageLabel.lableName = @"Timeline_Notice_color";
        _bageLabel.font = [UIFont systemFontOfSize:13];
        [_bageImage addSubview:_bageLabel];
    }
    
    NSNumber* status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    if (count>0) {
        _bageImage.hidden = NO;
        if (count >= 100) {
            count = 99;
        }
        _bageLabel.text = [NSString stringWithFormat:@"%li",count];
    }else{
        _bageImage.hidden = YES;
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
