//
//  CategoryDetailFrameModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "CategoryDetailFrameModel.h"
#import "WeeklyItemStageCategoryDetail.h"

@implementation CategoryDetailFrameModel


- (void)setDetailModel:(WeeklyItemStageCategoryDetail *)detailModel{
	
	_detailModel = detailModel;
	
	
	CGFloat titleX = 10;
	CGFloat titleY = 10;
	
	CGSize maxSize = CGSizeMake(kScreenWidth - 20, MAXFLOAT);
	CGSize titleSize = [self sizeWithText:detailModel.title font:WeeklyCateforyDetailFont maxSize:maxSize];
	
	_titleF = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
	
	_cellHeight = titleSize.height + 20;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
	
	NSDictionary *attrs = @{NSFontAttributeName : font};
	
	return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
