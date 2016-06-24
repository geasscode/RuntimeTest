//
//  DESSearchResultsViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/6/22.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESSearchControllerBaseViewController.h"

extern NSString *const DESSearchResultsViewControllerStoryboardIdentifier;

@interface DESSearchResultsViewController : DESSearchControllerBaseViewController<UISearchResultsUpdating,UISearchBarDelegate>

#pragma mark - UISearchResultsUpdating



@end
