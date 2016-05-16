//
//  DetailModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

typedef void (^successBlock) (DetailModel *);


@property (nonatomic, assign) NSInteger id;

/**
 *  文章的id
 */
@property (nonatomic,copy) NSString *detatilArticleId;
/**
 *  文章的title
 */
@property (nonatomic,copy) NSString *title;
/**
 *  时间
 */
@property (nonatomic,copy) NSString *time;
/**
 *  文章所属
 */
@property (nonatomic,copy) NSString *feed_title;
/**
 *  文章的URL
 */
@property (nonatomic,copy) NSString *url;
/**
 *  文章的内容
 */
@property (nonatomic,copy) NSString *content;
/**
 *  文章中的图片数组
 */
@property (nonatomic,strong) NSArray *images;

//获得详情页面模型数据
+(void)detileNewsModelGetWithdetailTextId:(NSString *)detailTextId success:(successBlock)successback;

@end
