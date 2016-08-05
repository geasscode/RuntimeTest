//
//  DonateButtonView.m
//  RuntimeTest
//
//  Created by tyrael on 16/8/5.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DonateButtonView.h"



@interface DonateButtonView()

@property (nonatomic, strong) UIImageView *donateImageView;
@property (nonatomic, strong) UIButton *donateButton;
@property (nonatomic, strong) NSString *productIdentifier;
@property (nonatomic, strong) NSArray * productIDArray;

@end

@implementation DonateButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIImageView *)donateImageView{
    if (_donateImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donate)];
        [imageView addGestureRecognizer:pan];
        _donateImageView = imageView;
    }
    return _donateImageView;
}


- (UIButton *)donateButton{
    if (_donateButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = kColorDefaultWhiteColor;
        button.titleLabel.font = kDefaultFontBoldWith(14);
        [button setTitleColor:kColorDefaultPrimaryTextBlackColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(donate) forControlEvents:UIControlEventTouchUpInside];
        _donateButton = button;
    }
    return _donateButton;
}

- (NSString *)productIdentifier{
    if (_productIdentifier == nil) {
        
        _productIDArray = @[@"cola_rmb6",@"subway_rmb25",@"100000",@"999"];

        NSString *string = _productIDArray[self.tag];
        _productIdentifier = string;
    }
    return _productIdentifier;
}

- (void)returnProductIdentifier:(tapClickBlock)block {
    self.donateButtonClicked = block;
}

#pragma mark - alloc/init
- (instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName{
    self = [super init];
    if (self) {
        [self.donateButton setTitle:title forState:UIControlStateNormal];
        self.donateImageView.image = [UIImage imageNamed:imageName];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.donateImageView];
        [self addSubview:self.donateButton];
        
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 布局方法
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.donateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.donateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateImageView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_width).multipliedBy(0.3);
    }];
}

#pragma mark - 响应方法

- (void)donate{
    
     if (self.donateButtonClicked != nil) {
        self.donateButtonClicked(self.productIdentifier);
    }
//    //根据tag确定购买的商品标识
//    NSSet *productIdentifier = [[NSSet alloc] initWithObjects:self.productIdentifier, nil];
//    //创建购买商品的请求
//    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifier];
//    //设置代理,监听请求的状态
//    request.delegate = self;
//    //发送请求
//    [request start];
}



@end
