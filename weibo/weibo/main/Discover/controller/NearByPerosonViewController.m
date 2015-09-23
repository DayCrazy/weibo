//
//  NearByPerosonViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/9/4.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "NearByPerosonViewController.h"
#import "DataService.h"
#import "WeiboModel.h"
#import "weiboAnnotation.h"
#import "weiboAnnotationPerson.h"

@interface NearByPerosonViewController (){
    MKMapView* _mapView;
    CLLocationManager* locationManager;
    NSMutableDictionary* params;
    NSMutableArray* modelArray;
    
}

@end

@implementation NearByPerosonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的人";
    [self _createMapView];
    [self location];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createMapView{
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:_mapView];
    
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

            
            [modelArray addObject:annotation];
        }
        //        NSLog(@"%@",modelArray);
        [_mapView addAnnotations:modelArray];

        
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
    
    
    weiboAnnotationPerson* annotationView = (weiboAnnotationPerson*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    
    if (annotationView == nil) {
        annotationView = [[weiboAnnotationPerson alloc]initWithAnnotation:annotation reuseIdentifier:@"person"];
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
