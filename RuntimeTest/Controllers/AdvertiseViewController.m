//
//  AdvertiseViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "AdvertiseViewController.h"

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface AdvertiseViewController ()

@end

@implementation AdvertiseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isDirectory = FALSE;
	return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
	
	// 这里原本采用美团的广告接口，现在没法用了。所以用了一些固定的图片url代替
	NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/fd039245d688d43f70b37c1a7d1ed21b0ff43bc4.jpg", @"http://a4.mzstatic.com/us/r30/Purple6/v4/93/3e/10/933e1072-791b-49d5-4292-db6cb4f7ab5f/screen640x960.jpeg", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://a.hiphotos.baidu.com/image/pic/item/b21c8701a18b87d6ff2ca7bc030828381f30fd23.jpg"];
	NSString *imageUrl = imageArray[arc4random() % imageArray.count];
	
	// 获取图片名:43-130P5122Z60-50.jpg
	NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
	NSString *imageName = stringArr.lastObject;
	
	// 拼接沙盒路径
	NSString *filePath = [self getFilePathWithImageName:imageName];
	BOOL isExist = [self isFileExistWithFilePath:filePath];
	if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
		
		[self downloadAdImageWithUrl:imageUrl imageName:imageName];
		
	}
	
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
		UIImage *image = [UIImage imageWithData:data];
		
		NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
		
		if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
			NSLog(@"保存成功");
			[self deleteOldImage];
			[UserDefaults setValue:imageName forKey:adImageName];
			[UserDefaults synchronize];
			// 如果有广告链接，将广告链接也保存下来
		}else{
			NSLog(@"保存失败");
		}
		
	});
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
	NSString *imageName = [UserDefaults valueForKey:adImageName];
	if (imageName) {
		NSString *filePath = [self getFilePathWithImageName:imageName];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager removeItemAtPath:filePath error:nil];
	}
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
	if (imageName) {
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
		NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
		
		return filePath;
	}
	
	return nil;
}
@end
