//
//  DESDonateViewController.m
//  RuntimeTest
//
//  Created by tyrael on 16/8/5.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESDonateViewController.h"
#import <StoreKit/StoreKit.h>
#import "NSData+AES.h"
#import "DonateButtonView.h"
#import "DESConst.h"
#import "UILabel+Utils.h"

@interface DESDonateViewController ()<SKPaymentTransactionObserver, SKProductsRequestDelegate>

    @property (nonatomic, strong) NSString * productID;
    @property (nonatomic, strong) UILabel *topicLabel;
    @property (nonatomic, strong) UILabel *contentLabel;
    @property (nonatomic, strong) UILabel *donateLabel;
    @property (nonatomic, strong) DonateButtonView *donateLevel1Button;
    @property (nonatomic, strong) DonateButtonView *donateLevel2Button;
    @property (nonatomic, strong) DonateButtonView *donateLevel3Button;
    @property (nonatomic, strong) DonateButtonView *donateLevel4Button;


@end

@implementation DESDonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.view.backgroundColor = kColorDefaultBackgroundBlackColor;
    
//    _donateLevel1Button
//    [donateLevel1Button returnText:^(NSString *showText) {
//        self.showLabel.text = showText;
//    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 布局方法
- (void)setupUI{
    
    [self.view addSubview:self.topicLabel];
    [self.view addSubview:self.contentLabel];
    
    [self.view addSubview:self.donateLabel];
    [self.view addSubview:self.donateLevel1Button];
    [self.view addSubview:self.donateLevel2Button];
    [self.view addSubview:self.donateLevel3Button];
    [self.view addSubview:self.donateLevel4Button];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kInsertMargin);
        make.left.equalTo(self.view.mas_left).offset(kInsertMargin);
        make.right.equalTo(self.view.mas_right).offset(-kInsertMargin);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.topicLabel.mas_left);
        make.right.equalTo(self.topicLabel.mas_right);
    }];
    
    [self.donateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.topicLabel.mas_left);
        make.right.equalTo(self.topicLabel.mas_right);
    }];
    
    [self.donateLevel1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.topicLabel.mas_left);
        make.height.equalTo(self.donateLevel1Button.mas_width).multipliedBy(1.3);
    }];
    
    [self.donateLevel2Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLevel1Button);
        make.left.equalTo(self.donateLevel1Button.mas_right).offset(kMiddleMargin);
        make.width.equalTo(self.donateLevel1Button.mas_width);
        make.bottom.equalTo(self.donateLevel1Button.mas_bottom);
    }];
    
    [self.donateLevel3Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLevel1Button);
        make.left.equalTo(self.donateLevel2Button.mas_right).offset(kMiddleMargin);
        make.width.equalTo(self.donateLevel1Button.mas_width);
        make.bottom.equalTo(self.donateLevel1Button.mas_bottom);
    }];
    
    [self.donateLevel4Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLevel1Button);
        make.left.equalTo(self.donateLevel3Button.mas_right).offset(kMiddleMargin);
        make.width.equalTo(self.donateLevel1Button.mas_width);
        make.bottom.equalTo(self.donateLevel1Button.mas_bottom);
        make.right.equalTo(self.topicLabel.mas_right);
    }];
}

#pragma mark - 懒加载
- (UILabel *)topicLabel{
    if (_topicLabel == nil) {
        UILabel *label = [UILabel secondaryBoldLabelWithColor:kColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"打赏支持";
        
        _topicLabel = label;
    }
    return _topicLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [UILabel longLabelWithRegularFontSize:14 Color:kColorDefaultSecondaryTextWhiteColor textAlignment:NSTextAlignmentLeft linespacing:6 string:@"如果你觉得此App对你有帮助，请随意打赏，您的支持将鼓励我继续打造更好的App，"];
        
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)donateLabel{
    if (_donateLabel == nil) {
        
        UILabel *label =  [UILabel labelWithDefaultBoldFontSize:18 Color:kColorDefaultAmberColor textAlignment:NSTextAlignmentLeft];

        label.text = @"来吧，请不要吝惜你的钱包。";
        _donateLabel = label;
    }
    return _donateLabel;
}

- (DonateButtonView *)donateLevel1Button{
    if (_donateLevel1Button == nil) {
        DonateButtonView *view = [[DonateButtonView alloc] initWithTitle:@"6 RMB" andImageName:@"donateLevel1"];
        [view returnProductIdentifier:^(NSString *tapClickBlock) {
            [self checkProductIDCanMakePayments:tapClickBlock];
        }];
        view.tag = 0;
        _donateLevel1Button = view;
    }
    return _donateLevel1Button;
}

- (DonateButtonView *)donateLevel2Button{
    if (_donateLevel2Button == nil) {
        DonateButtonView *view = [[DonateButtonView alloc] initWithTitle:@"18 RMB" andImageName:@"donateLevel2"];
        
        [view returnProductIdentifier:^(NSString *tapClickBlock) {
            [self checkProductIDCanMakePayments:tapClickBlock];
        }];
        view.tag = 1;
        
        _donateLevel2Button = view;
    }
    return _donateLevel2Button;
}

- (DonateButtonView *)donateLevel3Button{
    if (_donateLevel3Button == nil) {
        DonateButtonView *view = [[DonateButtonView alloc] initWithTitle:@"45 RMB" andImageName:@"donateLevel3"];
        view.tag = 2;
        
        [view returnProductIdentifier:^(NSString *tapClickBlock) {
            [self checkProductIDCanMakePayments:tapClickBlock];
        }];
        _donateLevel3Button = view;
    }
    return _donateLevel3Button;
}

- (DonateButtonView *)donateLevel4Button{
    if (_donateLevel4Button == nil) {
        DonateButtonView *view = [[DonateButtonView alloc] initWithTitle:@"98 RMB" andImageName:@"donateLevel4"];
        
        [view returnProductIdentifier:^(NSString *tapClickBlock) {
            [self checkProductIDCanMakePayments:tapClickBlock];
        }];
        view.tag = 3;
        
        _donateLevel4Button = view;
    }
    return _donateLevel4Button;
}



-(void)checkProductIDCanMakePayments:(NSString *)productID{
    if([SKPaymentQueue canMakePayments]){
       [self requestProductData:productID];
    }else{
        
        NSLog(@"不允许程序内付费");
    }
}

//请求商品
- (void)requestProductData:(NSString *)type{
    
    
    [SVProgressHUD showWithStatus:@"正在请求，请稍后。"];
    
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    
    // 请求动作
    
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"收到了请求反馈");
    
    NSArray *product = response.products;
    if([product count] == 0){
        
        NSLog(@"没有这个商品");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    
    
    
    SKProduct *p = nil;
    
    // 所有的商品, 遍历招到我们的商品
    
    for (SKProduct *pro in product) {
        
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:_productID]) {
            p = pro;
        }
    }
    
    SKPayment * payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [SVProgressHUD showWithStatus:@"正在发送购买请求" ];
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"商品信息请求错误:%@", error);
    
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"请求结束");
    
    [SVProgressHUD dismiss];
}

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction {
    
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                
                [SVProgressHUD showSuccessWithStatus:@"交易完成"];
                
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                [SVProgressHUD showWithStatus:@"正在请求付费信息"];
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                [SVProgressHUD showErrorWithStatus:@"已经购买过商品"];
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                
                [SVProgressHUD showErrorWithStatus:@"交易失败, 请重试"];
                
                break;
            default:
                
                [SVProgressHUD dismiss];
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [SVProgressHUD dismiss];
    
    NSString * productIdentifier = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    NSString * receipt = [[productIdentifier dataUsingEncoding:NSUTF8StringEncoding] newStringInBase64FromData];
    
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
        
        //      https://sandbox.itunes.apple.com/verifyReceipt
        //       receipt-data
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)dealloc{
    
    // 移除监听
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
