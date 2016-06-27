//
//  UtilsMacro.h
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

/* 宏字符串操作，避免在宏里面嵌套使用宏带来的问题 */
#define TB_stringify(STR) # STR
#define TB_string_concat(A, B) A ## B

/*
 * 用于防止在 Blocks 里面循环引用变量，并且无需改变变量名的写法。`TB_weakify` 和 `TB_strongify` 要搭配使用，`TB_weakify`
 * 用于将变量弱化，`TB_strongify` 用于在 Blocks 开始执行后将变量进行强引用，防止执行过程中变量被释放（多线程的情况下）。
 */
#define TBWeakSelf(VAR) \
__weak __typeof__(VAR) TB_string_concat(VAR, _weak_) = (VAR)

#define TBStrongSelf(VAR) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(VAR) VAR = TB_string_concat(VAR, _weak_) \
_Pragma("clang diagnostic pop")

#pragma mark - const values


#define kContainerLeft ((kScreenWidth - self.sheetWidth)/2)

#define kiOS7Later ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define kiOS8Later ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
#define kiOS9Later ([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//8.0之前AlertView
#define Alert(_S_, ...) [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define kUserDefaults [NSUserDefaults standardUserDefaults]

// 随机颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

// 利用这种方法设置颜色和透明值，可不影响子视图背景色
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//全局的绿色主题
#define WNXColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define WNXGolbalGreen WNXColor(33, 197, 180)

//抽屉顶部距离 底部一样
#define WNXScaleTopMargin 35
//app的高度
#define WNXAppWidth ([UIScreen mainScreen].bounds.size.width)
//app的宽度
#define WNXAppHeight ([UIScreen mainScreen].bounds.size.height)
//抽屉拉出来右边剩余比例
#define WNXZoomScaleRight 0.14

//推荐cell的高度
#define WNXRnmdCellHeight 210.0
//推荐headView的高度
#define WNXRnmdHeadViewHeight 60.0
//背景的灰色
#define WNXBackgroundGrayColor WNXColor(51, 52, 53)
//判断系统版本号是否是iOS8以上
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define FilePATH(FileName,FileType) [[NSBundle mainBundle]pathForResource:FileName ofType:FileType]
#define WNXCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]


#ifndef Define_h
#define Define_h


#pragma mark 获取当前屏幕的宽度、高度

#define kScreenFrame [UIScreen mainScreen].bounds
//宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//导航条高度
#define kNavBarHeight 64

#define UICOLOR_FROM_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kAppWhiteColor [UIColor whiteColor]//白色
#define kAppDarkGrayColor [UIColor darkGrayColor]//深灰色
#define kAppGrayColor [UIColor grayColor]//灰色
#define kAppMainBgColor UICOLOR_FROM_RGB(240,240,240,1)
#define kTabBarNormalColor RGB(170, 170, 170)         // TabBar颜色
#define navigationBarColor RGB(33, 192, 174)

//RGB色值
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_BASE UIColorFromRGB(0X505975)
#define COLOR_LIGHT [UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1]

#define FilePATH(FileName,FileType) [[NSBundle mainBundle]pathForResource:FileName ofType:FileType]

/**
 *  1.返回一个RGBA格式的UIColor对象
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 *  2.返回一个RGB格式的UIColor对象
 */
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

#define kGlobalBackgroundColor RGB(245, 240, 215)     // 背景颜色
#define kLabelColorWhite RGB(255, 255, 255)           // 字体颜色：白色
#define kLabelColorGray [UIColor grayColor]           // 字体颜色：灰色
#define kCoverViewColor RGBA(0, 0, 0, 0.2)            // 黑色半透明遮盖
#define kTabBarNormalColor RGB(170, 170, 170)         // TabBar颜色
#define kThemeColor RGB(249, 103, 80)        // TabBar选中颜色
#define kSearchBarTintColor RGB(192, 192, 192)        // 搜索按钮背景色
#define kDishViewBackgroundColor RGB(235, 235, 226)   // 作品view背景色
#define kAddressCellColor RGB(215, 228, 225)          // 收货地址选中颜色



#define globalColor [UIColor colorWithRed:255/255.0 green:70/255.0 blue:131/255.0 alpha:1.0]


#define kColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//弱引用
#define __WeakSelf__ __weak typeof (self)

//字体
#define UIFont_size(size) [UIFont systemFontOfSize:size]
#define NavColor [UIColor colorWithRed:22.0/255.0 green:147.0/255.0 blue:114.0/255.0 alpha:1.0]

#endif /* Define_h */


#define BoldSystemFont(size)  [UIFont boldSystemFontOfSize:size]
#define systemFont(size)      [UIFont systemFontOfSize:size]
#define isIOS7                [[UIDevice currentDevice].systemVersion doubleValue]>=7.0?YES:NO
#define isGreatThanIOS9       [[UIDevice currentDevice].systemVersion doubleValue]>=9.0
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
#define STATUSBAR_HEIGHT      [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         (44.f + ((SYSTEM_VERSION >= 7) ? STATUSBAR_HEIGHT : 0))

#define FULL_WIDTH            SCREEN_WIDTH
#define FULL_HEIGHT           (SCREEN_HEIGHT - ((SYSTEM_VERSION >= 7) ? 0 : STATUSBAR_HEIGHT))
#define CONTENT_HEIGHT        (FULL_HEIGHT - NAVBAR_HEIGHT)

// 获取 View 的 frame 的属性
#define GetViewWidth(view)    view.frame.size.width
#define GetViewHeight(view)   view.frame.size.height
#define GetViewX(view)        view.frame.origin.x
#define GetViewY(view)        view.frame.origin.y

// common
#define UserDefaults          [NSUserDefaults standardUserDefaults]

#define IsStringEmpty(string) (!string || [@"" isEqualToString:string])
#define IsStringNotEmpty(string) (string && ![@"" isEqualToString:string])



//全局打印
#ifdef DEBUG
#define DMLog(...)NSLog(@"%s%@",__PRETTY_FUNCTION__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DMLog(...) do { } while (0)
#endif


//更加完善点的全局打印

//__VA_ARGS__是一个可变参数的宏，这个可变参数的宏是新的C99规范中新增的，目前似乎只有gcc支（VC6.0的编译器不支持）。宏前面加上##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的","去掉的作用,否则会编译出错, 你可以试试。
//__FILE__宏在预编译时会替换成当前的源文件名
//__LINE__宏在预编译时会替换成当前的行号
//__FUNCTION__宏在预编译时会替换成当前的函数名称

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif



#pragma clang diagnostic ignored "-W#warnings"

#ifndef weakifyObject
#if __has_feature(objc_arc)
#define weakifyObject(object) ext_keywordify __weak __typeof__(object) weak##_##object = object;
#else
#define weakifyObject(object) ext_keywordify __block __typeof__(object) block##_##object = object;
#endif
#endif

#ifndef strongifyObject
#if __has_feature(objc_arc)
#define strongifyObject(object) ext_keywordify __strong __typeof__(object) object = weak##_##object;
#else
#define strongifyObject(object)                                                                    \
ext_keywordify __strong __typeof__(object) object = block##_##object;
#endif
#endif

#undef YZWeak
#define YZWeak(...) @weakifyObject(__VA_ARGS__)

#undef YZStrong
#define YZStrong(...) @strongifyObject(__VA_ARGS__)

#if DEBUG
#define ext_keywordify                                                                             \
autoreleasepool {                                                                              \
}
#else
#define ext_keywordify                                                                             \
try {                                                                                          \
} @catch (...) {                                                                               \
}
#endif




#ifdef DEBUG

#define WNXLog(...)  NSLog(__VA_ARGS__)

#else

#define WNXLog(...)

#endif


#endif /* UtilsMacro_h */
