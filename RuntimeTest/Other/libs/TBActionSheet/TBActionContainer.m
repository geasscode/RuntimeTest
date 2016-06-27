//
//  TBActionContainer.m
//  TBAlertControllerDemo
//
//  Created by 杨萧玉 on 16/1/31.
//  Copyright © 2016年 杨萧玉. All rights reserved.
//

#import "TBActionContainer.h"
#import "TBActionSheet.h"
#import "TBActionButton.h"
#import "UIView+TBAdditions.h"

@interface TBActionContainer ()
@property (weak,nonatomic) TBActionSheet *actionSheet;
@end
@implementation TBActionContainer

- (instancetype)initWithSheet:(TBActionSheet *)actionSheet
{
    self = [super init];
    if (self) {
        _header = [[UIImageView alloc] init];
        _custom = [[UIImageView alloc] init];
        _footer = [[UIImageView alloc] init];
        _header.clipsToBounds = YES;
        _custom.clipsToBounds = YES;
        _footer.clipsToBounds = YES;
        _header.userInteractionEnabled = YES;
        _custom.userInteractionEnabled = YES;
        _footer.userInteractionEnabled = YES;
        _actionSheet = actionSheet;
        self.userInteractionEnabled = YES;
        [self addSubview:_header];
        [self addSubview:_custom];
        [self addSubview:_footer];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (BOOL)useSystemBlurEffect
{
    if (kiOS8Later) {
        self.backgroundColor = self.actionSheet.ambientColor;
        self.layer.masksToBounds = YES;
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        blurEffectView.frame = self.bounds;
        blurEffectView.layer.masksToBounds = YES;
        [self insertSubview:blurEffectView atIndex:0];
        return YES;
    }
    return NO;
}

- (BOOL)useSystemBlurEffectUnderView:(UIView *)view
{
    if (!view) {
        return NO;
    }
    if (kiOS8Later) {
        UIView *colorView = [[UIView alloc] initWithFrame:view.frame];
        colorView.backgroundColor = self.actionSheet.ambientColor;
        colorView.layer.masksToBounds = YES;
        colorView.tbRectCorner = view.tbRectCorner;
        
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        blurEffectView.frame = view.frame;
        blurEffectView.layer.masksToBounds = YES;
        blurEffectView.tbRectCorner = view.tbRectCorner;
        
        [self insertSubview:blurEffectView atIndex:0];
        
        [blurEffectView setCornerRadius:self.actionSheet.rectCornerRadius];
        [colorView setCornerRadius:self.actionSheet.rectCornerRadius];
        
        [self insertSubview:colorView atIndex:0];
        
        if ([view isKindOfClass:[TBActionButton class]]) {
            TBActionButton *btn = (TBActionButton *)view;
            btn.behindColorView = colorView;
        }
        
        return YES;
    }
    return NO;
}

@end
