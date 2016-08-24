//
//  HttpKit.h
//  Project
//
//  Created by kain on 16/6/3.
//  Copyright © 2016年 kain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"//AFNetworking
@interface HttpKit : NSObject

typedef void (^MyCallback)(id obj);

/**
 *  网络请求方法
 *
 *  @param url          将要访问的链接
 *  @param param        传入的参数
 *  @param requestStyle 请求方式
 *  @param serializer   数据返回形式
 *  @param success      请求成功后调用
 *  @param failure      请求失败后调用
 */

+ (void)GET:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header  success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;
+ (void)POST:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header  success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;


+ (void)GETAF:(NSString *)url param:(NSDictionary *)param success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;
+ (void)POSTAF:(NSString *)url param:(NSDictionary *)param success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;
@end
