//
//  BaseTableViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MemberType) {
	MemberTypeEmployee,
	MemberTypeManager,
};

@interface BaseTableViewController : UITableViewController

@property (nonatomic, assign) MemberType type;

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg;

@end
