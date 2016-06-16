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
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@class Store;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>
+ (instancetype)sharedDelegate;

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

