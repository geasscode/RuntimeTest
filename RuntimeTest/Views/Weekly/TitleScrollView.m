//
//  TitleScrollView.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "TitleScrollView.h"
#import "TitleModel.h"

@interface TitleScrollView()

/**
 *  装有所有item的数组
 */
@property (nonatomic, strong) NSMutableArray *items;

/**
 *  用于显示所有的item
 */
@property (nonatomic, weak) UIScrollView *listTabBar;

@end

@implementation TitleScrollView

-(instancetype)initWithFrame:(CGRect)frame{
	
	if (self = [super initWithFrame:frame]) {
		
		self.listTabBar.showsHorizontalScrollIndicator = NO;
		
		_items = [[NSMutableArray alloc] init];
		
		self.backgroundColor = [UIColor whiteColor];
		
		//设置滚动的listTabBar
		UIScrollView *listTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth ,kTitleScrollViewHeight)];
		listTabBar.showsHorizontalScrollIndicator = NO;
//		listTabBar.scrollEnabled = NO;
		self.listTabBar = listTabBar;
		[self addSubview:self.listTabBar];
	}
	
	return self;
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex{
	
	_currentItemIndex = currentItemIndex;
	
	UIButton *button = _items[currentItemIndex];
	
	[self settingSelectedButton:button];
	
	CGFloat rightButtonMaxX = button.x + button.width;
	
	if (rightButtonMaxX > kScreenWidth - 80)
	{
		CGFloat offsetX = rightButtonMaxX - kScreenWidth;
		if (_currentItemIndex < self.titleModelArray.count - 1)
		{
			offsetX = offsetX + 80.0;
		}
		
		[self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
	}
	else
	{
		[self.listTabBar setContentOffset:CGPointMake(0, 0) animated:YES];
	}
}

-(void)setTitleModelArray:(NSArray *)titleModelArray{
	
	_titleModelArray = titleModelArray;
	
	CGFloat buttonX = 0;
	CGFloat buttonW = 0;
	for (int i = 0; i < titleModelArray.count; i ++) {
		
		TitleModel *model = titleModelArray[i];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		
		//取得item的标题
		NSString *title = model.title;
		
		buttonW = [self sizeWithFont:kTitleScrollViewItemsFontSize text:title].width;
		button.titleLabel.font = [UIFont systemFontOfSize:kTitleScrollViewItemsFontSize];
		button.frame = CGRectMake(10 + buttonX, 0, buttonW , kTitleScrollViewHeight);
		[button setTitle:title forState:UIControlStateNormal];
		[button setTitleColor:kColor(22.0, 147.0, 114.0) forState:UIControlStateSelected];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(itemsDidClick:) forControlEvents:UIControlEventTouchUpInside];
		
		if (i == 0) {
			
			button.selected = YES;
		}
		[self.listTabBar addSubview:button];
		
		[self.items addObject:button];
		
		if (i != titleModelArray.count - 1) {
			
			buttonX += buttonW + kItemsPadding;
		}
	}
	
	self.listTabBar.contentSize = CGSizeMake(buttonX + buttonW + kItemsPadding, 0);
}

/**
 *  item按钮的点击事件
 */
- (void)itemsDidClick:(UIButton *)button{
	
	[self settingSelectedButton:button];
	
	self.currentItemIndex = [_items indexOfObject:button];
	
	if ([self.delegate respondsToSelector:@selector(titleScrollView:didSelectedItemIndex:)]) {
		
		[self.delegate titleScrollView:self didSelectedItemIndex:_currentItemIndex];
	}
}

/**
 *  设置button为选中状态（主要是改变选中按钮的title颜色）
 */
- (void)settingSelectedButton:(UIButton *)button{
	
	for (UIView *view in self.listTabBar.subviews) {
		
		if ([view isKindOfClass:[UIButton class]]) {
			
			((UIButton *)view).selected = NO;
		}
	}
	
	button.selected = YES;
}

/**
 *  根据文字自适应宽度和高度
 *
 *  @param fontSize 计算的文字的大小
 *  @param text     要计算的文字
 */
- (CGSize)sizeWithFont:(NSInteger)fontSize text:(NSString *)text{
	
	NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
	
	return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, kTitleScrollViewHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
	
}

@end
