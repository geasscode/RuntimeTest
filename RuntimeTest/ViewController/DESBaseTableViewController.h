//
//  DESBaseTableViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/7/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DESBaseTableViewController : UITableViewController

@property (nonatomic,assign) BOOL isLogin;

@property (nonatomic,strong) NSArray *itemModelArray;

@property (nonatomic,strong) UIButton *footView;

@end
