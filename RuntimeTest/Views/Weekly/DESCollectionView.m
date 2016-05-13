//
//  DESCollectionView.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESCollectionView.h"

@implementation DESCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
	
	if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
		
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
	
}

@end
