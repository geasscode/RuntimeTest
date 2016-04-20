//
//  NavigationItem.m
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "NavigationItem.h"
#define WNXScaleanimateWithDuration 0.3

@interface NavigationItem ()

@end

@implementation NavigationItem

- (void)viewDidLoad {
    [super viewDidLoad];
 //添加导航条上的按钮
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"search_icon_white_6P@2x" target:self action:@selector(leftSearchClick)];
	
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"artcleList_btn_info_6P" target:self action:@selector(rightClick)];
	
	self.view.backgroundColor = WNXColor(239, 239, 244);
    // Do any additional setup after loading the view.
}

#pragma 导航条左右边按钮点击
- (void)rightClick
{
	//添加遮盖,拦截用户操作
	_coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_coverBtn.frame = self.navigationController.view.bounds;
	[_coverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
	[self.navigationController.view addSubview:_coverBtn];
	
	//缩放比例
	CGFloat zoomScale = (WNXAppHeight - WNXScaleTopMargin * 2) / WNXAppHeight;
	//X移动距离
	CGFloat moveX = WNXAppWidth - WNXAppWidth * WNXZoomScaleRight;
	
	[UIView animateWithDuration:WNXScaleanimateWithDuration animations:^{
		
		CGAffineTransform transform = CGAffineTransformMakeScale(zoomScale, zoomScale);
		//先缩放在位移会使位移缩水,正常需要moveX/zoomScale 才是正常的比例,这里感觉宽度还好就省略此步
		self.navigationController.view.transform = CGAffineTransformTranslate(transform, moveX, 0);
		//将状态改成已经缩放
		self.isScale = YES;
	}];
}

//推出search控制器
- (void)leftSearchClick
{
//	WNXSearchViewController *search = [[WNXSearchViewController alloc] init];
//	[self.navigationController pushViewController:search animated:YES];
}

//cover点击
- (void)coverClick
{
	[UIView animateWithDuration:WNXScaleanimateWithDuration animations:^{
		self.navigationController.view.transform = CGAffineTransformIdentity;
	} completion:^(BOOL finished) {
		[self.coverBtn removeFromSuperview];
		self.coverBtn = nil;
		self.isScale = NO;
		//当遮盖按钮被销毁时调用
		if (_coverDidRomove) {
			_coverDidRomove();
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
