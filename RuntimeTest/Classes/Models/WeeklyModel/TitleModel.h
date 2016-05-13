//
//  TitleModel.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *cid;

@property (nonatomic,copy) NSString *urlstring;

+(NSArray *)titleModelGetModelArrayWith:(NSString *)plistName;

@end
