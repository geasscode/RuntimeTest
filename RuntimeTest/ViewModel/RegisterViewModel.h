//
//  RegisterViewModel.h
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id response);
typedef void(^Failure)();
typedef void(^Error)(NSError * error);

@interface RegisterViewModel : NSObject

/** 请求验证码 */
- (void)requestSmsCodeWithmobilePhoneNumber:(NSString *)phoneNum success:(Success)success failure:(Failure)failure error:(Error)errorBlock;
/** 注册 */
- (void)registerWithNum:(NSString *)num smscode:(NSString *)smscode password:(NSString *)password success:(Success)success failure:(Failure)failure error:(Error)errorBlock;
/** 注册 */
- (void)registerWithNum:(NSString *)num password:(NSString *)password success:(Success)success failure:(Failure)failure error:(Error)errorBlock;
/** 请求重置验证码 */
- (void)requestPasswordResetBySmsCodeWithmobilePhoneNumber:(NSString *)phoneNum success:(Success)success failure:(Failure)failure error:(Error)errorBlock;
/** 请求重置 */
- (void)resetPasswordBySmsCode:(NSString *)code password:(NSString *)password  success:(Success)success failure:(Failure)failure error:(Error)errorBlock;
/** 请求重置 */
- (void)resetPasswordWithPhoneNumber:(NSString *)phoneNum smsCode:(NSString *)code password:(NSString *)password  success:(Success)success failure:(Failure)failure error:(Error)errorBlock;

@end
