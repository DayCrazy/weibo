//
//  DiscoverViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearbyViewViewController.h"
#import "NearByPerosonViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRootNavItem];
    self.title = @"发现";
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

- (IBAction)nearbyView:(id)sender {
    NearbyViewViewController* vc  = [[NearbyViewViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)nearbyPerson:(id)sender {
    NearByPerosonViewController* vc = [[NearByPerosonViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
