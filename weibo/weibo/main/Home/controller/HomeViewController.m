//
//  HomeViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "ThemeButton.h"
#import  "ThemeManager.h"
#import "WeiboModel.h"
#import "HomeTableView.h"
#import "WeiboViewLayoutFram.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HomeViewController ()

@end

@implementation HomeViewController{
    HomeTableView* _tableView;
    ThemeImageView* _barImageView;
    ThemeLabel* _barLabel;
    MBProgressHUD* _hud;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self setRootNavItem];
    [self _createTableView];
    [self _loadWeiboData];

    _data = [[NSMutableArray alloc]init];
    _hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_hud];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTableView{
    _tableView = [[HomeTableView alloc] initWithFrame:self.view.bounds];
    
    //设置上下边界距离
    //_tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark－ 微博请求

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)loadNewData{
    SinaWeibo *sinaweibo = [self sinaweibo];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:@"20" forKey:@"count"];
    if (_data.count!= 0) {
        WeiboViewLayoutFram* layoutFrame = _data[0];
        WeiboModel* model = layoutFrame.weiboModel;
        
        NSString* sinceId = model.weiboId.stringValue;
        [params setObject:sinceId forKey:@"since_id"];
    }
    
        //获取微博
    SinaWeiboRequest* request = [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                           params:[params mutableCopy]
                       httpMethod:@"GET"
                         delegate:self];
    request.tag = 101;
    
}

- (void)loadMoreData{
    SinaWeibo *sinaweibo = [self sinaweibo];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    [params setObject:@"10" forKey:@"count"];
    if (_data.count!= 0) {
        WeiboViewLayoutFram* layoutFrame = [_data lastObject];
        WeiboModel* model = layoutFrame.weiboModel;
        
        NSString* maxId = model.weiboId.stringValue;
        [params setObject:maxId forKey:@"max_id"];
    }
    
    //获取微博
    SinaWeiboRequest* request = [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                                   params:[params mutableCopy]
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 102;
}


- (void)_loadWeiboData{
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    if ([sinaweibo isAuthValid]) {
        NSLog(@"已经登录");
        NSDictionary *params = @{@"count":@"20"};
        
        //获取微博
        SinaWeiboRequest* request = [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                                       params:[params mutableCopy]
                                                   httpMethod:@"GET"
                                                     delegate:self];
        request.tag = 100;
    
    }else{
        
        [sinaweibo logIn];
    }
}


#pragma mark － 微博代理请求


- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"网络接口请求失败：%@",error);
    
}


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    [_hud show:YES];
    NSArray* statuses = [result objectForKey:@"statuses"];
    NSMutableArray* layoutFramArray = [[NSMutableArray alloc]initWithCapacity:statuses.count];
    
    for (NSDictionary* dataDic in statuses) {
        WeiboModel* model = [[WeiboModel alloc]initWithDataDic:dataDic];
        
        WeiboViewLayoutFram* layoutFramModel = [[WeiboViewLayoutFram alloc]init];
        
        layoutFramModel.weiboModel = model;
        
        [layoutFramArray addObject:layoutFramModel];
    }
    
    if (request.tag == 100) {
        
        _data = layoutFramArray;
        
    }else if (request.tag == 101){
        
        
        if (layoutFramArray.count>0) {
            
            [self showNewWeiboCount:layoutFramArray.count];
            
            NSRange range = NSMakeRange(0, layoutFramArray.count);
            NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:layoutFramArray atIndexes:indexSet];
            
        }
        
    }else if (request.tag == 102){
        if (layoutFramArray.count>1) {
            [layoutFramArray removeObjectAtIndex:0];
            
            [_data addObjectsFromArray:layoutFramArray];
        }
        
    }
    
    if (layoutFramArray.count > 0) {
        _tableView.layoutFramArray = _data;
        [_tableView reloadData];
    }
    
    
    [_tableView reloadData];
    _tableView.layoutFramArray = _data;
    
    [_hud hide:YES];
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
}

//增加每次刷新后的在最上面显示刷新多少新数据    方法的调用在150行

- (void)showNewWeiboCount:(NSInteger)count{
    if (_barImageView == nil) {
        _barImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        _barImageView.imageName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        _barLabel = [[ThemeLabel alloc]initWithFrame:_barImageView.bounds];
        _barLabel.lableName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        [_barImageView addSubview:_barLabel];
    }
    if (count > 0) {
        
        _barLabel.text = [NSString stringWithFormat:@"更新了%ld条微博",count];
        [UIView animateWithDuration:0.6 animations:^{
            
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 40+64+5);
            
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    
                    [UIView setAnimationDelay:1];
                    _barImageView.transform = CGAffineTransformIdentity;
                    
                }];
            }
        }];
    }
    
    //添加系统声音，刷新完成后的声音
    NSString* path = [[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"];
    NSURL* url = [NSURL URLWithString:path];
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    AudioServicesPlaySystemSound(soundID);
    
}

@end
