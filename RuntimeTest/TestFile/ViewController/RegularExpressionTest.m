//
//  RegularExpressionTest.m
//  RuntimeTest
//
//  Created by desmond on 16/6/21.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "RegularExpressionTest.h"

@implementation RegularExpressionTest

//1.我们一般将谓词和正则表达式配合使用，这是最常用的方法。
- (BOOL)validateNumber:(NSString *) textString
{
	// 其中^[0-9]+$表示字符串中只能包含>=1个0-9的数字。
	NSString* number=@"^[0-9]+$";
	NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
	return [numberPre evaluateWithObject:textString];
}


@end
