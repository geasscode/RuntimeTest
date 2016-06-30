//
//  ConditionerView.m
//  TBAlertControllerDemo
//
//  Created by 杨萧玉 on 16/4/3.
//  Copyright © 2016年 杨萧玉. All rights reserved.
//

#import "ConditionerView.h"
#import "TBActionSheet.h"
#import "TBActionContainer.h"
#import "DetailViewController.h"

@interface ConditionerView ()

@property (weak, nonatomic) IBOutlet UISlider *screenLight;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fontSize;

@end

@implementation ConditionerView

-(void)awakeFromNib{
	[self setUpUI];
}

//-(instancetype)initWithFrame:(CGRect)frame{
//	self = [super initWithFrame:frame];
//	if (self) {
//
//	}
//	return self;
//}
//
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//	self = [super initWithCoder:aDecoder];
//	if (self) {
//		_nightMode = [[LLSwitch alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];
//		_nightMode.delegate = self;
//
//	}
//	return self;
//}


- (IBAction)screenLight:(UISlider *)sender {
	
	CGFloat lightValue = sender.value;
	[[UIScreen mainScreen] setBrightness: lightValue];
	
	//获取当前屏幕的亮度:另外,屏幕的亮度调节只能在真机上看到效果 在模拟器上看不到效果
	//	[[UIScreen mainScreen] brightness];
	
 	NSLog(@"lightValue value is %f",lightValue);
	
}

- (IBAction)fontSize:(id)sender {
}

- (IBAction)touchUp:(id)sender {
	[self refreshActionSheet];
}

- (void)setUpUI
{
	//是否让背景透明。
//	self.actionSheet.backgroundTransparentEnabled = YES;
//	[TBActionSheet appearance].backgroundTransparentEnabled = YES;
//	
	//是否启用毛玻璃效果
//	self.actionSheet.blurEffectEnabled = NO;
//	[TBActionSheet appearance].blurEffectEnabled = NO;
	
	//控制ActionSheet背景颜色。

//	self.actionSheet.ambientColor = [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
//	[TBActionSheet appearance].ambientColor = self.actionSheet.ambientColor;
	[self refreshActionSheet];
	[self configureSegmentedUI];

}

- (void)refreshActionSheet
{
	self.bounds = CGRectMake(0, 0, self.actionSheet.sheetWidth, self.bounds.size.height);
	[[self.actionSheet valueForKeyPath:@"actionContainer"] removeFromSuperview];
	TBActionContainer *container = [[TBActionContainer alloc] initWithSheet:self.actionSheet];
	[self.actionSheet setValue:container forKeyPath:@"actionContainer"];
	[self.actionSheet addSubview:container];
	[self.actionSheet setUpLayout];
	[self.actionSheet setUpContainerFrame];
	[self.actionSheet setUpStyle];
}

- (void)configureSegmentedUI {
	self.fontSize.momentary = NO;
	self.fontSize.selectedSegmentIndex = 3;
	self.fontSize.tintColor = [UIColor redColor];


	//	[self.fontSize setEnabled:NO forSegmentAtIndex:0];
	
	[self.fontSize addTarget:self action:@selector(selectedSegmentDidChange:) forControlEvents:UIControlEventValueChanged];
}

//-(void)didTapLLSwitch:(LLSwitch *)llSwitch {
//	NSLog(@"start");
//}
//
//- (void)animationDidStopForLLSwitch:(LLSwitch *)llSwitch {
//	NSLog(@"stop");
//}

- (void)selectedSegmentDidChange:(UISegmentedControl *)segmentedControl {
	
	NSInteger currentIndex = segmentedControl.selectedSegmentIndex;
	switch (currentIndex) {
		case 0:{
			NSLog(@"Index %li", (long)currentIndex);
			_detailVC.fontSizeValue = 80;
			break;
		}
		case 1:
			NSLog(@"Index %li", (long)currentIndex);
			_detailVC.fontSizeValue = 110;
			
			break;
		case 2:
			NSLog(@"Index %li", (long)currentIndex);
			_detailVC.fontSizeValue = 130;
			
			break;
		case 3:
			NSLog(@"Index %li", (long)currentIndex);
			_detailVC.fontSizeValue = 100;
			
			break;
			
		default:
			break;
	}
	NSLog(@"The selected segment changed for: %@.", segmentedControl);
}

@end
