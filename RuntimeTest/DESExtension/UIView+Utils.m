//
//  UIView+Utils.m
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (CGFloat)current_x{
	return self.frame.origin.x;
}
- (CGFloat)current_y{
	return self.frame.origin.y;
}
- (CGFloat)current_w{
	return self.frame.size.width;
}
- (CGFloat)current_h{
	return self.frame.size.height;
}
- (CGFloat)current_x_w{
	return self.frame.origin.x+self.frame.size.width;
}
- (CGFloat)current_y_h{
	return self.frame.origin.y+self.frame.size.height;
}




- (void)setX:(CGFloat)x{
	
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (void)setY:(CGFloat)y{
	
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)x{
	
	return self.frame.origin.x;
}

- (CGFloat)y{
	
	return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
	
	CGPoint center = self.center;
	center.x = centerX;
	self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
	
	CGPoint center = self.center;
	center.y = centerY;
	self.center = center;
}

- (CGFloat)centerY{
	
	return self.center.y;
}

- (CGFloat)centerX{
	
	return self.center.x;
}

- (void)setWidth:(CGFloat)width{
	
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
	
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)width{
	
	return self.frame.size.width;
}

- (CGFloat)height{
	
	return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
	
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin{
	
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGSize)size{
	
	return self.frame.size;
}

- (CGPoint)origin{
	
	return self.frame.origin;
}


@end
