//
//  loadXIBFile.m
//  RuntimeTest
//
//  Created by desmond on 16/3/21.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "loadXIBFile.h"
#import "MJExtension.h"
#import "MJStatus.h"
#import "MJUser.h"
#import "MJStatusResult.h"
#import "MJAd.h"
#import "MJStudent.h"
#import "MJBag.h"

@interface loadXIBFile ()

@end

@implementation loadXIBFile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xibTest:(UIButton *)sender {
	NSLog(@"what");

}

- (IBAction)testMJExtension:(UIButton *)sender {
	MJExtensionLog(@"hello");
	execute(keyValues2object2, @"复杂的字典 -> 模型 (模型里面包含了模型)");
	execute(keyValues2object3, @"复杂的字典 -> 模型 (模型的数组属性里面又装着模型)");
	execute(keyValues2object4, @"简单的字典 -> 模型（key替换，比如ID和id，支持多级映射）");
	execute(keyValuesArray2objectArray, @"字典数组 -> 模型数组");
	execute(object2keyValues, @"模型转字典");
	execute(objectArray2keyValuesArray, @"模型数组 -> 字典数组");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



void execute(void (*fn)(), NSString *comment)
{
	MJExtensionLog(@"[******************%@******************开始]", comment);
	fn();
	MJExtensionLog(@"[******************%@******************结尾]\n ", comment);
}


void keyValues2object2()
{
	// 1.定义一个字典
	NSDictionary *dict = @{
						   @"text" : @"是啊，今天天气确实不错！",
						   
						   @"user" : @{
								   @"name" : @"Jack",
								   @"icon" : @"lufy.png"
								   },
						   
						   @"retweetedStatus" : @{
								   @"text" : @"今天天气真不错！",
								   
								   @"user" : @{
										   @"name" : @"Rose",
										   @"icon" : @"nami.png"
										   }
								   }
						   };
	
	// 2.将字典转为Status模型
	MJStatus *status = [MJStatus mj_objectWithKeyValues:dict];
	
	// 3.打印status的属性
	NSString *text = status.text;
	NSString *name = status.user.name;
	NSString *icon = status.user.icon;
	MJExtensionLog(@"text=%@, name=%@, icon=%@", text, name, icon);
	
	// 4.打印status.retweetedStatus的属性
	NSString *text2 = status.retweetedStatus.text;
	NSString *name2 = status.retweetedStatus.user.name;
	NSString *icon2 = status.retweetedStatus.user.icon;
	MJExtensionLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
}

/**
 *  复杂的字典 -> 模型 (模型的数组属性里面又装着模型)
 */
void keyValues2object3()
{
	// 1.定义一个字典
	NSDictionary *dict = @{
						   @"statuses" : @[
								   @{
									   @"text" : @"今天天气真不错！",
									   
									   @"user" : @{
											   @"name" : @"Rose",
											   @"icon" : @"nami.png"
											   }
									   },
								   
								   @{
									   @"text" : @"明天去旅游了",
									   
									   @"user" : @{
											   @"name" : @"Jack",
											   @"icon" : @"lufy.png"
											   }
									   }
								   
								   ],
						   
						   @"ads" : @[
								   @{
									   @"image" : @"ad01.png",
									   @"url" : @"http://www.小码哥ad01.com"
									   },
								   @{
									   @"image" : @"ad02.png",
									   @"url" : @"http://www.小码哥ad02.com"
									   }
								   ],
						   
						   @"totalNumber" : @"2014",
						   @"previousCursor" : @"13476589",
						   @"nextCursor" : @"13476599"
						   };
	
	// 2.将字典转为MJStatusResult模型
	MJStatusResult *result = [MJStatusResult mj_objectWithKeyValues:dict];
	
	// 3.打印MJStatusResult模型的简单属性
	MJExtensionLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
	
	// 4.打印statuses数组中的模型属性
	for (MJStatus *status in result.statuses) {
		NSString *text = status.text;
		NSString *name = status.user.name;
		NSString *icon = status.user.icon;
		MJExtensionLog(@"text=%@, name=%@, icon=%@", text, name, icon);
	}
	
	// 5.打印ads数组中的模型属性
	for (MJAd *ad in result.ads) {
		MJExtensionLog(@"image=%@, url=%@", ad.image, ad.url);
	}
}

/**
 * 简单的字典 -> 模型（key替换，比如ID和id。多级映射，比如 oldName 和 name.oldName）
 */
void keyValues2object4()
{
	// 1.定义一个字典
	NSDictionary *dict = @{
						   @"id" : @"20",
						   @"desciption" : @"好孩子",
						   @"name" : @{
								   @"newName" : @"lufy",
								   @"oldName" : @"kitty",
								   @"info" : @[
										   @"test-data",
										   @{@"nameChangedTime" : @"2013-08-07"}
										   ]
								   },
						   @"other" : @{
								   @"bag" : @{
										   @"name" : @"小书包",
										   @"price" : @100.7
										   }
								   }
						   };
	
	// 2.将字典转为MJStudent模型
	MJStudent *stu = [MJStudent mj_objectWithKeyValues:dict];
	
	// 3.打印MJStudent模型的属性
	MJExtensionLog(@"ID=%@, desc=%@, otherName=%@, oldName=%@, nowName=%@, nameChangedTime=%@", stu.ID, stu.desc, stu.otherName, stu.oldName, stu.nowName, stu.nameChangedTime);
	MJExtensionLog(@"bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
	
	//    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
	//    for (int i = 0; i< 10000; i++) {
	//        [MJStudent mj_objectWithKeyValues:dict];
	//    }
	//    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
	//    MJExtensionLog(@"%f", end - begin);
}

/**
 *  字典数组 -> 模型数组
 */
void keyValuesArray2objectArray()
{
	// 1.定义一个字典数组
	NSArray *dictArray = @[
						   @{
							   @"name" : @"Jack",
							   @"icon" : @"lufy.png",
							   },
						   
						   @{
							   @"name" : @"Rose",
							   @"icon" : @"nami.png",
							   }
						   ];
	
	// 2.将字典数组转为MJUser模型数组
	NSArray *userArray = [MJUser mj_objectArrayWithKeyValuesArray:dictArray];
	
	// 3.打印userArray数组中的MJUser模型属性
	for (MJUser *user in userArray) {
		MJExtensionLog(@"name=%@, icon=%@", user.name, user.icon);
		NSLog(@"name:=%@, icon:=%@", user.name, user.icon);
	}
}

/**
 *  模型 -> 字典
 */
void object2keyValues()
{
	// 1.新建模型
	MJUser *user = [[MJUser alloc] init];
	user.name = @"Jack";
	user.icon = @"lufy.png";
	
	MJStatus *status = [[MJStatus alloc] init];
	status.user = user;
	status.text = @"今天的心情不错！";
	
	// 2.将模型转为字典
	NSDictionary *statusDict = status.mj_keyValues;
	MJExtensionLog(@"%@", statusDict);
	
	MJExtensionLog(@"%@", [status mj_keyValuesWithKeys:@[@"text"]]);
	
	// 3.新建多级映射的模型
	MJStudent *stu = [[MJStudent alloc] init];
	stu.ID = @"123";
	stu.oldName = @"rose";
	stu.nowName = @"jack";
	stu.desc = @"handsome";
	stu.nameChangedTime = @"2018-09-08";
	stu.books = @[@"Good book", @"Red book"];
	
	MJBag *bag = [[MJBag alloc] init];
	bag.name = @"小书包";
	bag.price = 205;
	stu.bag = bag;
	
	NSDictionary *stuDict = stu.mj_keyValues;
	MJExtensionLog(@"%@", stuDict);
	MJExtensionLog(@"%@", [stu mj_keyValuesWithIgnoredKeys:@[@"bag", @"oldName", @"nowName"]]);
	MJExtensionLog(@"%@", stu.mj_JSONString);
	
	[MJStudent mj_referenceReplacedKeyWhenCreatingKeyValues:NO];
	MJExtensionLog(@"\n模型转字典时，字典的key参考replacedKeyFromPropertyName等方法:\n%@", stu.mj_keyValues);
}

/**
 *  模型数组 -> 字典数组
 */
void objectArray2keyValuesArray()
{
	// 1.新建模型数组
	MJUser *user1 = [[MJUser alloc] init];
	user1.name = @"Jack";
	user1.icon = @"lufy.png";
	
	MJUser *user2 = [[MJUser alloc] init];
	user2.name = @"Rose";
	user2.icon = @"nami.png";
	
	NSArray *userArray = @[user1, user2];
	
	// 2.将模型数组转为字典数组
	NSArray *dictArray = [MJUser mj_keyValuesArrayWithObjectArray:userArray];
	MJExtensionLog(@"%@", dictArray);
}



@end
