//
//  HomeTableView.h
//  weibo
//
//  Created by 李丹阳 on 15/8/23.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic,strong) NSArray* dataArray;
@property (nonatomic,strong) NSArray* layoutFramArray;
@end
