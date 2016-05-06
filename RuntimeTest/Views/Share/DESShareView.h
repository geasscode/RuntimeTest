//
//  DESShareView.h
//  RuntimeTest
//
//  Created by desmond on 16/5/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ShareBtn) {
	SharePyQuan=0,
	ShareWeix,
	ShareMsg,
	ShareSina,
	ShareQQ,
	ShareQzone,
};


@protocol DESShareViewDelegate <NSObject>
-(void)didClickShareBtn:(ShareBtn)type;
@end

@interface DESShareView : UIView

@property(nonatomic,weak)id<DESShareViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;
@end
