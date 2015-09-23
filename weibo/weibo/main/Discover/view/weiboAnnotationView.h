//
//  weiboAnnotationView.h
//  weibo
//
//  Created by 李丹阳 on 15/9/2.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboModel.h"

@interface weiboAnnotationView : MKAnnotationView{
    UIImageView* _headView;
    UILabel* _textLabel;
}

@property (nonatomic,strong) WeiboModel* weiboModel;

@end
