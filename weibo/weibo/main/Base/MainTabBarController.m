//
//  MainTabBarController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* Names = @[@"HomeStoryboard",@"MessageStoryboard",@"ProfileStoryboard",@"DiscoverStoryboard",@"MoreStoryboard"];
    
    NSMutableArray* NavArray = [[NSMutableArray alloc]init];
    
    for (NSString* name  in Names) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
        UINavigationController* nav = [storyboard instantiateInitialViewController];
        [NavArray addObject:nav];
    }
    
    self.viewControllers = NavArray;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
