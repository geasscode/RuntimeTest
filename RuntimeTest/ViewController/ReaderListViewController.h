//
//  ReaderListViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/7/18.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DESSearchControllerBaseViewController.h"



@interface ReaderListBaseViewController : UITableViewController

@property (readonly, copy) NSArray *visibleResults;

@end

@interface ReaderListViewController : ReaderListBaseViewController

@end
