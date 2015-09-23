//
//  ProfileViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "ProfileViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "ProfileTableViewCell.h"
#import "weiboView.h"

@interface ProfileViewController (){

    NSDictionary* userDic;
    NSArray* userArray;
    weiboView* _weiboView;


}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setRootNavItem];
    self.title = @"个人";
    [self createSubView];
    [self _loadWeiboData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSubView{

    
    _weiboNumber = [[ThemeButton alloc]initWithFrame:CGRectMake(40, 202, 100, 40)];
    _fansNumber = [[ThemeButton alloc]initWithFrame:CGRectMake(236, 202, 100, 40)];
    _friendsNumber = [[ThemeButton alloc]initWithFrame:CGRectMake(137, 202, 100 , 40)];
    
    [self.view addSubview:_weiboNumber];
    [self.view addSubview:_fansNumber];
    [self.view addSubview:_friendsNumber];
    
    _weiboView = [[weiboView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 100)];
    [self.view addSubview:_weiboView];

}


#pragma 网络请求

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)_loadWeiboData{
    SinaWeibo *sinaweibo = [self sinaweibo];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];

    //获取微博
    SinaWeiboRequest* request = [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                                   params:[params mutableCopy]
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 10;
}


- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"网络接口请求失败：%@",error);
    
}


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    userArray  = [result objectForKey:@"statuses"];
//    NSLog(@"%@",userArray);
//    NSString* text;
//    NSString* thumbnail_pic;
//    NSString* sourceText;
//    NSString* sourceThumbnail_pic;
    for (NSDictionary* dic in userArray) {
        userDic = [dic objectForKey:@"user"];
//        text = [dic objectForKey:@"text"];
//        thumbnail_pic = [dic objectForKey:@"thumbnail_pic"];
//        if ([dic objectForKey:@"source"]!= nil) {
//            sourceText = [dic objectForKey:<#(id)#>]
//        }
    }
    
    NSURL* url  = [NSURL URLWithString: [userDic objectForKey:@"profile_image_url"]];

    [_iconImage sd_setImageWithURL:url];
    
    _NameLabel.text = [userDic objectForKey:@"screen_name"];
    
    _oweDescription.text = [userDic objectForKey:@"description"];
    _oweDescription.numberOfLines = 0;
    _oweDescription.lineBreakMode = NSLineBreakByTruncatingTail;
    [_oweDescription sizeToFit];
    

    
    int  fans = [[userDic objectForKey:@"followers_count"] intValue ];
    int  weibos = [[userDic objectForKey:@"statuses_count"] intValue ];
    int  friends = [[userDic objectForKey:@"friends_count"] intValue ];
    

    _weiboNumber.normalBgImgName = @"button_avatar_mask@2x";
    [_weiboNumber setTitle:[NSString stringWithFormat:@"%d\n微博",weibos] forState:UIControlStateNormal] ;
    _weiboNumber.titleLabel.numberOfLines = 0;
    _weiboNumber.titleLabel.textAlignment = NSTextAlignmentCenter ;
    
    _fansNumber.normalBgImgName = @"button_avatar_mask@2x";
    [_fansNumber setTitle:[NSString stringWithFormat:@"%d\n粉丝",fans] forState:UIControlStateNormal];
    _fansNumber.titleLabel.numberOfLines = 0;
    _fansNumber.titleLabel.textAlignment = NSTextAlignmentCenter ;
    
    _friendsNumber.normalBgImgName = @"button_avatar_mask@2x";
    [_friendsNumber setTitle:[NSString stringWithFormat:@"%d\n关注",friends] forState:UIControlStateNormal];
    _friendsNumber.titleLabel.numberOfLines = 0;
    _friendsNumber.titleLabel.textAlignment = NSTextAlignmentCenter ;
    
//    NSArray* dic =  [userDic objectForKey:@"status"];
//    NSLog(@"%@",dic);
//    self.layoutFrame.weiboModel.text = text;
//    self.layoutFrame.weiboModel.thumbnailImage = thumbnail_pic;
    

}




@end
