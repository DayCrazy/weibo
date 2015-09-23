//
//  weiboAnnotation.h
//  weibo
//
//  Created by 李丹阳 on 15/9/2.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"

@interface weiboAnnotation : NSObject<MKAnnotation>

// The implementation of this property must be KVO compliant.

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) WeiboModel* model;


// Called as a result of dragging an annotation view.


@end
