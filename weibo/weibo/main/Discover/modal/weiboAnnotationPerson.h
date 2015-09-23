//
//  weiboAnnotationPerson.h
//  weibo
//
//  Created by 李丹阳 on 15/9/5.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboModel.h"

@interface weiboAnnotationPerson : MKAnnotationView{
    UIImageView* _headView;
    UILabel* _userName;
}

@property (nonatomic,strong) WeiboModel* weiboModel;@end
