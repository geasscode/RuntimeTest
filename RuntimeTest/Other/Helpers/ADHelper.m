//
//  ADHelper.m
//  RuntimeTest
//
//  Created by desmond on 16/6/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ADHelper.h"

#import "ADHelper.h"
#import "DESWebViewController.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])

@interface ADHelper()
@property (nonatomic, strong) UIWindow* window;
@property (nonatomic, assign) NSInteger downCount;
@property (nonatomic, weak) UIButton* downCountButton;
@property (nonatomic, strong) UIImageView *adView;
@property (nonatomic, weak) UIImage *adImage;


@end

@implementation ADHelper
///在load 方法中，启动监听，可以做到无注入
+ (void)load
{
	[self shareInstance];
}
+ (instancetype)shareInstance
{
	static id instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
	});
	return instance;
}
- (instancetype)init
{
	self = [super init];
	if (self) {
		
		///如果是没啥经验的开发，请不要在初始化的代码里面做别的事，防止对主线程的卡顿，和 其他情况
		
		///应用启动, 首次开屏广告
		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
			///要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
			dispatch_async(dispatch_get_main_queue(), ^{
				[self checkAD];
			});
		}];
		///进入后台
		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
			[self request];
		}];
		///后台启动,二次开屏广告
		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
			[self checkAD];
		}];
	}
	return self;
}
- (void)request
{
	///.... 请求新的广告数据
}
- (void)checkAD
{
	///如果有则显示，无则请求， 下次启动再显示。
	///我们这里都当做有
	[self show];
}
- (void)show
{
	///初始化一个Window， 做到对业务视图无干扰。
	UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	///广告布局
	[self setupSubviews:window];
	
	///设置为最顶层，防止 AlertView 等弹窗的覆盖
	window.windowLevel = UIWindowLevelStatusBar + 1;
	
	///默认为YES，当你设置为NO时，这个Window就会显示了
	window.hidden = NO;
	
	///来个渐显动画
	window.alpha = 0;
	[UIView animateWithDuration:0.3 animations:^{
		window.alpha = 1;
	}];
	
	///防止释放，显示完后  要手动设置为 nil
	self.window = window;
}

- (void)letGo
{
	///不直接取KeyWindow 是因为当有AlertView 或者有键盘弹出时， 取到的KeyWindow是错误的。
	UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
	[[rootVC des_navigationController] pushViewController:[DESWebViewController new] animated:YES];
	
	[self hide];
}
- (void)goOut
{
	[self hide];
}
- (void)hide
{
	///来个渐显动画
	[UIView animateWithDuration:0.3 animations:^{
		self.window.alpha = 0;
	} completion:^(BOOL finished) {
		[self.window.subviews.copy enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			[obj removeFromSuperview];
		}];
		self.window.hidden = YES;
		self.window = nil;
	}];
}

///初始化显示的视图， 可以挪到具
- (void)setupSubviews:(UIWindow*)window
{
	///随便写写
	_adView = [[UIImageView alloc] initWithFrame:window.bounds];
	
	[self downloadAdImage];

//	imageView.image = [UIImage imageNamed:@"adimage.png"];
	
//	imageView.image = [UIImage imageNamed:@"adimage.png"];

	_adView.userInteractionEnabled = YES;
	

//	[imageView setImage:[self imageCompressForWidth:imageView.image targetWidth:kScreenWidth]];

	///给非UIControl的子类，增加点击事件
	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(letGo)];
	[_adView addGestureRecognizer:tap];
	
	[window addSubview:_adView];
	
	///增加一个倒计时跳过按钮
	self.downCount = 3;
	
	UIButton * goout = [[UIButton alloc] initWithFrame:CGRectMake(window.bounds.size.width - 100 - 20, 20, 100, 60)];
	[goout setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
	[goout addTarget:self action:@selector(goOut) forControlEvents:UIControlEventTouchUpInside];
	[window addSubview:goout];
	
	self.downCountButton = goout;
	[self timer];
}
- (void)timer
{
	[self.downCountButton setTitle:[NSString stringWithFormat:@"跳过：%ld",(long)self.downCount] forState:UIControlStateNormal];
	if (self.downCount <= 0) {
		[self hide];
	}
	else {
		self.downCount --;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self timer];
		});
	}
}

- (void)downloadAdImage{
	NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
	NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
	
	
	[NetTool GET:path parameters:nil complete:^(NSURLSessionDataTask *operation, id responseObject, NSError *error) {
		
		if (!error) {
			
		 NSArray *adArray = [responseObject valueForKey:@"ads"];
			NSString *imgUrl = adArray[0][@"res_url"][0];
			NSString *imgUrl2 = nil;
			if (adArray.count >1) {
				imgUrl2= adArray[1][@"res_url"][0];
			}
			
			BOOL one = [[NSUserDefaults standardUserDefaults]boolForKey:@"one"];
			if (imgUrl2.length > 0) {
				if (one) {
					
					
					[self downloadImage:imgUrl];
					[[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
				}else{
					[self downloadImage:imgUrl2];
					[[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
				}
			}else{
				[self downloadImage:imgUrl];
			}
			
			
		}else{
			
			NSLog(@"%@",error);
		}
		
	}];
	
}

- (void)downloadImage:(NSString *)imageUrl
{
	
	SDWebImageManager *manager = [SDWebImageManager sharedManager];
	[manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
		
	} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
		if (image) {
			self.adImage = image;
			[self.adView setImage:[self imageCompressForWidth:image targetWidth:kScreenWidth]];
		}
	}];
	
}


- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
	UIImage *newImage = nil;
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = defineWidth;
	CGFloat targetHeight = height / (width / targetWidth);
	CGSize size = CGSizeMake(targetWidth, targetHeight);
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
	
	if(CGSizeEqualToSize(imageSize, size) == NO){
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if(widthFactor > heightFactor){
			scaleFactor = widthFactor;
		}
		else{
			scaleFactor = heightFactor;
		}
		scaledWidth = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		if(widthFactor > heightFactor){
			
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
			
		}else if(widthFactor < heightFactor){
			
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	//    UIGraphicsBeginImageContext(size);
	UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	if(newImage == nil){
		NSLog(@"scale image fail");
	}
	
	UIGraphicsEndImageContext();
	return newImage;
}

/**


- (void)getAdvertisingImage
{
	
	// TODO 请求广告接口
	
	// 这里原本采用美团的广告接口，现在了一些固定的图片url代替
	NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
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



- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isDirectory = FALSE;
	return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}




- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
	
	NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
	NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
	
	
	[NetTool GET:path parameters:nil complete:^(NSURLSessionDataTask *operation, id responseObject, NSError *error) {
		
		if (!error) {
			
		 NSArray *adArray = [responseObject valueForKey:@"ads"];
			NSString *imgUrl = adArray[0][@"res_url"][0];
			NSString *imgUrl2 = nil;
			if (adArray.count >1) {
				imgUrl2= adArray[1][@"res_url"][0];
			}
			
			BOOL one = [[NSUserDefaults standardUserDefaults]boolForKey:@"one"];
			if (imgUrl2.length > 0) {
				if (one) {
					
					[self downloadImage:imgUrl];
//					[self loadImageWithName:imageName imageURL:imgUrl];
					[[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
				}else{
					[self downloadImage:imgUrl2];
//					[self loadImageWithName:imageName imageURL:imgUrl2];
					[[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
				}
			}else{
				[self downloadImage:imgUrl];
			}
			
			
		}else{
			
			NSLog(@"%@",error);
		}
		
	}];
	
}

- (void)downloadImage:(NSString *)imageUrl
{
	
	SDWebImageManager *manager = [SDWebImageManager sharedManager];
	[manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
		
	} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
		if (image) {
			self.adImage = image;
			 [self.adView setImage:[self imageCompressForWidth:image targetWidth:kScreenWidth]];
		}
	}];
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
//	NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//	NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//		if (data) {
//			[data writeToFile:kCachedNewImage atomically:YES];
//		}
//	}];
//	[task resume];
}

- (void)loadImageWithName:(NSString*)imageName imageURL:(NSString *)imgUrl{
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
		UIImage *image = [UIImage imageWithData:data];
		
		[self.adView setImage:[self imageCompressForWidth:image targetWidth:kScreenWidth]];
		
		
		NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
		
		if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
			NSLog(@"保存成功");
			[self deleteOldImage];
			[kUserDefaults setValue:imageName forKey:@"adImageName"];
			[kUserDefaults synchronize];
			// 如果有广告链接，将广告链接也保存下来
		}else{
			NSLog(@"保存失败");
		}
		
	});
}



- (void)deleteOldImage
{
	NSString *imageName = [kUserDefaults valueForKey:@"adImageName"];
	if (imageName) {
		NSString *filePath = [self getFilePathWithImageName:imageName];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager removeItemAtPath:filePath error:nil];
	}
}



- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
	if (imageName) {
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
		NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
		
		return filePath;
	}
	
	return nil;
}

****/

@end
