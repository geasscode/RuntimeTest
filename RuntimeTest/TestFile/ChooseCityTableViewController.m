//
//  ChooseCityTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ChooseCityTableViewController.h"
#import "ChooseCityModel.h"
#import "UIBarButtonItem+Extension.h"

@interface ChooseCityTableViewController()
	

/**
 *  从plist文件中读取的原数据
 */
@property(nonatomic,strong)NSMutableArray *cityArray;

/**
 *  存放首字母的数据
 */
@property(nonatomic,strong)NSMutableArray *groupsArray;

/**
 *  分组好的数据
 */
@property(nonatomic,strong)NSMutableArray *resultArray;

@end

@implementation ChooseCityTableViewController


#pragma mark 懒加载


-(NSMutableArray *)cityArray{
	
	if (!_cityArray) {
		
		_cityArray = [ChooseCityModel chooseCityDatas];
	}
	
	return _cityArray;
}

-(NSMutableArray *)groupsArray{
	
	if (!_groupsArray) {
		
		_groupsArray = [NSMutableArray array];
	}
	
	return _groupsArray;
}

-(NSMutableArray *)resultArray{
	
	if (!_resultArray) {
		
		_resultArray = [NSMutableArray array];
		
		//根据拼音对数组排序
		NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
		//对城市数据中的数据进行生序排序
		[self.cityArray sortUsingDescriptors:sortDescriptors];
		
		//中间数组，也就是每一个字母所代表的数组
		NSMutableArray *tempArray = nil;
		
		//定义标识
		BOOL flag = NO;
		
		for (int i=0; i<self.cityArray.count; i++) {
			
			ChooseCityModel *model = self.cityArray[i];
			
			NSString *pinyin = model.pinyin;
			
			//获取拼音的首字母，并且将获取的小写字母转换成大些子母
			NSString *firtChar = [[pinyin substringToIndex:1] uppercaseString];
			
			//如果存放字母的数组中不包含当前数据的首字母
			if (![self.groupsArray containsObject:firtChar]) {
				
				//将当前字母加入数组中
				[self.groupsArray addObject:firtChar];
				
				tempArray = [NSMutableArray array];
				
				flag = NO;
			}
			
			if ([self.groupsArray containsObject:firtChar]) {
				
				[tempArray addObject:self.cityArray[i]];
				
				if (flag == NO) {
					
					[_resultArray addObject:tempArray];
					
					flag = YES;
				}
			}
		}
		
	}
	
	return _resultArray;
}

-(void)loadView{
	
	[super loadView];
	
	_resultArray = self.resultArray;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"选择城市";
	
	[self setNav];
	
	//设置索引的颜色
	self.tableView.sectionIndexColor = globalColor;
	
}


-(void)setNav{
	
	self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_nav_quxiao_normal" target:self action:@selector(leftClick)];
}

-(void)leftClick{
	
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark tableView datasource delegete

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	
	return self.groupsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	NSMutableArray *tempArray = self.resultArray[section];
	
	return tempArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *ID = @"cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	
	if (!cell) {
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
	}
	
	NSMutableArray *tempArray = self.resultArray[indexPath.section];
	
	ChooseCityModel *model = tempArray[indexPath.row];
	cell.textLabel.text = model.name;
	
	return cell;
	
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	return self.groupsArray[section];
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	
	return self.groupsArray;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	
	[self leftClick];
	
	//发送通知
	NSMutableArray *tempArray = self.resultArray[indexPath.section];
	
	ChooseCityModel *model = tempArray[indexPath.row];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"chooseCityNotification" object:nil userInfo:@{@"cityName":model.name}];
	
	
}
@end
