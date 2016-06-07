//
//  AdvertiseViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseViewController : UIViewController

- (NSString *)getFilePathWithImageName:(NSString *)imageName;
- (BOOL)isFileExistWithFilePath:(NSString *)filePath;
- (void)getAdvertisingImage;



@end
