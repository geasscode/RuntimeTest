//
//  HomeViewModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "HomeViewModel.h"
#import "APIClient.h"
#import "HomeModel.h"

@implementation HomeViewModel

//为了ViewModel最终不变得臃肿，同时利于代码扩展及重复利用，我想到将ViewModel的职责更进一步细化，2016-05-04
//ViewModel负责网络请求及界面展示逻辑，而将业务交互部分单独再抽出来，将其封装在独立的业务交互处理类Manager（或许这里取名Manager不恰当，暂且先这样）当中。


//不同展现逻辑但具有相同业务交互逻辑的界面即可使用不同的ViewModel而  共用同一个Manager   了，满足了一份业务交互逻辑代码可以多处使用、多处组装，在一定程度上不仅降低了开发工作量，同时增强了代码的可维护性。 2016-05-04  http://mp.weixin.qq.com/s?__biz=MzAwNjgwMTkyNA==&mid=2650826418&idx=1&sn=39fa94559d20765e7b43a9ae118e7658&scene=4#wechat_redirect

//任何展示业务逻辑复杂的View，均可以建立其对应的ViewModel（建议在该View需要响应用户事件来改变model时使用），
//处理网络获取的数据

//任何对Model的操作都可以移至ViewModel，比如说：获取（网络请求/读数据库/读文件）、存储（远端存储/本地存储）等；
//ViewModel是UI数据的来源，数据应该保存在ViewModel中，然后和UI绑定。

//目前的绑定关系没有问题，但是需要一个建议规范，View不再直接持有任何Model，而是通过监听ViewModel的result，在任何时候result发生变化，只需要取出ViewModel中的Model，更新UI；



- (void)handleDataWithSuccess:(void (^)(NSArray *arr))success failure:(void(^)(NSError *error))failure{
	
	[[APIClient sharedManager] netWorkGetHomePageListWithPageSize:20 pageNum:0 success:^(Response *respone) {
		
		NSLog(@".......respone.description : %@",respone.description);
		if (respone.status==kEnumServerStateSuccess) {
			NSLog(@"请求成功!");
			
			NSMutableArray *tmpArr=[NSMutableArray array];
			for (NSDictionary *subDic in (NSArray *)[respone.data valueForKey:@"results"]) {
				HomeModel *model=[[HomeModel alloc]initWithDic:subDic];
				[tmpArr addObject:model];
			}
			success(tmpArr);
		}
	} failure:^(NSError *error) {
		failure(error);
	}];
}


#pragma mark - 头部滚动视图
/**  是否有滚动视图 */

-(NSArray *)imageList{
	
	NSArray *imageList = @[@"http://fdfs.xmcdn.com/group10/M00/5B/08/wKgDaVcpcJyB77FAAAGcSOQaNK0036_android_large.jpg",
						   
						   @"http://fdfs.xmcdn.com/group16/M06/5C/14/wKgDalcoaZ2gtg9CAAJb4uPAC18747_android_large.jpg",
						   
						   @"http://fdfs.xmcdn.com/group7/M03/5C/A5/wKgDWlcoXcuBjgbMAAFc4n4nrk4804_android_large.jpg",
						   
						   @"http://fdfs.xmcdn.com/group15/M09/5A/83/wKgDaFcoXfaQo2CbAAFyTmOcnRo010_android_large.jpg",
						   
						   @"http://fdfs.xmcdn.com/group12/M09/5B/8A/wKgDW1cogHCTX0azAAK4qPl_pNY250_android_large.jpg"];
	return imageList;
}
- (BOOL)isExitsScrollView {   // 判断一个数组不空办法, 还要加上NSNull类, 因为服务器人员可能出错
	return YES;
//	return self.model.focusImages.list != nil && self.model.focusImages.list.count != 0 && ![self.model.focusImages.list isKindOfClass:[NSNull class]] ;
}
/** 滚动展示栏的图片数量 */
//- (NSInteger)focusImgNumber {
//	
//	return _imageList.count;
////	return self.model.focusImages.list.count;
//}
/** 滚动展示栏的图片地址 */
- (NSURL *)focusImgURLForIndex:(NSInteger)index {

	NSString *path = self.imageList[index];
	return [NSURL URLWithString:path];
}



@end
