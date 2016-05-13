//
//  ContentTableViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewController : UITableViewController
/**
 *  请求界面的URL
 */
@property (nonatomic,copy) NSString *urlstring;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *titlename;

@end
