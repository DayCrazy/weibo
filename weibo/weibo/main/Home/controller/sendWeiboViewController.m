//
//  sendWeiboViewController.m
//  weibo
//
//  Created by 李丹阳 on 15/8/31.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "sendWeiboViewController.h"
#import "ThemeButton.h"
#import "DataService.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "CCLocationManager.h"

@interface sendWeiboViewController (){
    UITextView* _textView;
     UIView *_editorBar;
    ZoomImageView* _zoomImage;
    UIImage* sendImage;
    CLLocationManager* _locationManager;
    UILabel *_locationLabel;//显示定位
}

@end

@implementation sendWeiboViewController


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];

        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    [self createWriteText];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatNavItem{
    ThemeButton* closeButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.normalImgName = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(closeActon) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* closeItem = [[UIBarButtonItem alloc]initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    ThemeButton* sendButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.normalImgName = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* sendItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendItem;
    
}

- (void)closeActon{
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendAction{
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容为空";
    }
    else if(text.length > 140) {
        error = @"微博内容大于140字符";
    }
    
    if (error != nil) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:text forKey:@"status"];


    [DataService sendWeibo:text image:sendImage block:^(id result) {
        NSLog(@"发送成功");
        //状态栏显示
        [self showStatusTip:@"发送成功" show:NO];
        
    }];
    
    [self showStatusTip:@"正在发送..." show:YES];
    [self closeActon];


}

- (void)createWriteText{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth-10, 0)];
    _textView.right = 5;
    _textView.left = 5;
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = YES;
    
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_textView];
    
    //2 编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 55)];
    _editorBar.backgroundColor = [UIColor clearColor];
    //3.创建多个编辑按钮
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];
    for (int i=0; i<imgs.count; i++) {
        NSString *imgName = imgs[i];
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(15+(kScreenWidth/5)*i, 20, 40, 33)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+i;
        button.normalImgName = imgName;
        [_editorBar addSubview:button];
    }

    [self.view addSubview:_editorBar];
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    _locationLabel.backgroundColor = [UIColor lightGrayColor];
    _locationLabel.textColor = [UIColor blackColor];
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.hidden = YES;
    [_editorBar addSubview:_locationLabel];
}

- (void)buttonAction:(ThemeButton *)btn{
    if (btn.tag == 10) {
        [self _selectPhoto];
    }
    if (btn.tag == 13) {
        [self _location];
    }
    
}

- (void)_location{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        if (kVersion >8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    CLLocation* location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度%f,纬度%f",coordinate.latitude,coordinate.longitude);
    
    NSString* coordinateSrt = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setObject:coordinateSrt forKey:@"coordinate"];
    
     __weak sendWeiboViewController* weakSelf = self;
    
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSLog(@"%@",result);
        
        __strong sendWeiboViewController *strongSelf = weakSelf;
        
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count > 0) {
            NSDictionary *geo = [geos lastObject];
            
            NSString *addr = [geo objectForKey:@"address"];
            NSLog(@"%@",addr);
            
            strongSelf->_locationLabel.hidden = NO;
            strongSelf->_locationLabel.text = addr;
            
        }
        
    }];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
        
    }];
}



- (void)_selectPhoto{
    //设置下方弹出的提示选择
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:@"拍照"
                                             otherButtonTitles:@"相册",nil];
    
    [sheet showInView:self.view];
}


#pragma mark - 键盘弹出通知

- (void)keyBoardWillShow:(NSNotification *)notification{
    
//    NSLog(@"%@",notification);
    //1 取出键盘frame
    NSValue *bounsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    
    CGRect frame = [bounsValue CGRectValue];
    //2 键盘高度
    CGFloat height = frame.size.height;
    
    
    //3 调整视图的高度
    _textView.height = 200;
    _editorBar.top = kScreenHeight-height-60;
    
}


#pragma mark - UIActionDelegat

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera =[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if(!isCamera){
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        
    }else if (buttonIndex == 1) {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        return;
    }
    
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //弹出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //2 取出照片
    UIImage* image= [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    //3 显示缩略图
    
    if (_zoomImage == nil) {
        _zoomImage = [[ZoomImageView alloc]initWithFrame:CGRectMake(10, _textView.bottom+10, 80, 80)];
        _zoomImage.delegate = self;
        _zoomImage.image = image;
        [self.view addSubview:_zoomImage];
    }
    sendImage = image;
}

- (void)imageWillZoomIn:(ZoomImageView *)imageView{
    [_textView resignFirstResponder];
}

- (void)imageWillZoomOut:(ZoomImageView *)imageView{
    [_textView becomeFirstResponder];
}


@end
