//
//  WeeklyItemStageModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/28.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemStageModel.h"
#import "NetTool.h"
#import "WeeklyItemStageModel.h"

@implementation WeeklyItemStageModel

+ (void)weeklyItmeStageRequestURL:(NSString *)urlString success:(successBlock)successBlock{
	
	[NetTool GET:urlString parameters:nil complete:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
		
		if (!error) {
			
			[WeeklyItemStageModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
				
				return @{@"stageId":@"id"};
				
			}];
			
			
			NSArray *array = [WeeklyItemStageModel mj_objectArrayWithKeyValuesArray:responseObject[@"items"]];
			
			successBlock(array);
			
		}else{
			
			NSLog(@"%@",error);
		}
		
	}];
}

- (NSString *)time{
	
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_time longLongValue] / 1000];
	
	NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
	
	[fmt setDateFormat:@"MM月d日"];
	
	NSString *dateString = [fmt stringFromDate:date];
	
	if ([dateString hasPrefix:@"0"]) {
		
		dateString = [dateString substringFromIndex:1];
	}
	
	return dateString;
}

@end
