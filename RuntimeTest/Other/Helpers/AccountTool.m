//
//  AccountTool.m
//  RuntimeTest
//
//  Created by desmond on 16/7/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool

+ (void)saveUserInformation:(UserSettings *)user {
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
	
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
}

+ (UserSettings*)getUserInformation {
	
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
	
	UserSettings *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	return user;
}

+ (void)deleteUserInfomation {
	
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user"];
}
@end
