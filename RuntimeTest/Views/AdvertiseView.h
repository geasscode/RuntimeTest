//
//  AdvertiseView.h
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const adImageName = @"adImageName";

@interface AdvertiseView : UIView
/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

//- (BOOL)isShouldDisplayAd;
//- (UIImage *)getAdImage;
//- (void)loadLatestAdImage;

- (NSString *)getFilePathWithImageName:(NSString *)imageName;
- (BOOL)isFileExistWithFilePath:(NSString *)filePath;
- (void)getAdvertisingImage;

@end
