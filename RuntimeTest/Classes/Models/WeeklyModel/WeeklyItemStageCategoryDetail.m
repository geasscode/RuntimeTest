//
//  WeeklyItemStageCategoryDetail.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemStageCategoryDetail.h"

@implementation WeeklyItemStageCategoryDetail


- (instancetype)initWithDict:(NSDictionary *)dict{
	
	if (self = [super init]) {
		
		[self setValuesForKeysWithDictionary:dict];
	}
	
	return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict{
	
	return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
	
	
}
@end
