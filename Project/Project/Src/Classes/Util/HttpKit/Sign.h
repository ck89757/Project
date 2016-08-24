//
//  Sign.h
//  Project
//
//  Created by kain on 16/6/6.
//  Copyright © 2016年 kain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sign : NSObject
+(NSString*)sign:(NSDictionary*)dicParamer time:(NSString *)time;
+(NSString*)getSystemTime;
@end
