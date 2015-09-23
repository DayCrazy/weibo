//
//  Utills.m
//  weibo
//
//  Created by 李丹阳 on 15/8/24.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "Utills.h"

@implementation Utills

+ (NSDate*)dateFromString:(NSString*)dateString withFormatterString:(NSString*)formatterStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:formatterStr];
    
    
    NSDate* date = [formatter dateFromString:dateString];

    return date;
}




+ (NSString *)stringWithDate:(NSDate *)date withFormatterString:(NSString *)formatterStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];//转换成中国时区
    
    [dateFormatter setDateFormat:formatterStr];
    
    NSString *time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];

    return time;
}

+ (NSString *)getStingWithDateSting:(NSString *)dateString withFormatterString:(NSString *)formatterStr withInputString:(NSString*)inputStr{
    NSDate* date = [self dateFromString:dateString withFormatterString:formatterStr];
    NSString* time = [self stringWithDate:date withFormatterString:inputStr];
    return time;
}


@end
