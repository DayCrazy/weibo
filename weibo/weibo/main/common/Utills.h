//
//  Utills.h
//  weibo
//
//  Created by 李丹阳 on 15/8/24.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utills : NSObject
+ (NSDate*)dateFromString:(NSString*)dateString withFormatterString:(NSString*)formatterStr;
+ (NSString*)stringWithDate:(NSDate*)date withFormatterString:(NSString*)formatterStr;
+ (NSString*)getStingWithDateSting:(NSString*)dateString withFormatterString:(NSString*)formatterStr withInputString:(NSString*)inputStr;

@end
