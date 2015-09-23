//
//  HomeCommentTableViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/28.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "HomeCommentTableViewController.h"
#import "ThemeLabel.h"
#import "HomeCommentTableViewCell.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "weiboView.h"
#import "ThemeImageView.h"
#import "ThemeManager.h"
#import "MJRefresh.h"

@interface HomeCommentTableViewController ()

@end

@implementation HomeCommentTableViewController{
    UIView* _headView;
    UIImageView* userIconImage;
    ThemeLabel* userName;
    ThemeLabel* comeWhere;
    NSMutableArray* data;
    weiboView* _weiboView;
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}


//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name: kThemeDidChangeNofication object:nil];
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
//        [self loadData];
//        [self _createSubView];
//    }
//    return self;
//}
//
//
//- (instancetype)initWithStyle:(UITableViewStyle)style{
//    self = [super initWithStyle:style];
//    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name: kThemeDidChangeNofication object:nil];
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
//        [self loadData];
//        [self _createSubView];
//    }
//    return self;
//}


- (void)themeChange:(NSNotification *)notification
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentModel* model = data[indexPath.row];

    //计算单元格的高度
    CGFloat height = [HomeCommentTableViewCell getCommentHeight:model];
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeCommentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = data[indexPath.row];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)_createSubView{
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    data = [[NSMutableArray alloc]init];

    //背景图
    ThemeImageView *bgImageView = [[ThemeImageView alloc] init];
    bgImageView.imageName = @"bg_home.jpg";
    self.tableView.backgroundView = bgImageView;

    
    
    //创建头视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _layoutFrame.frame.size.height + 130)];
    
    //头像
    userIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
    userIconImage.layer.cornerRadius = userIconImage.width/2;
    userIconImage.layer.borderWidth = 1;
    userIconImage.layer.masksToBounds = YES;
    [_headView addSubview:userIconImage];
    [userIconImage sd_setImageWithURL:[NSURL URLWithString:_layoutFrame.weiboModel.userModel.profile_image_url]];
    
    
    //昵称
    userName = [[ThemeLabel alloc] initWithFrame:CGRectMake(80, 10, 150, 25)];
    userName.text = _layoutFrame.weiboModel.userModel.name;
    [userName setLableName:@"Timeline_Name_color"];
    [_headView addSubview:userName];

    //来源
    comeWhere = [[ThemeLabel alloc] initWithFrame:CGRectMake(240, 20, _layoutFrame.srTextFrame.size.width, _layoutFrame.srTextFrame.size.height)];
    comeWhere.text = _layoutFrame.weiboModel.source;
    [comeWhere setLableName:@"Timeline_Time_color"];
    comeWhere.font = [UIFont systemFontOfSize:12];
    [_headView addSubview:comeWhere];
    
    //微博
    _weiboView = [[weiboView alloc] initWithFrame:CGRectMake(30, 90, _layoutFrame.frame.size.width, _layoutFrame.frame.size.height)];
    _weiboView.backgroundColor = [UIColor clearColor];
    _weiboView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    _weiboView.layoutFrame = self.layoutFrame;
    [_headView addSubview:_weiboView];
    
    _headView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = _headView;

    
    UINib *nib = [UINib nibWithNibName:@"HomeCommentTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    

}




#pragma mark - 请求数据

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)loadData{
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    NSString *weiboId = _layoutFrame.weiboModel.weiboIdStr;
//    NSNumber* weiboId = _layoutFrame.weiboModel.weiboId;
    [params setObject:@"10" forKey:@"count"];

    [params setValue:weiboId forKey:@"id"];
    
    SinaWeiboRequest *request =  [sinaweibo requestWithURL:@"comments/show.json"
                       params:params
                   httpMethod:@"GET"
                     delegate:self];
    request.tag = 100;
    
}

- (void)loadMoreData{
    NSString *weiboId = self.layoutFrame.weiboModel.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    
    //设置max_id 分页加载
    commentModel *cm = [data lastObject];
    if (cm == nil) {
        return;
    }
    NSString *lastID = cm.idstr;
    [params setObject:lastID forKey:@"max_id"];
    
    
    SinaWeibo *sinaWeibo = [self sinaweibo];
    SinaWeiboRequest *request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    request.tag = 101;
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    NSDictionary* resultDic = (NSDictionary*)result;
    NSArray* dataArray = [resultDic objectForKey: @"comments"];
    NSMutableArray* commentArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary* dic in dataArray) {
        commentModel* model = [[commentModel alloc]init];
        model.commentText = [dic objectForKey:@"text"];
        model.commentName = [[dic objectForKey: @"user"] objectForKey:@"screen_name"];
        model.iconStr = [[dic objectForKey: @"user"] objectForKey:@"profile_image_url"];
        model.idstr = [dic objectForKey:@"id"];
        [commentArray addObject:model];
    }
    
    if (request.tag == 100) {
        data = commentArray;
        
    }else if(request.tag == 101){
        [self.tableView.footer endRefreshing];
        if (commentArray.count>1) {
            [commentArray removeObjectAtIndex:0];
             [data addObjectsFromArray:commentArray];
        }
        else {
            return;
        }
    }
    
    
    [self.tableView reloadData];
//    NSLog(@"%@",commentArray);
    
}

- (void)setLayoutFrame:(WeiboViewLayoutFram *)layoutFrame{
    if(_layoutFrame != layoutFrame){
        _layoutFrame = layoutFrame;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name: kThemeDidChangeNofication object:nil];
        [self loadData];
        [self _createSubView];
    }
}


@end
