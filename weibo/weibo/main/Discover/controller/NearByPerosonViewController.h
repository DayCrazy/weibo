//
//  NearByPerosonViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/9/4.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "SinaWeibo.h"
#import "CLLocation+YCLocation.h"


@interface NearByPerosonViewController : BaseViewController<CLLocationManagerDelegate,SinaWeiboRequestDelegate,MKMapViewDelegate>

@end
