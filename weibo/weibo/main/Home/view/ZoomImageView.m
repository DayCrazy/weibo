//
//  ZoomImageView.m
//  weibo
//
//  Created by 李丹阳 on 15/8/29.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"

@implementation ZoomImageView{
    UIScrollView* _scrollView;
    UIImageView* _fullImageView;
    double _length;
    NSMutableData* _data;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _addTap];
        [self addGIFMark];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _addTap];
        [self addGIFMark];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if (self) {
        [self _addTap];
        [self addGIFMark];
    }
    return self;
}

- (void)_addTap{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomIN)];
    [self addGestureRecognizer:tapGesture];
}

- (void)zoomIN{
    
    
    //zoomImageViewDelegate
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:self];
    }
    
    
    self.hidden = YES;

    [self creatView];
    
    CGRect frame = [self convertRect:self.bounds  toView:self.window];
    _fullImageView.frame = frame;
    
    
    [UIView animateWithDuration:0.6 animations:^{
        _fullImageView.frame = _scrollView.bounds;

//        
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
    }];
    
    if (_urlString.length > 0) {
        NSURL* url  = [[NSURL alloc]initWithString:self.urlString];
        NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    
}

- (void)zoomOut{
    
    if ( [self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }
    
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.backgroundColor = [UIColor clearColor];
        
        CGRect frame = [self convertRect:self.bounds fromView:self.window];
        _fullImageView.frame = frame;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        
        _fullImageView = nil;
        _scrollView = nil;
    }];
}

- (void)creatView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
        
        
        CGRect frame = [self convertRect:self.bounds fromView:self.window];
        
        _fullImageView = [[UIImageView alloc]initWithFrame:frame];
        
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        UITapGestureRecognizer* outTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:outTap];
        
        
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savePicture:)];
        [_scrollView addGestureRecognizer:longPress];
        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
 
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSDictionary* allHeadFile = [httpResponse allHeaderFields];

    NSString* size = [allHeadFile objectForKey:@"Content-Length"];
    _length = [size doubleValue];
    _data = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    UIImage* image = [UIImage sd_animatedGIFWithData:_data];
    
    _fullImageView.image = image;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat length = image.size.height/image.size.width* kScreenWidth;
        if (length< kScreenHeight) {
             _fullImageView.frame = _scrollView.bounds;
        }
        else{
            _fullImageView.height = length;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, length);
        }
    } completion:^(BOOL finished) {
       
        _scrollView.backgroundColor = [UIColor blackColor];
    }];
    
}

- (void)savePicture:(UILongPressGestureRecognizer *)longPress{
    
    if ( longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"将图片保存到本地" delegate:self
                                             cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex-----%li",buttonIndex);
    if (buttonIndex == 0) {
        //显示保存进度
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        
        
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        
        UIImage* image = [UIImage  sd_animatedGIFWithData:_data];
        
        //将图片保存到本地
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)(hud));
    }
}

//selector对应的方法，固定的，
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    //提示保存成功
   

    MBProgressHUD *hud = (__bridge MBProgressHUD *)(contextInfo);
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
    
}

- (void)addGIFMark{
    _iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_gif.png"]];
    _iconImage.hidden = YES;
    [self addSubview:_iconImage];
    
}

@end
