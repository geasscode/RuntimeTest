//
//  ConditionerView.h
//  TBAlertControllerDemo
//
//  Created by 杨萧玉 on 16/4/3.
//  Copyright © 2016年 杨萧玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSwitch.h"
#import "DetailViewController.h"
@class TBActionSheet;
@interface ConditionerView : UIView

@property (weak,nonatomic) TBActionSheet *actionSheet;
@property (nonatomic,weak) DetailViewController *detailVC;
@property (strong, nonatomic) IBOutlet LLSwitch *nightMode;

- (void)setUpUI;
@end
