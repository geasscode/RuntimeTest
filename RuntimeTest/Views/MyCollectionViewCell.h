//
//  MyCollectionViewCell.h
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *nemuItemImage;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (void)setImageForCellWithIndexPath:(NSIndexPath*)indexPath;

@end
