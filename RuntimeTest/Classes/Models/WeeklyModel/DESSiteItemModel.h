//
//  DESSiteItemModel.h
//  RuntimeTest
//
//  Created by desmond on 16/7/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SuccessBlock)(NSArray *itemArray);
typedef void(^CompletBlock)(NSArray *itemArray ,SuccessBlock *successBlock);
@interface DESSiteItemModel : NSObject
/*
 "id": "YRVbMz",
 "followed": false,
 "name": "High Scalability",
 "image": "http://stimg0.tuicool.com/YRVbMz.png",
 "lang": 2,
 "cover": "http://aimg2.tuicool.com/zU3aYr.png"
 */
@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *followed;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *lang;

@property (nonatomic,copy) NSString *cover;

@property (nonatomic,copy) NSString *count;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,assign) BOOL didSelected;

+(void)siteItemModelWithURLstring:(NSString *)URLString lastArray:(NSArray *)lastArray successblock:(SuccessBlock)successBlock;

@end
