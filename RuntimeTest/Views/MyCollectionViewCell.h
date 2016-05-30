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

- (void)setImageForCellWithIndexPath:(NSIndexPath*)indexPath;

@end
