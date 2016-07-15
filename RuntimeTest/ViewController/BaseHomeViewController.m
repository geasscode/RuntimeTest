//
//  BaseHomeViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "BaseHomeViewController.h"
#import "SegmentView.h"


#define contentIdentifier @"contentCollectionViewIdentifier"

@interface BaseHomeViewController ()<TitleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic ,assign) NSInteger currentIndex;


@end
@implementation BaseHomeViewController
-(NSArray *)titleModelArray{
	
	if (_titleModelArray == nil) {
		_titleModelArray = [[NSArray alloc]init];
		
	}
	return _titleModelArray;
}

-(TitleScrollView *)titleScrollView{
	
	if (_titleScrollView == nil) {
		_titleScrollView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,kTitleScrollViewHeight)];
		_titleScrollView.titleModelArray = self.titleModelArray;
		_titleScrollView.delegate = self;
	}
	
	return _titleScrollView;
}

-(UICollectionViewFlowLayout *)flowLayout{
	
	if (_flowLayout == nil) {
		_flowLayout = [[UICollectionViewFlowLayout alloc]init];
		_flowLayout.itemSize = self.contentCollectionView.bounds.size;
		_flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_flowLayout.minimumInteritemSpacing = 0;
		_flowLayout.minimumLineSpacing = 0;
	}
	return  _flowLayout;
}

-(DESCollectionView *)contentCollectionView{
	
	if (_contentCollectionView == nil) {
		_contentCollectionView = [[DESCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.titleScrollView.frame)-49) collectionViewLayout:self.flowLayout];
		_contentCollectionView.delegate = self;
		_contentCollectionView.dataSource = self;
		_contentCollectionView.pagingEnabled = YES;
		
		for (int i = 0; i <self.titleModelArray.count; i ++) {
			[_contentCollectionView registerClass:[DESCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%d",contentIdentifier,i]];
		}
	}
	
	return _contentCollectionView;
}

#pragma mark - 设置子控件
-(void)setUI{
	
	//添加SegmentView
//	SegmentView *seg = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) titles:self.titleModelArray selectedBtn:^(NSInteger selectedItem) {
//		
//		NSLog(@"%ld",(long)selectedItem);
//		
//	}];
//	
//	[self.view addSubview:seg];
	[self.view addSubview:self.titleScrollView];
	
//	这个问题iOS7就出现了，只要scrollView是其父视图上的第一个子视图，且navigationBar不隐藏的情况下，添加到scrollView里的视图，都会默认下移64个像素。 导致scrollview里面的内容向下偏移了64 添加此方法 从导航栏下开始计算 （待改善。）
//	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//		self.edgesForExtendedLayout = UIRectEdgeNone;
//	}
	
	//无意中搜索edgesForExtendedLayout 意外解决一直存在的问题。就是title 位置 跑到下面去了，以为没有显示数据。
//	A Boolean value that indicates whether the view controller should automatically adjust its scroll view insets.
	self.automaticallyAdjustsScrollViewInsets = NO ;
	[self.view addSubview:self.contentCollectionView];
	
	
	
	self.contentCollectionView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
//	self.contentCollectionView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
	self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
}

#pragma mark - contentCollectionView的代理方法和数据源方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
	return self.titleModelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	DESCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%d",contentIdentifier,(int)indexPath.row] forIndexPath:indexPath];
	
	TitleModel *model = self.titleModelArray[indexPath.row];
	
	cell.urlstring = model.urlstring;
	cell.title = model.title;
	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);

	return cell;
}

#pragma mark - titleScrollViewDelegate的代理方法

- (void)titleScrollView:(TitleScrollView *)titleScrollView didSelectedItemIndex:(NSInteger)index{
	
	[self.contentCollectionView setContentOffset:CGPointMake(index * kScreenWidth, 0) animated:NO];
}

#pragma mark - 上下联动的实现

//手势导致的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	[self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
	
	self.titleScrollView.currentItemIndex = self.currentIndex;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	self.currentIndex = self.contentCollectionView.contentOffset.x / kScreenWidth + 0.5;
}


@end
