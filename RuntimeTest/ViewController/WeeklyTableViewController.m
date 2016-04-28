//
//  WeeklyTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyTableViewController.h"
#import "WeeklyItemHeaderView.h"
#import "WeeklyItemCell.h"
#import "WeeklyItemModel.h"

@interface WeeklyTableViewController ()<HeaderViewDelegate>
@property(nonatomic,strong) NSArray * weeklyItemArray;

@end

@implementation WeeklyTableViewController



-(NSArray*)weeklyItemArray{
	
	if(!_weeklyItemArray){
		_weeklyItemArray = [NSMutableArray array];
	}
	return _weeklyItemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeBottom;

	[self setupNav];
	[self getData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupNav {
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtn)];
	
	self.navigationItem.leftBarButtonItem = nil;
	self.navigationItem.rightBarButtonItem = rightButton;
}


-(void)getData {
	typeof(self) weakSelf = self;
	[WeeklyItemModel weeklyItemRequestURL:kWeeklyItemUrl success:^(NSArray *itemArray) {
		
		weakSelf.weeklyItemArray = itemArray;
		
		[weakSelf.tableView reloadData];
		
	}];
}


-(void)settingBtn {
	
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.weeklyItemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
	return [self.weeklyItemArray[section] weeklyItemStage].count;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	NSLog(@"当前tableView为%@但xcode7调试时显示为nil，xcode傻了？",tableView);
	WeeklyItemHeaderView * headerView =  [WeeklyItemHeaderView headerViewWithTableView:tableView];
	headerView.delegate  = self;
	headerView.itemModel = _weeklyItemArray[section];
	NSLog(@"存在泄露值为%@",headerView);
	return headerView;
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    // Configure the cell...

	WeeklyItemCell *cell = [WeeklyItemCell cellWithTableView:tableView];
	
	WeeklyItemModel *itemModel = self.weeklyItemArray[indexPath.section];
	
	//传递模型数据
	cell.stageModel = itemModel.weeklyItemStage[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
//	WeeklyItemStageDetatilController *detail = [[WeeklyItemStageDetatilController alloc] init];
//	
//	WeeklyItemModel *itemModel = self.weeklyItemArray[indexPath.section];
//	
//	WeeklyItemStageModel *stageModel = itemModel.weeklyItemStage[indexPath.row];
//	
//	detail.type = itemModel.type;
//	
//	detail.text = [NSString stringWithFormat:@"%@-%@",itemModel.name,stageModel.title];
//	
//	detail.stageId = stageModel.stageId;
//	
//	[self.navigationController pushViewController:detail animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 40;
}


/**
 *  设置sectionView跟随tableView滚动
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat sectionHeaderHeight = 40;
	if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
		scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
	}
	else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
		scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
	}
}

#pragma mark -- HZYHeaderView 代理方法

//- (void)headerViewDidClickMoreLabel:(WeeklyItemHeaderView *)headerView viewForItemType:(NSInteger)type{
//	
//	
//	WeeklyItemMoreStageController *more = [[WeeklyItemMoreStageController alloc] init];
//	
//	more.type = type;
//	
//	more.text = headerView.weeklyItemLabel.text;
//	
//	[self.navigationController pushViewController:more animated:YES];
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
