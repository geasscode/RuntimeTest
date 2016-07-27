//
//  XTOAuth.m
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import "TWOAuth.h"
#import "NSString+SNSAddition.h"

@implementation TWOAuth

+ (void)loginToPlatform:(TWSNSPlatform)platform completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{

    if (platform == TWSNSPlatformWeibo) {
        NSString *redirectURI = [[NSUserDefaults standardUserDefaults] objectForKey:kSNSPlatformWeiboRedirectURIKey];
        [OpenShare WeiboAuth:@"all" redirectURI:redirectURI Success:^(NSDictionary *message) {
            [TWOAuth weiboOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (platform == TWSNSPlatformQQ) {
        [OpenShare QQAuth:@"get_user_info,get_simple_userinfo,get_info" Success:^(NSDictionary *message) {
            [TWOAuth qqOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (platform == TWSNSPlatformWeiXin) {
        [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
            [TWOAuth weixinOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    }
}

+ (void)weixinOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appId = [ud objectForKey:kSNSPlatformWeixinIdKey];
    NSString *secret = [ud objectForKey:kSNSPlatformWeixinSecretKey];
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", appId, secret, message[@"code"]];
    [TWSNSRequest get:url completionHandler:^(NSDictionary *data, NSError *error) {
        NSString *accessToken = data[@"access_token"];
        NSString *openid = data[@"openid"];
        
        NSString *userInfoUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN", accessToken, openid];
        [TWSNSRequest get:userInfoUrl completionHandler:^(NSDictionary *userInfo, NSError *error) {
            NSMutableDictionary *dict = userInfo.mutableCopy;
            [dict addEntriesFromDictionary:message];
            if (completionHandler) {
                completionHandler(dict, error);
            }
        }];
    }];
}

+ (void)weiboOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *params = @{@"source": [ud objectForKey:kSNSPlatformWeiboIdKey],
                             @"access_token": message[@"accessToken"],
                             @"uid": message[@"userID"]};
    [TWSNSRequest get:url params:params completionHandler:^(NSDictionary *data, NSError *error) {
        NSMutableDictionary *dict = data.mutableCopy;
        [dict addEntriesFromDictionary:message];
        if (completionHandler) {
            completionHandler(dict, error);
        }
    }];
}


//http://wiki.open.qq.com/wiki/API3.0文档#.E8.AF.B7.E6.B1.82URL.E8.AF.B4.E6.98.8E

//
//http://openapi.tencentyun.com/v3/user/get_info?
//openid=B624064BA065E01CB73F835017FE96FA&
//openkey=5F154D7D2751AEDC8527269006F290F70297B7E54667536C&
//appid=2&
//sig=VrN%2BTn5J%2Fg4IIo0egUdxq6%2B0otk%3D&
//pf=qzone&
//format=json&
//userip=112.90.139.30


//返回类型
//Content-type: text/html; charset=utf-8
//{
//	"ret":0,
//	"is_lost":0,
//	"nickname":"Peter",
//	"gender":"男",
//	"country":"中国",
//	"province":"广东",
//	"city":"深圳",
//	"figureurl":"http://imgcache.qq.com/qzone_v4/client/userinfo_icon/1236153759.gif",
//	"is_yellow_vip":1,
//	"is_yellow_year_vip":1,
//	"yellow_vip_level":7,
//	"is_yellow_high_vip": 0
//}
+ (void)qqOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *url = @"http://openapi.tencentyun.com/v3/user/get_info";
    NSMutableDictionary *params = @{@"appid": [ud objectForKey:kSNSPlatformQQIdKey],
                                    @"openkey": message[@"access_token"],
                                    @"openid": message[@"openid"],
                                    @"pf": @"qzone",
                                    @"format": @"json"}.mutableCopy;
    NSMutableString *paramsString = [NSString stringWithFormat:@"GET&%@&", [@"/v3/user/get_info" encodeURL]].mutableCopy;
    NSArray *keys = @[@"appid", @"format", @"openid", @"openkey", @"pf"];
    NSMutableString *keyValueString = @"".mutableCopy;
    for (NSString *key in keys) {
        [keyValueString appendFormat:@"%@=%@&", key, params[key]];
    }
    [keyValueString appendString:@"userip="];
    keyValueString = [keyValueString encodeURL].mutableCopy;
    [keyValueString appendString:@"10.0.0.1"];
    NSString *signStr = [NSString stringWithFormat:@"%@%@", paramsString, keyValueString];
    NSString *sss = [signStr hmacSha1WithKey:[NSString stringWithFormat:@"%@&", [ud objectForKey:kSNSPlatformQQSecretKey]]];
    NSString *sig = [sss encodeURL];
    params[@"sig"] = sig;
    params[@"userip"] = @"10.0.0.1";
    
    NSMutableString *urlString = @"?".mutableCopy;
    for (NSString *key in params.allKeys) {
        [urlString appendFormat:@"%@=%@&", key, params[key]];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", url, urlString];
    requestUrl = [requestUrl substringToIndex:requestUrl.length - 1];
    
    [TWSNSRequest get:requestUrl completionHandler:^(NSDictionary *data, NSError *error) {
        NSMutableDictionary *dict = data.mutableCopy;
        [dict addEntriesFromDictionary:message];
        if (completionHandler) {
            completionHandler(dict, error);
        }
    }];
}




@end
