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

@class Store;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
+ (instancetype)sharedDelegate;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (readonly, strong, nonatomic) Store *store;

@end

