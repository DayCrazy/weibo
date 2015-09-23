//
//  WeiboModel.m
//  weibo
//
//  Created by 李丹阳 on 15/8/22.
//  Copyright (c) 2015年 李丹阳. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"

@implementation WeiboModel


- (NSDictionary *)attributeMapDictionary{
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}


- (void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    
    if (self.source!= nil) {
        NSString* regex = @">.+<";
        NSArray* item = [self.source componentsMatchedByRegex:regex];
        if (item.count != 0) {
            NSString* temp = item[0];
            temp = [temp substringWithRange:NSMakeRange(1, temp.length-2)];
            self.source = [NSString stringWithFormat:@"来源:%@",temp];
        }
    }
    
    NSDictionary* userDic = [dataDic objectForKey:@"user"];
    if (userDic!= nil) {
        self.userModel = [[userModel alloc]initWithDataDic:userDic];
    }
    
    NSDictionary* reDic = [dataDic objectForKey:@"retweeted_status"];
    if (reDic!= nil) {
        self.reWeibo = [[WeiboModel alloc]initWithDataDic:reDic];
    }
    
    // 替换文本中的表情符
    NSString* regex = @"\\[\\w+\\]";
    NSArray* faceItems = [self.text componentsMatchedByRegex:regex];
    
    NSString* configPath = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray* faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString* faceName in faceItems) {
        
        NSString* t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:t];
        NSArray* items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if (items.count >0) {
            
            NSDictionary* itemDic = items[0];
            NSString* imageName = [itemDic objectForKey:@"png"];
            NSString* replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
        }
    }
}

@end
