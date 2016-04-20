//
//  NavigationItem.h
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^coverDidRomove)();

@interface NavigationItem : UIViewController

//** 遮盖按钮 */
@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, strong) coverDidRomove coverDidRomove;

@property (nonatomic, assign) BOOL isScale;

- (void)coverClick;

/** 点击缩放按钮 */
- (void)rightClick;
@end
