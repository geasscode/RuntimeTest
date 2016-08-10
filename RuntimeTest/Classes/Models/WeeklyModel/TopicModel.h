//
//  topicModel.h
//  RuntimeTest
//
//  Created by desmond on 16/8/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscribeModel.h"

@interface TopicModel : NSObject

@property (nonatomic , assign) NSInteger subId;
@property (nonatomic,strong) NSString *topicName;
@property (nonatomic,strong)SubscribeModel *subscribeModel;

/** 这个类别对应的用户数据 */
@property (nonatomic , strong) NSMutableArray *subscribeItems;

@end
