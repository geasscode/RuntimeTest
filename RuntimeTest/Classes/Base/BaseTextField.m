//
//  BaseTextField.m
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (instancetype)init {
	self = [super init];
	if (self) {
		_horizontalSpace = 5;
		self.leftView = ({
			UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(_horizontalSpace, 0, self.frame.size.width - 2*_horizontalSpace, self.frame.size.height)];
			leftView.backgroundColor = [UIColor clearColor];
			leftView;
		});
		self.leftViewMode = UITextFieldViewModeAlways;
	}
	return self;
}

- (void)setHorizontalSpace:(CGFloat)horizontalSpace {
	_horizontalSpace = horizontalSpace;
	CGRect rect = CGRectMake(_horizontalSpace, 0, self.frame.size.width - 2*_horizontalSpace, self.frame.size.height);
	self.leftView.frame = rect;
}

@end
