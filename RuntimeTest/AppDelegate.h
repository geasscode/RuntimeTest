//
//  AppDelegate.h
//  RuntimeTest
//
//  Created by desmond on 16/3/17.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"e0418a16e57dc8de664b6d64";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;
//static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
#define UMENG_APPKEY @"5768b29be0f55a3b24002ff2"

@class Store;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

+ (instancetype)sharedDelegate;

@property (strong,nonatomic) NSString *GLOBAL_USERID;//全局的objectID;当前的用户ID；
@property (strong,nonatomic) NSString *GLOBAL_USERNAME;//全局的用户名,也就是手机号；
@property (strong,nonatomic) NSString *GLOBAL_NICKNAME;//全局的昵称；
@property (strong,nonatomic) NSString *GLOBAL_PASSWORD;//全局的密码；

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (readonly, strong, nonatomic) Store *store;

/**
 *  用户id
 */
@property (strong, nonatomic) NSString *userID;

/**
 *  认证口令
 */
@property (strong, nonatomic) NSString *access_token;

/**
 *  刷新access_token 口令
 */
@property (strong, nonatomic) NSString *refresh_token;

/**
 *  过期时间
 */
@property (strong ,nonatomic) NSDate *expirationDate;


/**
 *  获得appdelegate单例
 *
 *  @return appdelegate对象
 */
+ (AppDelegate*)sharedAppdelegate;

-(void)getWXCodeStringWithController:(id)vc;

@end

