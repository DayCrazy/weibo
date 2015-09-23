//
//  HomeTableView.m
//  weibo
//
//  Created by 李丹阳 on 15/8/23.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeTableViewCell.h"
#import "WeiboViewLayoutFram.h"
#import "MJRefresh.h"
#import "HomeCommentTableViewController.h"

static NSString  *cellId = @"cellId";


@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _createView];
    }
    return self;
}

- (void)_createView{
    self.delegate = self;
    self.dataSource = self;
    
    self.backgroundColor = [UIColor clearColor];
    
    UINib* nib = [UINib nibWithNibName:@"HomeTableViewCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:cellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.layoutFramArray.count;
}



- (NSInteger)numberOfSections{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    
    //设置数据
    cell.layoutMadel = self.layoutFramArray[indexPath.row];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboViewLayoutFram* layoutFrame = self.layoutFramArray[indexPath.row];
    CGRect frame =layoutFrame.frame;
    CGFloat height = frame.size.height;
    
    
    return height+100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCommentTableViewController* vc = [[HomeCommentTableViewController alloc]init];
    
    UIViewController* comment = (UIViewController*)self.nextResponder.nextResponder;
    
    [comment.navigationController pushViewController:vc animated:YES];
    
    vc.layoutFrame = _layoutFramArray[indexPath.row];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
