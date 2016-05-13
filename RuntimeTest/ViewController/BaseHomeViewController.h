//
//  BaseHomeViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleScrollView.h"
#import "DESCollectionView.h"

@interface BaseHomeViewController : UIViewController

@property (nonatomic,strong) NSArray *titleModelArray;

@property (nonatomic,strong) TitleScrollView *titleScrollView;

@property (nonatomic,strong) DESCollectionView *contentCollectionView;

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

-(void)setUI;

@end
