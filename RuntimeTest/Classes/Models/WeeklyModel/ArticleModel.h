//
//  ArticleModel.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(NSArray *modelArray);

@interface ArticleModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *articleId;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *rectime;

@property (nonatomic,copy) NSString *uts;

@property (nonatomic,copy) NSString *feed_title;

@property (nonatomic,copy) NSString *img;

//@property (nonatomic,assign) BOOL hasRead;


/**
 *  请求指定标题的数据
 */
+(void)articleModelGetDataWithURLString:(NSString *)URLString title:(NSString *)title parameters:para successblack:(successBlock)successblock;

@end