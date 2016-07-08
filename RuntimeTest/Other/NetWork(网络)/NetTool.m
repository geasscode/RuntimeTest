//
//  NetTool.m
//  MVVM-demo
//
//  Created by shen_gh on 16/4/12.
//  Copyright © 2016年 申冠华. All rights reserved.
//

#import "NetTool.h"
#import "AFNetworking.h"

@implementation NetTool

//单例，每次只允许一次网络请求
+ (NetTool *)shareManager{
    static NetTool *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //一次只允许一个请求
        if (manager==nil) {
            manager=[[NetTool alloc]init];
        }
    });
    return manager;
}

/** 单例一个AFHTTPSessionManager */
+ (AFHTTPSessionManager *)defaultManager {
	static AFHTTPSessionManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		// 1.获得请求管理者
		manager = [AFHTTPSessionManager manager];
		// 设置接受解析的内容类型
		manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"text/javascript",@"application/json", nil];
		//设置超时时间为10s
		manager.requestSerializer.timeoutInterval = 10;

		//下面这两句不是必须的。
		NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/3.19",[UIDevice currentDevice].name];
		[manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
		
		[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];


	});
	return manager;
}

- (void)httpGetRequest:(NSString *)url withParameter:(NSDictionary *)parameter success:(void (^)(Response *response))success failure:(void (^)(NSError *error))failure{
    
    NSLog(@"........get request url:%@",url);
    NSLog(@"........参数parameters:%@",parameter);
	
	
	AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
	// 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
//	sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
	
//	sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
	sessionManager.securityPolicy.allowInvalidCertificates = YES;
	
	
	
	//2.0语法
	//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
	//    manager.securityPolicy.allowInvalidCertificates=YES;
	
	//每次开始下载任务前做如下判断
	NSMutableArray *requestArray=[NSMutableArray array];
	for (NSString *request in requestArray) {
		if ([url isEqualToString:request]) {
			return;
		}
	}
	[requestArray addObject:url];
	
	
	[sessionManager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
		NSLog(@"%lld", downloadProgress.totalUnitCount);
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		//NSString *responseString=[operation responseString];
		//NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
		
//				NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
		//由于之前用的是AFNetworking2.0 现改用3.0.4，找不到无痛的处理方法，分分钟要重写，现在使用最简单粗暴无痛的方法暂时代替。
		
		NSArray *data = responseObject[@"data"];
		NSString *msg = responseObject[@"msg"];
		NSInteger status=[responseObject[@"status"] integerValue];
		NSDictionary *jsonDic  = @{@"data":data,@"msg":msg,@"status":@(status)};
	
		Response *responseObj=[[Response alloc]initWithDictionary:jsonDic];
		success(responseObj);
		[requestArray removeObject:url];
		NSLog(@"%@", responseObject);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		failure(error);
		[requestArray removeObject:url];
		NSLog(@"%@",error);
	}];
	
//    [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *responseString=[operation responseString];
//        NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        Response *responseObj=[[Response alloc]initWithDictionary:jsonDic];
//        
//        success(responseObj);
//        [requestArray removeObject:url];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//            [requestArray removeObject:url];
//        }
//    }];
}
+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)para complete:(CompleteBlock)complete{
	
	
//	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//	
//	// manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"", nil];
//	
//	NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/3.19",[UIDevice currentDevice].name];
//	[manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//	
////	HZYUserLoginModel *loginModel = [HZYUserLoginModel sharedUserLoginModel];
////	if (loginModel.isLogin) {
////		
////		[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:loginModel.name password:loginModel.token];
////	}else{
////		
//		[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];
////	}
	
	[[self defaultManager] GET:URLString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		complete(task,responseObject,nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		complete(task,nil,error);
	}];

}


+ (void)POST:(NSString *)URLString parameter:(NSDictionary *)parameter complete:(CompleteBlock)complete{
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	
	NSString *userAgent = [NSString stringWithFormat:@"%@",[UIDevice currentDevice].name];
	
	//声明请求的结果为JSON类型
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	[manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
	
	[manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	
	[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];
	
	
	[manager POST:URLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		complete(task,responseObject,nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		complete(task,nil,error);

	}];

}

@end
