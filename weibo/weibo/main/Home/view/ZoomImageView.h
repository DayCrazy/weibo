//
//  ZoomImageView.h
//  weibo
//
//  Created by 李丹阳 on 15/8/29.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZoomImageView;
@protocol zoomImageViewDelegate <NSObject>

@optional

//图片将要放大
- (void)imageWillZoomIn:(ZoomImageView *)imageView;
//图片将要缩小
- (void)imageWillZoomOut:(ZoomImageView *)imageView;
//图片已经放大
//图片已经缩小

@end



@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate,UIAlertViewDelegate>

@property (nonatomic, strong)NSString* urlString;


@property(nonatomic,weak)id<zoomImageViewDelegate> delegate;

//gif图片标记
@property (nonatomic,strong) UIImageView* iconImage;
//@property (nonatomic,assign) BOOL isGif;
@end
