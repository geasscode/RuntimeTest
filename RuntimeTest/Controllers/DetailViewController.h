//
//  DetailViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSString *key;
@property (nonatomic,copy) NSString *detailTextId;
@property (nonatomic) NSInteger fontSizeValue;
@property (nonatomic, strong) NSString *backgroundColor;
@property (nonatomic, assign) BOOL isNightMode;


@end
