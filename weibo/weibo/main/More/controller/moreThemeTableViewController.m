//
//  moreThemeTableViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/21.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "moreThemeTableViewController.h"
#import "moreTableViewCell.h"

static NSString *moreCellId = @"moreCellId";


@interface moreThemeTableViewController ()

@end

@implementation moreThemeTableViewController{
    NSArray* themeArry;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return  self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"theme.plist" ofType:nil];
    
    NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
    themeArry = [themeConfig allKeys];
    
    [self.tableView registerClass:[moreTableViewCell class] forCellReuseIdentifier:moreCellId];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return themeArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    moreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    
    cell.titleLabel.text = themeArry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *themeName = themeArry[indexPath.row];
    [[ThemeManager ShareInstance] setThemeName:themeName];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
