//
//  WeeklyItemModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemModel.h"
#import "WeeklyItemStageModel.h"
#import "NetTool.h"



@implementation WeeklyItemModel


+ (void)weeklyItemRequestURL:(NSString *)urlString success:(successBlock)success{
	
//	[SVProgressHUD show];
	[SVProgressHUD showWithStatus:@"正在为你加载，请稍候。"];

	
	[NetTool GET:urlString parameters:nil complete:^( NSURLSessionTask *operation, id responseObject, NSError *error) {
		
		if (!error) {
			
			[WeeklyItemStageModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
				
				return @{@"stageId":@"id"};
			}];
			
			[WeeklyItemModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
				
				return @{@"weeklyItemStage":@"items"};
			}];
			
			[WeeklyItemModel mj_setupObjectClassInArray:^NSDictionary *{
				
				return @{@"weeklyItemStage":[WeeklyItemStageModel class]};
				
			}];
			
			NSArray *array = [WeeklyItemModel mj_objectArrayWithKeyValuesArray:responseObject[@"items"]];
			
			success(array);
			
			[SVProgressHUD dismiss];

		}else{
			
			[SVProgressHUD showImage:[UIImage imageNamed:@"fail_result"] status:@"加载失败"];
			NSLog(@"error");
		}
		
	}];
}


@end
