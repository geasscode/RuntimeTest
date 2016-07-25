//
//  AccountTool.h
//  RuntimeTest
//
//  Created by desmond on 16/7/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSettings.h"

@interface AccountTool : NSObject


/**
 *  保存用户信息
 *
 *  @param user user obj
 */
+ (void)saveUserInformation:(UserSettings*)user;

/**
 *  获取存储的user信息
 *
 *  @return user obj
 */
+ (UserSettings*)getUserInformation;

/**
 *  删除保存的用户信息
 */
+ (void)deleteUserInfomation;

@end
