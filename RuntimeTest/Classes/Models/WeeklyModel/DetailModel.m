//
//  DetailModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DetailModel.h"
#import "NetTool.h"
#import "ImageModel.h"
#import "NSObject+MJProperty.h"
#import "NSObject+MJKeyValue.h"

@implementation DetailModel

/**
 *  请求详情页面的数据 字典装模型
 *
 *  @param detailTextId 文章的id
 */
+(void)detileNewsModelGetWithdetailTextId:(NSString *)detailTextId success:(successBlock)successback{
	
	NSString *urlstring = [NSString stringWithFormat:kDetatilURL,detailTextId];
	
	[NetTool GET:urlstring parameters:nil complete:^(NSURLSessionDataTask *operation, id responseObject, NSError *error) {
		
		if (!error) {
			
			//替换字典中的关键字
			[ImageModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
				
				return @{@"image_id":@"id"};
			}];
			
			[DetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
				
				return @{@"detatilArticleId":@"id"};
			}];
			
			//HZYDetailModel images属性里面要装的模型类
			[DetailModel mj_setupObjectClassInArray:^NSDictionary *{
				//找你找的好苦，还不到碗里来。
				return @{@"images":@"ImageModel"};
				//[HZYImageModel class]
				
			}];
			
			DetailModel *model = [DetailModel mj_objectWithKeyValues:responseObject[@"article"]];
			
			successback(model);
			
		}
	}];
}

@end
