//
//  UserSettings.h
//  RuntimeTest
//
//  Created by desmond on 16/7/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettings : NSObject<NSCoding>


/**
 *  用户id
 */
@property (nonatomic, assign) NSInteger id;
/**
 *  用户大头像
 */
@property (nonatomic, copy) NSString *avatar_large;

/**
 *  用户个性签名
 */
@property (nonatomic, copy) NSString *userDescription;

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *password;


/**
 *  性别  m / man
 */
@property (nonatomic, copy) NSString *gender;


@property (nonatomic, assign)BOOL hasLocalUser;

@property (nonatomic, copy) NSString *userID;

@end
