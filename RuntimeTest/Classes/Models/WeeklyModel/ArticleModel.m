
//
//  ArticleModel.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ArticleModel.h"
#import "ArticleTool.h"

//引入的文件如果缺少@end，他会提示你，不要以为只有本文件缺少@end才会报错。
@implementation ArticleModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
	
	[aCoder encodeObject:self.articleId forKey:@"id"];
	[aCoder encodeObject:self.title forKey:@"title"];
	[aCoder encodeObject:self.time forKey:@"time"];
	[aCoder encodeObject:self.rectime forKey:@"rectime"];
	[aCoder encodeObject:self.uts forKey:@"uts"];
	[aCoder encodeObject:self.feed_title forKey:@"feed_title"];
	[aCoder encodeObject:self.img forKey:@"img"];
	
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	
	if (self = [super init]) {
		self.articleId = [aDecoder decodeObjectForKey:@"id"];
		self.title = [aDecoder decodeObjectForKey:@"title"];
		self.time = [aDecoder decodeObjectForKey:@"time"];
		self.rectime = [aDecoder decodeObjectForKey:@"rectime"];
		self.uts = [aDecoder decodeObjectForKey:@"uts"];
		self.feed_title = [aDecoder decodeObjectForKey:@"feed_title"];
		self.img = [aDecoder decodeObjectForKey:@"img"];
		
	}
	return self;
	
}

/**
 *  请求article数据
 *  @param title        请求数据的标题
 */
+(void)articleModelGetDataWithURLString:(NSString *)URLString title:(NSString *)title parameters:par successblack:(successBlock)successblock{
	
	[SVProgressHUD show];
	
	[NetTool GET:URLString parameters:nil complete:^(NSURLSessionDataTask *operation, id responseObject, NSError *error) {
		
		if (!error) {
			
			//替换数据中的关键字属性
			[ArticleModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
				
				return @{@"articleId":@"id"};
			}];
			
			//使用MJExtension将字典数组转成模型数组
			NSArray *num = [self mj_objectArrayWithKeyValuesArray:responseObject[@"articles"]];
			
			//只缓存了热门的数据
			if ([title isEqualToString:@"热门"]) {
				[ArticleTool addArticalWithArray:num.copy];
			}
			
			successblock(num.copy);
			
			[SVProgressHUD dismiss];
			
		}else{
			
			[SVProgressHUD showImage:[UIImage imageNamed:@"fail_result"] status:@"加载失败"];
			NSLog(@"%@",error);
		}
		
	}];
}


@end

