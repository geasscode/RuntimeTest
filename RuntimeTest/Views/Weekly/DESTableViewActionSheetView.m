//
//  DESTableViewActionSheetView.m
//  RuntimeTest
//
//  Created by desmond on 16/6/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESTableViewActionSheetView.h"
#import "LLSwitch.h"

#define CELL_HEIGHT 59


@interface DESTableViewActionSheetView () <UITableViewDataSource, UITableViewDelegate,LLSwitchDelegate>

@property (nonatomic, strong) UIView *maskBackgroundView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
///界面显示item数量
@property (nonatomic, assign) NSInteger showItemCount;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;


@end

@implementation DESTableViewActionSheetView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
					itemArray:(NSArray *)itemArray
				showItemCount:(NSInteger) showItemCount
			  bottomCellTitle:(NSString *)bottomTitle
{
	self = [super initWithFrame:frame];
	if (self) {
		self.showItemCount = showItemCount;
		self.dataSourceArray = (NSMutableArray *)itemArray;
		
		[self addSubview:self.maskBackgroundView];
	}
	return self;
}

+ (DESTableViewActionSheetView *)DESTableViewActionSheetViewWithFrame:(CGRect)frame
														  itemArray:(NSArray *)itemArray
													  showItemCount:(NSInteger) showItemCount
													bottomCellTitle:(NSString *)bottomTitle
{
	return [[DESTableViewActionSheetView alloc] initWithFrame:frame itemArray:itemArray showItemCount:showItemCount bottomCellTitle:bottomTitle];
}

#pragma mark - overwrite

#pragma mark - public

- (void)show
{
	UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
	
	[window addSubview:self];
	
	[UIView animateWithDuration:0.2 animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		self.maskBackgroundView.transform = CGAffineTransformMakeTranslation(0, 300);

//		self.maskBackgroundView.transform = CGAffineTransformMakeTranslation(0, -(CELL_HEIGHT * (self.showItemCount + 1)));
	}];
}

#pragma mark - delegate

#pragma mark -- UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
//	LLSwitch *llSwitch = [[LLSwitch alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];
//	[self addSubview:llSwitch];
//	llSwitch.delegate = self;
	
	static NSString *cellId = @"CELLID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
		if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
			[cell setSeparatorInset:UIEdgeInsetsMake(0, 50, 0, 0)];
		}
		if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
			[cell setLayoutMargins:UIEdgeInsetsMake(0, 50, 0, 0)];
		}
		if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
			[cell setPreservesSuperviewLayoutMargins:NO];
		}
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		UIImageView *itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 17, 25, 25)];
		itemImageView.image = [UIImage imageNamed:@"baoone"];
		itemImageView.backgroundColor = [UIColor grayColor];
		[cell.contentView addSubview:itemImageView];
		
		
		UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(itemImageView.frame) + 10, 12, 150, 16)];
		firstLabel.text = @"Test1";
		firstLabel.textAlignment = NSTextAlignmentLeft;
		[cell.contentView addSubview:firstLabel];
		
		UILabel *secondLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(firstLabel.frame), CGRectGetMaxY(firstLabel.frame) + 5, 65, 14)];
		secondLeftLabel.text = @"标注：";
		secondLeftLabel.textAlignment = NSTextAlignmentLeft;
		[cell.contentView addSubview:secondLeftLabel];
		
		UILabel *secondRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondLeftLabel.frame), CGRectGetMinY(secondLeftLabel.frame), 150, 14)];
		secondRightLabel.text = @"0989898";
		secondRightLabel.textAlignment = NSTextAlignmentLeft;
		[cell.contentView addSubview:secondRightLabel];
		
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		
		UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 15, 25, 25)];
		accessoryView.image = [UIImage imageNamed:@"baoone"];
		accessoryView.backgroundColor = [UIColor grayColor];
		cell.accessoryView = accessoryView;
		
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CELL_HEIGHT;
}

#pragma mark - notification

#pragma mark - event response

#pragma mark - private

- (void)bottomViewTap
{
	[self dismiss];
}

- (void)dismiss
{
	[UIView animateWithDuration:0.2 animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		self.maskBackgroundView.transform = CGAffineTransformIdentity;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
	//删除字符串中的空格
	NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	// String should be 6 or 8 characters
	if ([cString length] < 6)
	{
		return [UIColor clearColor];
	}
	// strip 0X if it appears
	//如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
	if ([cString hasPrefix:@"0X"])
	{
		cString = [cString substringFromIndex:2];
	}
	//如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
	if ([cString hasPrefix:@"#"])
	{
		cString = [cString substringFromIndex:1];
	}
	if ([cString length] != 6)
	{
		return [UIColor clearColor];
	}
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	//r
	NSString *rString = [cString substringWithRange:range];
	//g
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	//b
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - getter and setter

- (UIView *)maskBackgroundView{
	if (_maskBackgroundView) {
		return _maskBackgroundView;
	}
	
	_maskBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + CELL_HEIGHT * (self.showItemCount + 1))];
	_maskBackgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
	
	[_maskBackgroundView addSubview:self.maskView];
	[_maskBackgroundView addSubview:self.tableView];
	[_maskBackgroundView addSubview:self.bottomView];
	
	return _maskBackgroundView;
}

- (UITableView *)tableView{
	if (_tableView) {
		return _tableView;
	}
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, CELL_HEIGHT *(self.showItemCount)) style:UITableViewStylePlain];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.showsVerticalScrollIndicator = NO;
	
	return _tableView;
}

- (UIView *)bottomView{
	if (_bottomView) {
		return _bottomView;
	}
	
	_bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame) - 1, kScreenWidth, CELL_HEIGHT + 1)];
	_bottomView.backgroundColor = [UIColor whiteColor];
	
	UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
	lineLabel.backgroundColor = [self colorWithHexString:@"#cccccc" alpha:1.f];
	[_bottomView addSubview:lineLabel];
	
	UILabel *bottomTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 22, kScreenWidth - 2 * 14, 16)];
	bottomTitleLabel.text = @"bottombottombottombottom";
	bottomTitleLabel.font = [UIFont systemFontOfSize:16];
	[_bottomView addSubview:bottomTitleLabel];
	
	UITapGestureRecognizer *bottomViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomViewTap)];
	[_bottomView addGestureRecognizer:bottomViewTap];
	
	return _bottomView;
}

- (UIView *)maskView{
	if (_maskView) {
		return _maskView;
	}
	
	_maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
	_maskView.backgroundColor = [UIColor clearColor];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
	[_maskView addGestureRecognizer:tap];
	
	return _maskView;
}


-(void)didTapLLSwitch:(LLSwitch *)llSwitch {
	NSLog(@"start");
}

- (void)animationDidStopForLLSwitch:(LLSwitch *)llSwitch {
	NSLog(@"stop");
}

@end
