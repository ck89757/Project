//
//  HttpKit.m
//  Project
//
//  Created by kain on 16/6/3.
//  Copyright © 2016年 kain. All rights reserved.
//
#pragma mark 开发API
/*
 说明：
 生产环境https://passport.utouu.com/
 开发环境https://passport.dev.utouu.com/
 测试环境https://passport.test.utouu.com/
 */

#define HTTPS_URL_HEAD @"https://passport.test.utouu.com/"


#import "HttpKit.h"
#import "AFNetworking.h"
#import "Sign.h"
#import "AFSecurityPolicy.h"
//#import "MBProgressHUD+MJ.h"//mj进一步封装的显示进程的类。

@implementation HttpKit

/**
 *  网络请求方法GET
 *
 *  @param url          将要访问的链接
 *  @param param        传入的参数.可以传入NSDictionary也可以传入@{@“a”:@"1",@"b":@"2"}
 *  @param success      请求成功后调用
 *  @param failure      请求失败后调用
 */
+ (void)GET:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header  success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(param!=nil){
        for (NSString *key in param) {
            if([key isEqualToString:@"service"]){
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            }
        }
    }
    
    NSMutableDictionary * headDic = [self getSTHeadDictionary:header params:param strurl:url];
    
    for (NSString *key in [headDic allKeys]) {
        NSString *value = [headDic objectForKey:key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    
    [manager POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self logicSuccess:@"POST" responseObject:responseObject callback:^(id obj) {
            success(responseObject);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self logicError:@"POST" error:(NSError *)error callback:^(id obj) {
            failure(error);
        }];
    }];
    
}


/**
 *  网络请求方法POST
 *
 *  @param url          将要访问的链接
 *  @param param        传入的参数。可以传入NSDictionary也可以传入@{@“a”:@"1",@"b":@"2"}
 *  @param success      请求成功后调用
 *  @param failure      请求失败后调用
 */
+ (void)POST:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header  success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(param!=nil){
        for (NSString *key in param) {
            if([key isEqualToString:@"service"]){
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            }
        }
    }

    NSMutableDictionary * headDic = [self getSTHeadDictionary:header params:param strurl:url];
    
    for (NSString *key in [headDic allKeys]) {
        NSString *value = [headDic objectForKey:key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    
    [manager POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self logicSuccess:@"POST" responseObject:responseObject callback:^(id obj) {
            success(responseObject);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self logicError:@"POST" error:(NSError *)error callback:^(id obj) {
            failure(error);
        }];
    }];
    
    
    
    
}



/*!
 *  @author kain, 16-06-03 14:06:23
 *
 *  @brief AFNetWork原生网络请求(不做自定义)
 *
 *  @param url     请求地址
 *  @param param   请求参数  可以传入NSDictionary也可以传入@{@“a”:@"1",@"b":@"2"}
 *  @param success 返回成功
 *  @param failure 返回失败
 */
+ (void)GETAF:(NSString *)url param:(NSDictionary *)param success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

/*!
 *  @author kain, 16-06-03 14:06:23
 *
 *  @brief AFNetWork原生网络请求(不做自定义)
 *
 *  @param url     请求地址
 *  @param param   请求参数  可以传入NSDictionary也可以传入@{@“a”:@"1",@"b":@"2"}
 *  @param success 返回成功
 *  @param failure 返回失败
 */
+ (void)POSTAF:(NSString *)url param:(NSDictionary *)param success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}






/*!
 *  @author kain, 16-06-03 14:06:11
 *
 *  @brief logic 处理服务器返回数据的业务逻辑
 *
 *  @param Method   GET或者post方法
 *  @param callback  处理完毕的回调函数
 */
+(void)logicSuccess:(NSString *)Method responseObject:(id)responseObject callback:(MyCallback)callback{
    
    
    
    
    callback(responseObject);
}
/*!
 *  @author kain, 16-06-03 14:06:11
 *
 *  @brief logic 处理服务器返回数据的业务逻辑(错误的时候)
 *
 *  @param Method   GET或者post方法
 *  @param callback  处理完毕的回调函数
 */
+(void)logicError:(NSString *)Method error:(NSError *)error callback:(MyCallback)callback{
    //    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    callback(error);
}


+(NSDictionary *)getSTHeadDictionary:(NSDictionary *)header params:(NSDictionary *)dic_params strurl:(NSString*)url{
    
    @try {
        //时间
        NSString *time = [Sign getSystemTime];
        
        //生成sign
        NSString *strSign = [Sign sign:dic_params time:time];
        
        NSString *sign = strSign;
        NSMutableDictionary *head_dic = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
        NSString *version = [NSString stringWithFormat:@"%@.%@",[infoDict objectForKey:@"CFBundleShortVersionString"],versionNum];
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
        if (appName == nil) {
            appName =@"";
        }
        NSString *deviceModel = [[UIDevice currentDevice] model];
        NSString *deviceSys = [[UIDevice currentDevice] systemVersion];
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        NSString *user_agent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",appName,version,deviceModel,deviceSys,screenScale];
        [head_dic setObject:sign forKey:@"cas-client-sign"];
        [head_dic setObject:time forKey:@"cas-client-time"];
        [head_dic setObject:url forKey:@"cas-client-service"];//@"http://app.utouu"
        [head_dic setObject:user_agent forKey:@"User-Agent"];
        [head_dic setObject:@"UTOUU-ST-INVALID" forKey:@"cas-client-st"];
        for (NSString *key in header) {
            NSLog(@"key: %@ value: %@", key, header[key]);
            if([key isEqualToString:@"st"]|| [key isEqualToString:@"cas-client-st"]){
                [head_dic setObject:header[key] forKey:@"cas-client-st"];
            }
        }
        
        
        
        return head_dic;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

@end