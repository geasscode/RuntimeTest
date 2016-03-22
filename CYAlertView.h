//
//  CYAlertView.h
//  RuntimeTest
//
//  Created by desmond on 16/3/22.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYAlertView : UIAlertView

- (id)initWithTitle:(NSString *)title
			message:(NSString *)message
	   clickedBlock:(void (^)(CYAlertView *alertView, BOOL cancelled, NSInteger buttonIndex))clickedBlock
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
@end
