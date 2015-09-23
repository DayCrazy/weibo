//
//  NearbyViewViewController.h
//  weibo
//
//  Created by 李丹阳 on 15/9/2.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "BaseViewController.h"
#import "CLLocation+YCLocation.h"
#import "SinaWeibo.h"
#import <MapKit/MapKit.h>

@interface NearbyViewViewController : BaseViewController<CLLocationManagerDelegate,SinaWeiboRequestDelegate,MKMapViewDelegate>

@end
