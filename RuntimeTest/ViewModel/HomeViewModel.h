//
//  HomeViewModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject


//处理网络获取的数据
- (void)handleDataWithSuccess:(void (^)(NSArray *arr))success
					  failure:(void(^)(NSError *error))failure;
@end
