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


#pragma mark - 头部滚动视图
/**  是否有滚动视图 */
@property (nonatomic,assign,getter=isExitsScrollView) BOOL exitsScrollView;
/** 滚动展示栏(焦点图)的图片数量 */
@property (nonatomic,assign) NSInteger focusImgNumber;
@property(nonatomic,strong) NSArray *imageList;
/** 滚动展示栏(焦点图)的图片地址 */
- (NSURL *)focusImgURLForIndex:(NSInteger)index;

@end
