//
//  topicModel.m
//  RuntimeTest
//
//  Created by desmond on 16/8/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

- (NSMutableArray *)subscribeItems
{
	if(!_subscribeItems)
	{
		_subscribeItems = [NSMutableArray array];
	}
	return _subscribeItems;
}

@end
