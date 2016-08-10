//
//  MySubscribeTitleCell.h
//  RuntimeTest
//
//  Created by desmond on 16/8/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscribeModel.h"

@interface MySubscribeTitleCell : UITableViewCell

+ (UINib *)nib;

@property (nonatomic , strong) SubscribeModel *topic;

@end
