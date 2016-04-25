//
//  RatingCell.h
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingCell : UITableViewCell

@property (nonatomic) double rating; // 0 to 1

+ (UINib *)nib;

@end
