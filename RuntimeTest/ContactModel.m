//
//  ContactModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/21.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ContactModel.h"

#import "NSString+Utils.h"//category

@implementation ContactModel

- (void)setName:(NSString<Optional> *)name{
	if (name) {
		_name=name;
		_pinyin=_name.pinyin;
	}
}

- (instancetype)initWithDic:(NSDictionary *)dic{
	NSError *error = nil;
	self =  [self initWithDictionary:dic error:&error];
	return self;
}

@end
