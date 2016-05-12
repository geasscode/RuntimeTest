//
//  DBHelper.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"


@interface DBHelper : NSObject

//插入收藏数据
+ (BOOL)insertData:(DetailModel *)model;
//删除收藏数据
+ (void)deleteData:(NSInteger)fid;
//获取列表
+ (NSMutableArray *)getListData;

@end
