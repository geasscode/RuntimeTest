//
//  DBHelper.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"
@implementation DBHelper

//@property (nonatomic,copy) NSString *detatilArticleId;
///**
// *  文章的title
// */
//@property (nonatomic,copy) NSString *title;
///**
// *  时间
// */
//@property (nonatomic,copy) NSString *time;
///**
// *  文章所属
// */
//@property (nonatomic,copy) NSString *feed_title;
///**
// *  文章的URL
// */
//@property (nonatomic,copy) NSString *url;
///**
// *  文章的内容
// */
//@property (nonatomic,copy) NSString *content;
///**
// *  文章中的图片数组
// */
//@property (nonatomic,strong) NSArray *images;
FMDatabase *db = nil;
//打开数据库
+ (void)openDataBase {
	db = [FMDatabase databaseWithPath:[self getHomePath:@"geassDB.sqlite"]];
	if (![db open]) {
		return;
	}
	//为数据库设置缓存，提高性能
	[db setShouldCacheStatements:YES];
}

//创建收藏表
+ (void)createTable {
	//判断表是否创建
	[self openDataBase];
	[db executeUpdate:@"create table if not exists t_favorite(id integer primary key autoincrement, title text, url text, detatilArticleId text, feed_title text)"];
	
	//hasRead 设为 integer 插入不了，直接crash。 只好换成 text 类型。用 “true” “false” 区分。
	[db executeUpdate:@"create table if not exists t_readerList(id integer primary key autoincrement, title text , url text , detatilArticleId text , feed_title text ,hasRead text)"];
	[db close];
}
//插入一条收藏信息
+ (BOOL)insertData:(DetailModel *)model {
	[self createTable];
	[self openDataBase];
	//处理为空
	if ([model.title isEqualToString:@""] || !model.title) {
		return NO;
	}
	FMResultSet *rs = [db executeQuery:@"select * from t_favorite where title=?", model.title];
	//已经存在
	if ([rs next]) {
		[rs close];
		[db close];
		return NO;
	} else {
		[db executeUpdate:@"insert into t_favorite(title, url, detatilArticleId, feed_title) values(?, ?, ?, ?)", model.title, model.url, model.detatilArticleId, model.feed_title];
		[db close];
		return YES;
	}
	
}


+ (BOOL)insertReaderList:(DetailModel *)model {
	[self createTable];
	[self openDataBase];
	//处理为空
	if ([model.title isEqualToString:@""] || !model.title) {
		return NO;
	}
	FMResultSet *rs = [db executeQuery:@"select * from t_readerList where title = ?", model.title];
	//已经存在
	if ([rs next]) {
		[rs close];
		[db close];
		return NO;

	} else {
		[db executeUpdate:@"insert into t_readerList(title, url, detatilArticleId, feed_title,hasRead) values(?, ?, ?, ?,?)", model.title, model.url, model.detatilArticleId, model.feed_title,model.hasRead];
		[db close];
		return YES;
	}
	
}
//删除一条收藏信息
+ (void)deleteData:(NSInteger)id {
	[self openDataBase];
	[db executeUpdate:@"delete from t_favorite where id=?",[NSString stringWithFormat:@"%ld", (long)id]];
	[db close];
}


+ (void)deleteReaderList:(NSInteger)id {
	[self openDataBase];
	[db executeUpdate:@"delete from t_readerList where id=?",[NSString stringWithFormat:@"%ld", (long)id]];
	[db close];
}


//返回查询数据结果
+ (NSMutableArray *)getListData {
	[self createTable];
	[self openDataBase];
	NSMutableArray *listArr = [NSMutableArray array];
	FMResultSet *rs = [db executeQuery:@"select * from t_favorite"];
	while ([rs next]) {
		DetailModel *model = [[DetailModel alloc] init];
//		插入int id
		model.id = [rs intForColumn:@"id"];

		model.title = [rs stringForColumn:@"title"];
		model.url = [rs stringForColumn:@"url"];
		model.detatilArticleId =  [rs stringForColumn:@"detatilArticleId"];
		model.feed_title = [rs stringForColumn:@"feed_title"];
		[listArr addObject:model];
	}
	[rs close];
	[db close];
	return listArr;
}



+ (NSMutableArray *)getReaderList {
	[self createTable];
	[self openDataBase];
	NSMutableArray *listArr = [NSMutableArray array];
	
//	Sqlite没有单独的布尔存储类型，它使用INTEGER作为存储类型，0为false，1为true ,设为integer之后插入不了，只能设为text 类型
//以"true","false"区分更加形象。
		FMResultSet *rs = [db executeQuery:@"select * from t_readerList where hasRead = 'false'"];
	while ([rs next]) {
		DetailModel *model = [[DetailModel alloc] init];
		//		插入int id
		model.id = [rs intForColumn:@"id"];
		
		model.title = [rs stringForColumn:@"title"];
		model.url = [rs stringForColumn:@"url"];
		model.detatilArticleId =  [rs stringForColumn:@"detatilArticleId"];
		model.feed_title = [rs stringForColumn:@"feed_title"];
		model.hasRead = [rs stringForColumn:@"hasRead"];
		[listArr addObject:model];
	}
	[rs close];
	[db close];
	return listArr;
}

+ (NSString *)getHomePath:(NSString *)databaseName {
	return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:databaseName];
}

@end
