//
//  NetTool.h
//  MVVM-demo
//
//  Created by shen_gh on 16/4/12.
//  Copyright © 2016年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "AFNetworking.h"

typedef void (^CompleteBlock)(NSURLSessionDataTask *operation , id responseObject, NSError *error);

@interface NetTool : NSObject

+ (NetTool *)shareManager;


/**
 *  get请求
 *
 *  @param url     url
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)httpGetRequest:(NSString *)url withParameter:(NSDictionary *)parameter success:(void (^)(Response *response))success failure:(void (^)(NSError *error))failure;


/**
 *  GET请求方式
 */
+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)para complete:(CompleteBlock)complete;
/**
 *  post请求方式
 *
 *  @param URLString 请求的URL
 *  @param parameter 传的参数
 *  @param complete  请求完成的block
 */
+ (void)POST:(NSString *)URLString parameter:(NSDictionary *)parameter complete:(CompleteBlock)complete;


@end
