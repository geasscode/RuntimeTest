//
//  ArticleTool.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ArticleTool.h"
#import "ArticleModel.h"
#import <FMDatabase.h>

static FMDatabase *_db;

@implementation ArticleTool

+ (void)initialize{
	
	NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"homeData.db"];
	
	_db = [FMDatabase databaseWithPath:filePath];
	
	[_db open];
	
	if (![_db open]) {
		
		return;
	}
	
	
	[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_article_deal(id integer PRIMARY KEY, deal blob NOT NULL, deal_id text NOT NULL);"];
}

/**
 *  将model转成二进制归档到数据库中
 */
+ (void)addArticalWithModel:(ArticleModel *)model{
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
	
	[_db executeUpdateWithFormat:@"insert into t_article_deal(deal,deal_id) values (%@,%@);",data,model.articleId];
}
/**
 *  归档装有model的数组
 */
+ (void)addArticalWithArray:(NSArray *)modelArray{
	
	//删除之前缓存的数据
	[_db executeUpdate:@"delete from t_article_deal;"];
	
	for (ArticleModel *model in modelArray) {
		
		[self addArticalWithModel:model];
	}
}
/**
 *  删除传入的model
 */
+ (void)deleteArticalWithModel:(ArticleModel *)model{
	
	[_db executeUpdateWithFormat:@"delete from t_article_deal where deal_id=%@", model.articleId];
	
}

/**
 *  获得数据库中的模型数据添加到数组并返回
 */
+ (NSArray *)Articalsback{
	
	FMResultSet *set = [_db executeQuery:@"select * from t_article_deal;"];
	
	NSMutableArray *array = [NSMutableArray array];
	while ([set next]) {
		
		NSData *data = [set objectForColumnName:@"deal"];
		ArticleModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		
		[array addObject:model];
	}
	
	return array;
}


@end
