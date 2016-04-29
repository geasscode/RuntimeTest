//
//  WeeklyItemStageDetailModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemStageDetailModel.h"
#import "WeeklyItemStageCategoryDetail.h"
#import "CategoryDetailFrameModel.h"
#import "NetTool.h"

@implementation WeeklyItemStageDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict{
	
	if (self = [super init]) {
		
		[self setValuesForKeysWithDictionary:dict];
		
		NSMutableArray *array = [NSMutableArray array];
		for (NSDictionary *dict1 in self.items) {
			
			WeeklyItemStageCategoryDetail *detail = [WeeklyItemStageCategoryDetail modelWithDict:dict1];
			
			CategoryDetailFrameModel *frameModel = [[CategoryDetailFrameModel alloc] init];
			
			frameModel.detailModel = detail;
			
			[array addObject:frameModel];
		}
		_items = array;
	}
	
	return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict{
	
	return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
	
	
}

+ (void)stageDetailRequestURL:(NSString *)urlString success:(successBlock)success{
	
	[NetTool GET:urlString parameters:nil complete:^(NSURLSessionDataTask *operation, id responseObject, NSError *error) {
		
		if (!error) {
			
			NSArray *rootArray = responseObject[@"items"];
			
			NSMutableArray *array = [NSMutableArray array];
			
			for (NSDictionary *dict in rootArray) {
				
				WeeklyItemStageDetailModel *model = [WeeklyItemStageDetailModel modelWithDict:dict];
				
				[array addObject:model];
			}
			
			success(array);
			
		}else{
			
			NSLog(@"%@",error);
		}
		
	}];
}

@end
