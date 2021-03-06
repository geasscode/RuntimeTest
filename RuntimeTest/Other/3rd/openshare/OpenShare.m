//
//  OpenShare.m
//  openshare
//
//  Created by LiuLogan on 15/5/13.
//  Copyright (c) 2015年 OpenShare. All rights reserved.
//

#import "OpenShare.h"

@implementation OpenShare
/**
 *  用于保存各个平台的key。每个平台需要的key／appid不一样，所以用dictionary保存。
 */
static NSMutableDictionary *keys;
                                  
+(void)set:(NSString*)platform Keys:(NSDictionary *)key{
    if (!keys) {
        keys=[[NSMutableDictionary alloc] init];
    }
    keys[platform]=key;
}
+(NSDictionary *)keyFor:(NSString*)platform{
    return [keys valueForKey:platform]?keys[platform]:nil;
}

+(void)openURL:(NSString*)url{
	
	//如果生成的callback_name 不正确会导致无法弹出回调信息界面。openShare 生成的callbackName 代码有问题。正确的应该是 QQ06071A28 前面有0，
	//而生成的是QQ6071a28 前面没有补0.
	//解决问题思路，一半靠的是运气，首先将有问题的app ID 复制到 demo里面执行。发现原先正常可以弹出分享页面的突然不行了，然后被qq开发者平台误导了，以为App 审核通过
	//才有资格分享，由于审核太过繁琐，于是转而用ShareSDK，幸运的是提示缺少QQ06071A28的错误提示，结果一对比打印出来QQ6071a28，就知道错在哪里了。
	
//	NSString * myurl = @"mqqapi://share/to_fri?thirdAppDisplayName=T3BlbiBTaGFyZQ==&version=1&cflag=1&callback_type=scheme&generalpastboard=1&callback_name=QQ41c1685f&src_type=app&shareType=0&file_type=news&title=SGVsbG8gT3BlblNoYXJlIChtc2cudGl0bGUpIDE0Njk2ODg4MTYuNzIyMzg4&url=aHR0cDovL3Nwb3J0cy5xcS5jb20vYS8yMDEyMDUxMC8wMDA2NTAuaHRt&description=6L+Z6YeM5YaZ55qE5pivbXNnLmRlc2NyaXB0aW9uIDE0Njk2ODg4MTYuNzIyNDg3&objectlocation=pasteboard";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
+(BOOL)canOpen:(NSString*)url{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}
+(BOOL)handleOpenURL:(NSURL*)openUrl{
    returnedURL=openUrl;
    for (NSString *key in keys) {
        SEL sel=NSSelectorFromString([key stringByAppendingString:@"_handleOpenURL"]);
        if ([self respondsToSelector:sel]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [self methodSignatureForSelector:sel]];
            [invocation setSelector:sel];
            [invocation setTarget:self];
            [invocation invoke];
            BOOL returnValue;
            [invocation getReturnValue:&returnValue];
            if (returnValue) {//如果这个url能处理，就返回YES，否则，交给下一个处理。
                return YES;
            }
        }else{
            NSLog(@"fatal error: %@ is should have a method: %@",key,[key stringByAppendingString:@"_handleOpenURL"]);
        }
    }
    return NO;
}

#pragma mark 分享／auth以后，应用被调起，回调。
static NSURL* returnedURL;
static NSDictionary *returnedData; 
static shareSuccess shareSuccessCallback;
static shareFail shareFailCallback;

static authSuccess authSuccessCallback;
static authFail authFailCallback;

static paySuccess paySuccessCallback;
static payFail payFailCallback;

static OSMessage *message;
+(shareSuccess)shareSuccessCallback{
    return shareSuccessCallback;
}
+(shareFail)shareFailCallback{
    return shareFailCallback;
}
+(void)setShareSuccessCallback:(shareSuccess)suc{
    shareSuccessCallback=suc;
}
+(void)setShareFailCallback:(shareFail)fail{
    shareFailCallback=fail;
}
+(void)setPaySuccessCallback:(paySuccess)suc{
    paySuccessCallback=suc;
}
+(void)setPayFailCallback:(payFail)fail{
    payFailCallback=fail;
}
+(paySuccess)paySuccessCallback{
    return paySuccessCallback;
}
+(payFail)payFailCallback{
    return payFailCallback;
}
+(NSURL*)returnedURL{
    return returnedURL;
}
+(NSDictionary*)returnedData{
    return returnedData;
}
+(void)setReturnedData:(NSDictionary*)retData{
    returnedData=retData;
}
+(void)setMessage:(OSMessage*)msg{
    message=msg;
}
+(OSMessage*)message{
    return message?:[[OSMessage alloc] init];
}
+(authSuccess)authSuccessCallback{
    return authSuccessCallback;
}
+(authFail)authFailCallback{
    return authFailCallback;
}
+(BOOL)beginShare:(NSString*)platform Message:(OSMessage*)msg Success:(shareSuccess)success Fail:(shareFail)fail{
    if ([self keyFor:platform]) {
        message=msg;
        shareSuccessCallback=success;
        shareFailCallback=fail;
        return YES;
    }else{
        NSLog(@"please connect%@ before you can share to it!!!",platform);
        return NO;
    }
}
+(BOOL)beginAuth:(NSString*)platform Success:(authSuccess)success Fail:(authFail)fail{
    if ([self keyFor:platform]) {
        authSuccessCallback=success;
        authFailCallback=fail;
        return YES;
    }else{
        NSLog(@"please connect%@ before you can share to it!!!",platform);
        return NO;
    }
}

#pragma mark 公共实用方法
+(NSMutableDictionary *)parseUrl:(NSURL*)url{
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [[url query] componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSRange range=[keyValuePair rangeOfString:@"="];
        [queryStringDictionary setObject:range.length>0?[keyValuePair substringFromIndex:range.location+1]:@"" forKey:(range.length?[keyValuePair substringToIndex:range.location]:keyValuePair)];
    }
    return queryStringDictionary;
}
+(NSString*)base64Encode:(NSString *)input{
    return  [[input dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}
+(NSString*)base64Decode:(NSString *)input{
   return [[NSString alloc ] initWithData:[[NSData alloc] initWithBase64EncodedString:input options:0] encoding:NSUTF8StringEncoding];
}
+(NSString*)CFBundleDisplayName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}
+(NSString*)CFBundleIdentifier{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
+(void)setGeneralPasteboard:(NSString*)key Value:(NSDictionary*)value encoding:(OSPboardEncoding)encoding{
    if (value&&key) {
        NSData *data=nil;
        NSError *err;
        switch (encoding) {
            case OSPboardEncodingKeyedArchiver:
                data=[NSKeyedArchiver archivedDataWithRootObject:value];
                break;
            case OSPboardEncodingPropertyListSerialization:
                data=[NSPropertyListSerialization dataWithPropertyList:value format:NSPropertyListBinaryFormat_v1_0 options:0 error:&err];
            default:
                NSLog(@"encoding not implemented");
                break;
        }
        if (err) {
            NSLog(@"error when NSPropertyListSerialization: %@",err);
        }else if (data){
            [[UIPasteboard generalPasteboard] setData:data forPasteboardType:key];
        }
    }
}
+(NSDictionary*)generalPasteboardData:(NSString*)key encoding:(OSPboardEncoding)encoding{
    NSData *data=[[UIPasteboard generalPasteboard] dataForPasteboardType:key];
    NSDictionary *dic=nil;
    if (data) {
        NSError *err;
        switch (encoding) {
            case OSPboardEncodingKeyedArchiver:
                dic= [NSKeyedUnarchiver unarchiveObjectWithData:data];
                break;
            case OSPboardEncodingPropertyListSerialization:
                dic=[NSPropertyListSerialization propertyListWithData:data options:0 format:0 error:&err];
            default:
                break;
        }
        if (err) {
            NSLog(@"error when NSPropertyListSerialization: %@",err);
        }
    }
    return dic;
}
+(NSString*)base64AndUrlEncode:(NSString *)string{
    return  [[self base64Encode:string] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}
+(NSString*)urlDecode:(NSString*)input{
   return [[input stringByReplacingOccurrencesOfString:@"+" withString:@" "]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
/**
 *  截屏功能。via：http://stackoverflow.com/a/8017292/3825920
 *
 *  @return 对当前窗口截屏。（支付宝可能需要）
 */
+ (UIImage *)screenshot
{
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSData *)dataWithImage:(UIImage *)image {
    return UIImageJPEGRepresentation(image, 1);
}

+ (NSData *)dataWithImage:(UIImage *)image scale:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(scaledImage, 1);
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size{
       UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end

@implementation OSMessage
-(BOOL)isEmpty:(NSArray*)emptyValueForKeys AndNotEmpty:(NSArray*)notEmptyValueForKeys{
    @try {
        if (emptyValueForKeys) {
            for (NSString *key in emptyValueForKeys) {
                if ([self valueForKeyPath:key]) {
                    return NO;
                }
            }
        }
        if (notEmptyValueForKeys) {
            for (NSString *key in notEmptyValueForKeys) {
                if (![self valueForKey:key]) {
                    return NO;
                }
            }
        }
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"isEmpty error:\n %@",exception);
        return NO;
    }
}

@end