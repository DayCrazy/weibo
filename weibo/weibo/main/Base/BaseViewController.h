//
//  BaseViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/8/19.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setRootNavItem;
- (void)setBgImage;
- (void)showStatusTip:(NSString*)title show:(BOOL)show;
@end
