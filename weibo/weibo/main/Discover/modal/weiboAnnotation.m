//
//  weiboAnnotation.m
//  weibo
//
//  Created by 李丹阳 on 15/9/2.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "weiboAnnotation.h"

@implementation weiboAnnotation


- (void)setModel:(WeiboModel *)model{
    if (_model!= model) {
        _model = model;
        NSDictionary *geo = model.geo;
        
        
        NSArray *coordinates = [geo objectForKey:@"coordinates"];
        if (coordinates.count >= 2) {
            
            NSString *longitude = coordinates[0];
            NSString *latitude = coordinates[1];
            
            _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
        }

    }
}


//
//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(10_9, 4_0){
//    self.coordinate = newCoordinate;
//}

@end
