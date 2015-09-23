//
//  NearbyViewViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/9/2.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "NearbyViewViewController.h"
#import "CCLocationManager.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "DataService.h"
#import <MapKit/MapKit.h>
#import "weiboAnnotation.h"
#import "weiboAnnotationView.h"

@interface NearbyViewViewController (){
    CLLocationManager* locationManager;
    NSMutableDictionary* params;
    MKMapView* _mapView;
    NSMutableArray* modelArray;
}

@end

@implementation NearbyViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的微博";
    [self _creatMapView];
    [self location];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//显示地图  并在协议方法- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations 内设置比例
- (void)_creatMapView{
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
//    weiboAnnotation* annotation = [[weiboAnnotation alloc]init];
//    annotation.title = @"欢乐代码汪";
//
//    CLLocationCoordinate2D coordinate = {30.315238,120.341029};
//    [annotation setCoordinate:  coordinate];
////    annotation.coordinate = coordinate;
//    [mapView addAnnotation:annotation];
    
}


- (void)location{
    locationManager = [[CLLocationManager alloc]init];
    if (kVersion>8.0) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

#pragma MKMapViewDelegate

//位置更新代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    [locationManager stopUpdatingLocation];
    
    CLLocation* location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    
    
    params = [[NSMutableDictionary alloc]init];
    NSString* lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString* lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    [self loadNearViewURL];
    
    CLLocationCoordinate2D center = coordinate;
    //数值越小,显示范围越小
    MKCoordinateSpan span = {0.05,0.05};
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];

}


- (void)loadNearViewURL{
    
    [DataService requestAFUrl:@"place/nearby_timeline.json" httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray* statuses = [result objectForKey:@"statuses"];
        modelArray = [[NSMutableArray alloc]initWithCapacity:statuses.count];
        
        for (NSDictionary* dic in statuses) {
            WeiboModel* model = [[WeiboModel alloc]initWithDataDic:dic];
            weiboAnnotation* annotation = [[weiboAnnotation alloc]init];
            annotation.model = model;
            
//            NSArray* coorArray = [model.geo objectForKey:@"coordinates"];
//            
//            CLLocationCoordinate2D coord;
//            coord.longitude = [coorArray[0] doubleValue];
//            coord.latitude = [coorArray[1] doubleValue];
//            
//            annotation.coordinate = coord;
            
            
            
            [modelArray addObject:annotation];
        }
//        NSLog(@"%@",modelArray);
        [_mapView addAnnotations:modelArray];
        
//        WeiboModel *weibo = [modelArray objectAtIndex:0];
//        
//        NSArray* coorArray = [weibo.geo objectForKey:@"coordinates"];
//
//        CLLocationCoordinate2D coord;
//        coord.latitude = [coorArray[0] doubleValue];
//        coord.longitude  = [coorArray[1] doubleValue];
//        
////        NSLog(@"coor----%@",[weibo.geo objectForKey:@"coordinates"]);
//        
//        MKCoordinateSpan span = {0.2,0.2};
//        [_mapView setRegion:MKCoordinateRegionMake(coord, span) animated:YES];
    
    }];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
//    //创建大头针
//    MKPinAnnotationView* pinView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//    if (pinView == nil) {
//        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
//    }
//    return pinView;
    
    
    weiboAnnotationView* annotationView = (weiboAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    
    if (annotationView == nil) {
        annotationView = [[weiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    annotationView.annotation = annotation;
    return annotationView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
