//
//  DESWebViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/6/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DESWebViewController : UIViewController

@end


@interface UIViewController (DESPublic)
///该vc的navigationController
- (UINavigationController*)des_navigationController;
@end
