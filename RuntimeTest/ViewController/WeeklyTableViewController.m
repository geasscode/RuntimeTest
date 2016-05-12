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
#import "WeeklyItemStageModel.h"
#import "WeeklyItemStageDetatilController.h"
#import "FocusImageScrollView.h"
#import "masonry.h"
#import "HomeViewModel.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "FeThreeDotGlow.h"

@interface WeeklyTableViewController ()<HeaderViewDelegate,iCarouselDataSource,iCarouselDelegate>
@property(nonatomic,strong) NSArray * weeklyItemArray;
@property (nonatomic,strong) HomeViewModel *homeVM;
@property (strong, nonatomic) FeThreeDotGlow *threeDot;


@end

@implementation WeeklyTableViewController


UIPageControl *_pageControl;

-(NSArray*)weeklyItemArray{
	
	if(!_weeklyItemArray){
		_weeklyItemArray = [NSMutableArray array];
	}
	return _weeklyItemArray;
}

- (HomeViewModel *)homeVM {
	if (!_homeVM) {
		_homeVM = [HomeViewModel new];
	}
	return _homeVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeBottom;

	[self setupNav];
	[self getData];
	[self setupUI];

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
		
		[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];

		
	}];
}

-(void)setupUI{
	//初始化多少张图片。
	FocusImageScrollView *scrollView = [[FocusImageScrollView alloc] initWithFocusImgNumber:self.homeVM.imageList.count];
	scrollView.ic.delegate = self;
	scrollView.ic.dataSource = self;
	_pageControl = scrollView.pageControl;
	self.tableView.tableHeaderView = scrollView;
	
//	_threeDot = [[FeThreeDotGlow alloc] initWithView:self.view blur:NO];
//	[self.view addSubview:_threeDot];
	
	// Start
//	[_threeDot showWhileExecutingBlock:^{
//		[self myTask];
//	} completion:^{
//		[self.navigationController popToRootViewControllerAnimated:YES];
//	}];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	hud.labelText = NSLocalizedString(@"正在帮你找数据...", @"HUD loading title");
}

- (void)myTask
{
	// Do something usefull in here instead of sleeping ...
	sleep(3);
}

-(void)settingBtn {
	
}


#pragma mark - iCarousel代理方法
// @require
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
	return self.homeVM.imageList.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
	UIImageView *imgView = nil;
	if (!view) {
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/660*310)];
		imgView = [UIImageView new];
		[view addSubview:imgView];
		imgView.tag = 100;
		imgView.contentMode = UIViewContentModeScaleAspectFit;
		view.clipsToBounds = YES;
		[imgView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(0);
		}];
	}
	
	imgView = (UIImageView *)[view viewWithTag:100];
	[imgView setImageWithURL:[self.homeVM focusImgURLForIndex:index] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_2"]];
	return view;
}

// @option
/** 允许循环滚动 */
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
	if (option == iCarouselOptionWrap) {
		return YES;
	}
	return value;
}

/**  监控滚到第几个 */
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
	_pageControl.currentPage = carousel.currentItemIndex;
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
	
	WeeklyItemHeaderView * headerView =  [WeeklyItemHeaderView headerViewWithTableView:tableView];
	headerView.delegate  = self;
	headerView.itemModel = _weeklyItemArray[section];
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
	
	WeeklyItemStageDetatilController *detail = [[WeeklyItemStageDetatilController alloc] init];
	
	WeeklyItemModel *itemModel = self.weeklyItemArray[indexPath.section];
	
	WeeklyItemStageModel *stageModel = itemModel.weeklyItemStage[indexPath.row];
	
	detail.type = itemModel.type;
	
	detail.text = [NSString stringWithFormat:@"%@-%@",itemModel.name,stageModel.title];
	
	detail.stageId = stageModel.stageId;
	
	[self.navigationController pushViewController:detail animated:YES];
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
