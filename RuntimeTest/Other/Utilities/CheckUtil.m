//
//  CheckUtil.m
//  RuntimeTest
//
//  Created by desmond on 16/7/5.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "CheckUtil.h"

@implementation CheckUtil

+ (BOOL) isStrEmpty:(NSString*)string{
	if (!string || [string isEqualToString:@""]) {
		return YES;
	} else {
		return NO;
	}
}

+ (void) showAlertWithMessage:(NSString*)message delegate:(id)delegate{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
	[alert show];
}

@end
