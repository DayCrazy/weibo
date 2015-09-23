//
//  MoreViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "MoreViewController.h"
#import "moreThemeTableViewController.h"
#import "moreTableViewCell.h"
#import "ThemeManager.h"

static NSString *moreCellId = @"moreCellId";


@interface MoreViewController (){
    UITableView* _tableView;
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    
    self.title = @"更多";
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kThemeDidChangeNofication object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor  = [UIColor clearColor];
    
    
    [self.view addSubview:_tableView];
    [_tableView registerClass:[moreTableViewCell class] forCellReuseIdentifier:moreCellId];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    moreTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
//    cell.backgroundColor = [[ThemeManager ShareInstance]getThemeColor:@"More_Item_color"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.logoImage.imageName = @"more_icon_theme.png";
            cell.titleLabel.text = @"主题选择";
            cell.themeName.text = [ThemeManager ShareInstance].themeName;
        }
        else if (indexPath.row == 1){
            cell.logoImage.imageName = @"more_icon_account.png";
            cell.titleLabel.text = @"账户管理";
//            cell.themeName.hidden = YES;
        }
    }
    else if (indexPath.section == 1){
        cell.logoImage.imageName = @"more_icon_feedback.png";
        cell.titleLabel.text = @"意见反馈";
//        cell.themeName.hidden = YES;
    }else if (indexPath.section == 2){
        cell.logoImage.hidden = YES;
        cell.titleLabel.text = @"登出当前帐户";
        cell.titleLabel.textAlignment = NSTextAlignmentCenter;
        cell.titleLabel.center = cell.contentView.center;
//        cell.themeName.hidden = YES;
    }
    
    if (indexPath.section!= 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        moreThemeTableViewController* vc = [[moreThemeTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
