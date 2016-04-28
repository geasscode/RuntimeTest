//
//  HomeViewModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "HomeViewModel.h"
#import "APIClient.h"
#import "HomeModel.h"

@implementation HomeViewModel

//处理网络获取的数据
- (void)handleDataWithSuccess:(void (^)(NSArray *arr))success failure:(void(^)(NSError *error))failure{
	
	[[APIClient sharedManager] netWorkGetHomePageListWithPageSize:20 pageNum:0 success:^(Response *respone) {
		
		NSLog(@".......respone.description : %@",respone.description);
		if (respone.status==kEnumServerStateSuccess) {
			NSLog(@"请求成功!");
			
			NSMutableArray *tmpArr=[NSMutableArray array];
			for (NSDictionary *subDic in (NSArray *)[respone.data valueForKey:@"results"]) {
				HomeModel *model=[[HomeModel alloc]initWithDic:subDic];
				[tmpArr addObject:model];
			}
			success(tmpArr);
		}
	} failure:^(NSError *error) {
		failure(error);
	}];
}


@end
