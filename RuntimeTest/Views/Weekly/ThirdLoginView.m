//
//  ThirdLoginView.m
//  MiaowShow
//
//  Created by ALin on 16/6/13.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "ThirdLoginView.h"

static UIEdgeInsets const kPadding = {10, 10, 10, 10};


@implementation ThirdLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
	
	
	
	UILabel *qqLable = UILabel.new;
	qqLable.numberOfLines = 1;
	qqLable.textColor = [UIColor whiteColor];
	qqLable.lineBreakMode = NSLineBreakByTruncatingTail;
	qqLable.text = @"QQ登录";
	[self addSubview:qqLable];
	
	UILabel *sinaLable = UILabel.new;
	sinaLable.numberOfLines = 1;
	sinaLable.textColor = [UIColor whiteColor];
	sinaLable.lineBreakMode = NSLineBreakByTruncatingTail;
	sinaLable.text = @"新浪登录";
	[self addSubview:sinaLable];
	
	UILabel *wxLabel = UILabel.new;
	wxLabel.numberOfLines = 1;
	wxLabel.textColor = [UIColor whiteColor];
	wxLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	wxLabel.text = @"微信登录";
//	[self addSubview:qqLable];
//	[self addSubview:sinaLable];
//	[self addSubview:wxLabel];
	
	


	
    UIImageView *sina = [self creatImageView:@"login_sina_icon" tag:LoginTypeSina];
    UIImageView *qq = [self creatImageView:@"login_QQ_icon" tag:LoginTypeQQ];
    UIImageView *wechat = [self creatImageView:@"login_tecent_icon" tag:LoginTypeWechat];
    
    [self addSubview:sina];
    [self addSubview:qq];
    [self addSubview:wechat];
	
//	[sinaLable mas_updateConstraints:^(MASConstraintMaker *make) {
//		make.center.equalTo(self);
//		make.width.equalTo(@30);
//		make.height.equalTo(@25);
//	}];
//	
//	[qqLable mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(sina.mas_bottom).insets(kPadding);
//		make.centerY.equalTo(sinaLable);
//		make.size.equalTo(sinaLable);
//	}];
//	
//	[wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(wechat.mas_bottom).insets(kPadding);
//		make.centerY.equalTo(qqLable);
//		make.size.equalTo(sinaLable);
//	}];
	
    
    [sina mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@70);
    }];
    
    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.right.equalTo(sina.mas_left).offset(-40);
        make.size.equalTo(sina);
    }];
    
    [wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.left.equalTo(sina.mas_right).offset(40);
        make.size.equalTo(sina);
    }];
    
}


- (UIImageView *)creatImageView:(NSString *)imageName tag:(NSUInteger)tag
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.tag = tag;
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    return imageV;
}


- (void)click:(UITapGestureRecognizer *)tapRec
{
    if (self.clickLogin) {
        self.clickLogin(tapRec.view.tag);
    }
}
@end
