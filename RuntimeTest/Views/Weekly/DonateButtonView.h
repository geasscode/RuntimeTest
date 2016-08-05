//
//  DonateButtonView.h
//  RuntimeTest
//
//  Created by tyrael on 16/8/5.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapClickBlock)(NSString *tapClickBlock);

@interface DonateButtonView : UIView

@property (nonatomic, copy) tapClickBlock donateButtonClicked;

- (instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName;

- (void)returnProductIdentifier:(tapClickBlock)block;

@end
