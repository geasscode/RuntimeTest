//
//  AllUtils.h
//  RuntimeTest
//
//  Created by desmond on 16/7/8.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllUtils : NSObject

+ (NSString *)getDateFromString:(NSString*)date;

+ (UIAlertController*)showPromptDialog:(NSString*)title andMessage:(NSString*)message OKButton:(NSString*)OKButtonTitle OKButtonAction:(void (^)(UIAlertAction *action))OKButtonHandler cancelButton:(NSString*)cancelButtonTitle cancelButtonAction:(void (^)(UIAlertAction *action))cancelButtonHandler contextViewController:(UIViewController*)contextViewController;

+ (void)jumpToViewController:(NSString*)viewControllerIdentifier contextViewController:(UIViewController*)contextViewController handler:(void (^)(void))handler;

@end
