//
//  MyViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
	
	__weak IBOutlet UIImageView *headBackgroundImage;
	
	BOOL isLogin;
}

/**
 *  个人页面里的九个功能按钮,用collectionView来实现
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end