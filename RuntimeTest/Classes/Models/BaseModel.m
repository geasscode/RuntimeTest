//
//  BaseModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic{
	NSError *error = nil;
	self =  [self initWithDictionary:dic error:&error];
	return self;
}
@end
