//
//  Sign.m
//  Project
//
//  Created by kain on 16/6/6.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "Sign.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Sign
//获得系统时间
+(NSString*)getSystemTime{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    long long a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%lld", a];
    return timeString;
}
//系统时间格式化
+(NSString*)timeFormat:(NSString*)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:[time longLongValue]/1000.0];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
}

//生成sign
+(NSString*)sign:(NSDictionary*)dicParamer time:(NSString *)time{
    return [self generateCommonSign:time Paramer:dicParamer];
}


+(NSString*)getMd5SignFromMap:(NSDictionary*)dicParamer{
    NSArray *keyArray = [dicParamer allKeys];
    //key值按升序排列
    NSArray *sortedArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *md5Sign = @"";
    for (int i = 0; i<[sortedArray count]; i++) {
        NSString *key = [sortedArray objectAtIndex:i];
        NSString *value = [NSString stringWithFormat:@"%@",[dicParamer objectForKey:key]];
        if (![key isEqualToString:@""]&&![key isEqualToString:@"sign"]&&![key isEqualToString:@"time"]) {
            md5Sign = [md5Sign stringByAppendingString:value];
        }
    }
    return md5Sign;
}

//获取索引值
+(NSInteger)getDynamicIndex:(NSString*)time timeStamp:(NSString*)timestamp{
    NSInteger index;
    NSInteger week;
    //获取当前星期
    week = (double)[self getWeekOfDate] ;
    
    long long d = [timestamp doubleValue];
    index = d%week;
    if (index == 0) {
        index =7;
    }
    [self getSystemTime];
    index =(32-index);
    return index;
}

+(NSInteger)getWeekOfDate{
    NSInteger week;
    int weekOfDays[7] = {7,1,2,3,4,5,6};
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:dat];
    week = [theComponents weekday]-1;
    if (week<0) {
        week = 0;
    }
    
    return weekOfDays[week];
}
//返回签名
+(NSString*)generateCommonSign:(NSString*)time Paramer:(NSDictionary*)paramer{
    NSString *md5Sign = [self getMd5SignFromMap:paramer];
   NSDictionary *dic= [self getDynamicValues:time md5Sign:md5Sign];
    for (NSString *key in dic) {
        if ([key length] <=7 && [dic[key] length] <=7) {
            return [self md5HexDigest:[key stringByAppendingString:dic[key]]];
        }
    }
   
    return NULL;
}
//获取动态字典
+(NSDictionary *) getDynamicValues:(NSString*)time md5Sign:(NSString*)md5Sign{
    NSInteger dyNamicIndex = [self getDynamicIndex:[self timeFormat:time] timeStamp:time];
    NSString *str = [NSString stringWithFormat:@"%@%@",md5Sign,time];
    md5Sign = [self md5HexDigest:str];
    NSString *stringValue = [md5Sign substringFromIndex:dyNamicIndex];
    NSString *md5Time = [self md5HexDigest:time];
    NSString *stringKey = [md5Time substringFromIndex:dyNamicIndex];
     NSMutableDictionary *kv = [NSMutableDictionary new];
    [kv setValue:stringValue forKey:stringKey];
    return kv;
}
+ (NSString*)md5HexDigest:(NSString*)str{
    const char* cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}

@end
