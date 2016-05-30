//
//  ContactInfoTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/21.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ContactInfoTableViewController.h"
#import "ContactTableViewCell.h"
#import "ContactModel.h"
#import "ContactDataHelper.h"
#import "UIBarButtonItem+Extension.h"
#import "ChooseCityTableViewController.h"
#define DawnCellBGColor [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1] // #F9F9F9

@interface ContactInfoTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
{
	NSArray * _rowArr;
	NSArray * _sectionArr;
}

//@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UILabel *cityLabel;

//@property (nonatomic,strong) UISearchController *searchDisplayController;//搜索VC
//下面的类已经过期。
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;//搜索VC
@end

@implementation ContactInfoTableViewController
{
	NSMutableArray *_searchResultArr;//搜索结果Arr

}


#pragma mark - dataArr(模拟从服务器获取到的数据)
- (NSArray *)serverDataArr{
	if (!_serverDataArr) {
		_serverDataArr=@[@{@"portrait":@"1",@"name":@"1"},@{@"portrait":@"2",@"name":@"花无缺"},@{@"portrait":@"3",@"name":@"东方不败"},@{@"portrait":@"4",@"name":@"任我行"},@{@"portrait":@"5",@"name":@"逍遥王"},@{@"portrait":@"6",@"name":@"阿离"},@{@"portrait":@"13",@"name":@"百草堂"},@{@"portrait":@"8",@"name":@"三味书屋"},@{@"portrait":@"9",@"name":@"彩彩"},@{@"portrait":@"10",@"name":@"陈晨"},@{@"portrait":@"11",@"name":@"多多"},@{@"portrait":@"12",@"name":@"峨嵋山"},@{@"portrait":@"7",@"name":@"哥哥"},@{@"portrait":@"14",@"name":@"林俊杰"},@{@"portrait":@"15",@"name":@"足球"},@{@"portrait":@"16",@"name":@"58赶集"},@{@"portrait":@"17",@"name":@"搜房网"},@{@"portrait":@"18",@"name":@"欧弟"}];
	}
	return _serverDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	

	
	[self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
	[self.tableView setSectionIndexColor:[UIColor darkGrayColor]];
	[self.tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
	self.tableView.tableHeaderView=self.searchBar;
//	
//	UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, WNXAppHeight-49.0, WNXAppWidth, 49.0)];
//	[imageView setImage:[UIImage imageNamed:@"footerImage"]];
//	[imageView setContentMode:UIViewContentModeScaleToFill];


	//cell无数据时，不显示间隔线
	//		_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	[self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

	
	self.dataArr=[NSMutableArray array];
	for (NSDictionary *subDic in self.serverDataArr) {
		ContactModel *model=[[ContactModel alloc]initWithDic:subDic];
		[self.dataArr addObject:model];
	}
	
	_rowArr=[ContactDataHelper getFriendListDataBy:self.dataArr];
	_sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
	
	//configNav
	[self configNav];
	
	[self getChooseCityNotification];

	
	_searchDisplayController=[[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
	[_searchDisplayController setDelegate:self];
	[_searchDisplayController setSearchResultsDataSource:self];
	[_searchDisplayController setSearchResultsDelegate:self];
	
	_searchResultArr=[NSMutableArray array];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
}


- (void)normal {
	self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)night {
	self.dk_manager.themeVersion = DKThemeVersionNight;
}

- (void)configNav{
	
	
	UIBarButtonItem *nightItem = [[UIBarButtonItem alloc] initWithTitle:@"晚上" style:UIBarButtonItemStylePlain target:self action:@selector(night)];
	
	
	UIBarButtonItem *normalItem = [[UIBarButtonItem alloc] initWithTitle:@"白天" style:UIBarButtonItemStylePlain target:self action:@selector(normal)];
	
	nightItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	
	
	
	UILabel *city = [UILabel new];
	city.text = @"北京";
	city.textColor = globalColor;
	
	_cityLabel = city;
	city.font = [UIFont systemFontOfSize:15];
	city.size = CGSizeMake(40, 50);
	city.textAlignment = NSTextAlignmentLeft;
	
	UIBarButtonItem *cityNameItem = [[UIBarButtonItem alloc] initWithCustomView:city];
	
	UIBarButtonItem *chooseCityItem = [UIBarButtonItem itemWithImageName:@"home_arrow_down_red.png" target:self action:@selector(chooseCityClick)];
	
	
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
	[btn setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
	[btn setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
	
	
	
	UISearchBar *searchView = [[UISearchBar alloc] init];
	
	searchView.placeholder = @"搜索";
	
	self.navigationItem.titleView = searchView;
	
	
	//自定义 navigation button 使用方式。
	UIBarButtonItem *contactInfo = [[UIBarButtonItem alloc]initWithCustomView:btn];
//	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:btn],nightItem];
	
	
	
	    self.navigationItem.leftBarButtonItems = @[cityNameItem,chooseCityItem];
		self.navigationItem.rightBarButtonItems = @[contactInfo,normalItem,nightItem];

	
	
	
	//	redItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	
	
	//	    self.tableView.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
	self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
}

#pragma mark - setUpView
- (void)setUpView{
	UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, WNXAppHeight-49.0, WNXAppWidth, 49.0)];
	[imageView setImage:[UIImage imageNamed:@"footerImage"]];
	[imageView setContentMode:UIViewContentModeScaleToFill];
//	[self.tableView addSubview:imageView];
//	[self.tableView setTableFooterView:imageView];
//	[self.view addSubview:imageView];
//	[self.view insertSubview:self.tableView belowSubview:imageView];
}


-(void)getChooseCityNotification{
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseCityNotification:) name:@"chooseCityNotification" object:nil];
	
}

-(void)chooseCityNotification:(NSNotification *)notification{
	
	NSString *cityName = notification.userInfo[@"cityName"];
	
	_cityLabel.text = cityName;
}

-(void)chooseCityClick{
	
 NSLog(@"chooseCityClick");
	
	ChooseCityTableViewController *chooseCityVC = [ChooseCityTableViewController new];
	
	//加上这句就有导航标题。
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chooseCityVC];
	
	[self presentViewController:nav animated:YES completion:nil];
	
}

- (UISearchBar *)searchBar{
	if (!_searchBar) {
		_searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WNXAppWidth, 44)];
		[_searchBar setBackgroundImage:[UIImage imageNamed:@"ic_searchBar_bgImage"]];
		[_searchBar sizeToFit];
		[_searchBar setPlaceholder:@"搜索"];
		[_searchBar.layer setBorderWidth:0.5];
		[_searchBar.layer setBorderColor:[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1].CGColor];
		[_searchBar setDelegate:self];
		[_searchBar setKeyboardType:UIKeyboardTypeDefault];
	}
	return _searchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
	//section
	if (tableView == _searchDisplayController.searchResultsTableView) {
		return 1;
	}else{
		return _rowArr.count;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
	//row
	if (tableView==_searchDisplayController.searchResultsTableView) {
		return _searchResultArr.count;
	}else{
		return [_rowArr[section] count];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
	headerView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(headerView.frame) - 40, CGRectGetHeight(headerView.frame))];
	headerLabel.text = _sectionArr[section+1];
	headerLabel.textColor = [UIColor colorWithRed:85 / 255.0 green:85 / 255.0 blue:85 / 255.0 alpha:1];
	headerLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);

//	headerLabel.nightTextColor = NightCellHeaderTextColor;TINT
	headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
	[headerView addSubview:headerLabel];
    headerView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);


//   headerView.nightBackgroundColor = NightBGViewColor;
	return headerView;
	//viewforHeader
//	id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
//	if (!label) {
//		label = [[UILabel alloc] init];
//		[label setFont:[UIFont systemFontOfSize:14.5f]];
//		[label setTextColor:[UIColor grayColor]];
//		[label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
//	}
//	[label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section+1]]];
//	return label;
}
//A-Z index
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	if (tableView!=_searchDisplayController.searchResultsTableView) {
		return _sectionArr;
	}else{
		return nil;
	}
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
	return index-1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if (tableView==_searchDisplayController.searchResultsTableView) {
		return 0;
	}else{
		return 22.0;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIde=@"cellIde";
	ContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
	if (cell==nil) {
		cell=[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
	}
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	if (tableView==_searchDisplayController.searchResultsTableView){
		[cell.headImageView setImage:[UIImage imageNamed:[_searchResultArr[indexPath.row] valueForKey:@"portrait"]]];
		[cell.nameLabel setText:[_searchResultArr[indexPath.row] valueForKey:@"name"]];
	}else{
		ContactModel *model=_rowArr[indexPath.section][indexPath.row];
		
		[cell.headImageView setImage:[UIImage imageNamed:model.portrait]];
		[cell.nameLabel setText:model.name];
	}
	
	cell.nameLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];

	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	
	return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
	//	view.tintColor = [UIColor clearColor];
	
	view.tintColor = [UIColor redColor];
	
	
	//	改变文字的颜色：
	UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
	[footer.textLabel setTextColor:[UIColor redColor]];
}


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
#pragma mark searchBar delegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
	NSArray *subViews;
	subViews = [(searchBar.subviews[0]) subviews];
	for (id view in subViews) {
		if ([view isKindOfClass:[UIButton class]]) {
			UIButton* cancelbutton = (UIButton* )view;
			[cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
			break;
		}
	}
	searchBar.showsCancelButton = YES;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
	return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	//取消
	[searchBar resignFirstResponder];
	searchBar.showsCancelButton = NO;
}

#pragma mark searchDisplayController delegate
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView{
	//cell无数据时，不显示间隔线
	
	UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
	[tableView setTableFooterView:v];
	
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
	[self filterContentForSearchText:searchString
							   scope:[self.searchBar scopeButtonTitles][self.searchBar.selectedScopeButtonIndex]];
	return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
	[self filterContentForSearchText:self.searchBar.text
							   scope:self.searchBar.scopeButtonTitles[searchOption]];
	return YES;
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
	NSMutableArray *tempResults = [NSMutableArray array];
	NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
	
	for (int i = 0; i < self.dataArr.count; i++) {
		NSString *storeString = [(ContactModel *)self.dataArr[i] name];
		NSString *storeImageString=[(ContactModel *)self.dataArr[i] portrait]?[(ContactModel *)self.dataArr[i] portrait]:@"";
		
		NSRange storeRange = NSMakeRange(0, storeString.length);
		
		NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
		if (foundRange.length) {
			NSDictionary *dic=@{@"name":storeString,@"portrait":storeImageString};
			
			[tempResults addObject:dic];
		}
		
	}
	[_searchResultArr removeAllObjects];
	[_searchResultArr addObjectsFromArray:tempResults];
}

@end
