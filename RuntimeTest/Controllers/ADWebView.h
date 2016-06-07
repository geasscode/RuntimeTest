//
//  ADWebView.h
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADWebView : UIViewController

@property (nonatomic, copy) NSString *adUrl;
@property (nonatomic, strong) UIWebView *webView;

@end
