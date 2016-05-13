//
//  TitleModel.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

/** MJExtension 头文件已经在pch文件里引入了
 
 *  获得plist文件中的数据转成模型
 */
+(NSArray *)titleModelGetModelArrayWith:(NSString *)plistName{
	
	NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
	
	NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
	
	return [self mj_objectArrayWithKeyValuesArray:plistArray];
}

@end
