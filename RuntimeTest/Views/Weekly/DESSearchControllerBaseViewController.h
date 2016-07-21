//
//  DESSearchControllerBaseViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/6/22.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DESSearchControllerBaseViewController : UITableViewController

@property (nonatomic, copy) NSString *filterString;
@property (readonly, copy) NSArray *visibleResults;
@property (readonly, copy) NSString *navigationTitle;


@end
