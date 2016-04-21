//
//  ContactModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/21.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "JSONModel.h"

@interface ContactModel : JSONModel

@property (nonatomic,strong) NSString <Optional>*portrait;
@property (nonatomic,strong) NSString <Optional>*name;
@property (nonatomic,strong) NSString <Ignore>*pinyin;//拼音

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
