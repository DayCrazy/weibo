//
//  sendWeiboViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/8/31.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>

@interface sendWeiboViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,zoomImageViewDelegate,CLLocationManagerDelegate>

@end
