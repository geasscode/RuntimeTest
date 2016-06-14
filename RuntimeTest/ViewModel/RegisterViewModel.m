//
//  RegisterViewModel.m
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

/*
- (void)requestSmsCodeWithmobilePhoneNumber:(NSString *)phoneNum success:(Success)success failure:(Failure)failure error:(Error)errorBlock {
	NSDictionary * dic = @{
						   @"mobilePhoneNumber": phoneNum
						   };
	
	[[NetworkRequest Request]request:BASE_URL(@"requestSmsCode") Type:POST parameters:[dic toJson] success:^(id response) {
		if ([response[@"code"]isEqualToString:CODE_SUCCESS]) {
			success (response);
		}else {
			failure (nil);
		}
	} error:^(NSError *error) {
		errorBlock(error);
	}];
}

- (void)registerWithNum:(NSString *)num smscode:(NSString *)smscode password:(NSString *)password success:(Success)success failure:(Failure)failure error:(Error)errorBlock {
	NSString * validCodeUrl = [NSString stringWithFormat:@"verifySmsCode/%@?mobilePhoneNumber=%@",smscode,num];
	[[NetworkRequest Request]request:BASE_URL(validCodeUrl) Type:POST parameters:nil success:^(id response) {
		
		[self registerWithNum:num password:[[password do16MD5] doBase64] success:^(id response) {
			success (success);
		} failure:^{
			failure (nil);
		} error:^(NSError *error) {
			errorBlock(error);
		}];
		
	} error:^(NSError *error) {
		errorBlock(error);
	}];
	
}

- (void)registerWithNum:(NSString *)num password:(NSString *)password success:(Success)success failure:(Failure)failure error:(Error)errorBlock {
	NSDictionary * dic = @{
						   @"username": num,
						   @"password": password,
						   @"mobilePhoneNumber": num
						   };
	[[NetworkRequest Request]request:BASE_URL(@"users") Type:POST parameters:[dic toJson] success:^(id response) {
		if (response[@"sessionToken"]) {
			success (response);
		}else {
			failure (nil);
		}
		
	} error:^(NSError *error) {
		errorBlock(error);
	}];
}

- (void)requestPasswordResetBySmsCodeWithmobilePhoneNumber:(NSString *)phoneNum success:(Success)success failure:(Failure)failure error:(Error)errorBlock {
	NSDictionary * dic = @{
						   @"mobilePhoneNumber": phoneNum
						   };
	
	[[NetworkRequest Request]request:BASE_URL(@"requestPasswordResetBySmsCode") Type:POST parameters:[dic toJson] success:^(id response) {
		if ([response[@"code"]isEqualToString:CODE_SUCCESS]) {
			success (response);
		}else {
			failure (nil);
		}
	} error:^(NSError *error) {
		errorBlock(error);
	}];
}

- (void)resetPasswordBySmsCode:(NSString *)code password:(NSString *)password success:(Success)success failure:(Failure)failure error:(Error)errorBlock {
	NSDictionary * dic = @{
						   @"password": password
						   };
	NSString * url = [NSString stringWithFormat:@"resetPasswordBySmsCode/%@",code];
	[[NetworkRequest Request]request:BASE_URL(url) Type:PUT parameters:[dic toJson] success:^(id response) {
		success (response);
	} error:^(NSError *error) {
		errorBlock (error);
	}];
}

- (void)resetPasswordWithPhoneNumber:(NSString *)phoneNum smsCode:(NSString *)code password:(NSString *)password success:(Success)success failure:(Failure)failure error:(Error)errorBlock {
	[self requestPasswordResetBySmsCodeWithmobilePhoneNumber:phoneNum success:^(id response) {
		
		[self resetPasswordBySmsCode:code password:password success:^(id response) {
			success(response);
		} failure:^{
			failure(nil);
		} error:^(NSError *error) {
			errorBlock(error);
		}];
		
	} failure:^{
		failure(nil);
	} error:^(NSError *error) {
		errorBlock(error);
	}];
}
*/
@end
