//
//  AdvertiseView.m
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "AdvertiseView.h"


#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])

@interface AdvertiseView()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

+ (void)downloadImage:(NSString *)imageUrl;


@end

// 广告显示的时间
static int const showtime = 3;

@implementation AdvertiseView

- (NSTimer *)countTimer
{
	if (!_countTimer) {
		_countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
	}
	return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		
		// 1.广告图片
		_adView = [[UIImageView alloc] initWithFrame:frame];
		_adView.userInteractionEnabled = YES;
		_adView.contentMode = UIViewContentModeScaleAspectFill;

		_adView.clipsToBounds = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
		[_adView addGestureRecognizer:tap];
		
		// 2.跳过按钮
		CGFloat btnW = 60;
		CGFloat btnH = 30;
		_countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - btnW - 24, btnH, btnW, btnH)];
		[_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
		[_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
		_countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
		[_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
		_countBtn.layer.cornerRadius = 4;
		
		[self addSubview:_adView];
		[self addSubview:_countBtn];
		
	}
	return self;
}


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

/**
 *  下载新图片
 */
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
					[self loadImageWithName:imageName imageURL:imgUrl];
					[[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
				}else{
					[self downloadImage:imgUrl2];
					[self loadImageWithName:imageName imageURL:imgUrl2];
					[[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
				}
			}else{
				[self downloadImage:imgUrl];
			}

			
		}else{
			
			NSLog(@"%@",error);
		}
		
	}];


//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		
//		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//		UIImage *image = [UIImage imageWithData:data];
//		
//		NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
//		
//		if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
//			NSLog(@"保存成功");
//			[self deleteOldImage];
//			[kUserDefaults setValue:imageName forKey:adImageName];
//			[kUserDefaults synchronize];
//			// 如果有广告链接，将广告链接也保存下来
//		}else{
//			NSLog(@"保存失败");
//		}
//		
//	});
}




- (void)loadImageWithName:(NSString*)imageName imageURL:(NSString *)imgUrl{
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
		UIImage *image = [UIImage imageWithData:data];
		
		NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
		
		if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
			NSLog(@"保存成功");
			[self deleteOldImage];
			[kUserDefaults setValue:imageName forKey:adImageName];
			[kUserDefaults synchronize];
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
	NSString *imageName = [kUserDefaults valueForKey:adImageName];
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


- (void)setFilePath:(NSString *)filePath
{
	_filePath = filePath;
	_adView.image = [UIImage imageWithContentsOfFile:filePath];
}

- (void)pushToAd{
	
	[self dismiss];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoad" object:nil userInfo:nil];
}

- (void)countDown
{
	_count --;
	[_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
	if (_count == 0) {
		[self.countTimer invalidate];
		self.countTimer = nil;
		[self dismiss];
	}
}

- (void)show
{
	// 倒计时方法1：GCD
	//    [self startCoundown];
	
	// 倒计时方法2：定时器
	[self startTimer];
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[window addSubview:self];
}

// 定时器倒计时
- (void)startTimer
{
	_count = showtime;
	[[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown
{
	__block int timeout = showtime + 1; //倒计时时间 + 1
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
	dispatch_source_set_event_handler(_timer, ^{
		if(timeout <= 0){ //倒计时结束，关闭
			dispatch_source_cancel(_timer);
			dispatch_async(dispatch_get_main_queue(), ^{
				
				[self dismiss];
				
			});
		}else{
			
			dispatch_async(dispatch_get_main_queue(), ^{
				[_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
			});
			timeout--;
		}
	});
	dispatch_resume(_timer);
}

// 移除广告页面
- (void)dismiss
{
	[UIView animateWithDuration:0.3f animations:^{
		
		self.alpha = 0.f;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
		
	}];
	
}


+ (BOOL)isShouldDisplayAd
{
	return ([[NSFileManager defaultManager]fileExistsAtPath:kCachedCurrentImage isDirectory:NULL] || [[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NULL
																									  ]);
}

+ (UIImage *)getAdImage
{
	if ([[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NULL]) {
		[[NSFileManager defaultManager]removeItemAtPath:kCachedCurrentImage error:nil];
		[[NSFileManager defaultManager]moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
	}
	return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

- (void)downloadImage:(NSString *)imageUrl
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		if (data) {
			[data writeToFile:kCachedNewImage atomically:YES];
		}
	}];
	[task resume];
}


@end
