//
//  SigmaTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "SigmaTableViewController.h"
#import "YZSTableViewModel.h"
#import "BaseTableViewController.h"

@interface SigmaTableViewController ()
@property (nonatomic, strong) YZSTableViewModel *viewModel;

@end

@implementation SigmaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.viewModel = [[YZSTableViewModel alloc] init];
	self.tableView.delegate = self.viewModel;
	self.tableView.dataSource = self.viewModel;
	[self initDataSource];
	[self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)initDataSource {
	static NSString *Identify_Cell = @"Cell";
	
	YZWeak(self);
	[self.viewModel.sectionModelArray removeAllObjects];
	YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
	[self.viewModel.sectionModelArray addObject:sectionModel];
	sectionModel.headerTitle = @"Traditional Implementation";
	sectionModel.headerHeight = 40;
	sectionModel.footerHeight = 0.1;
	YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
	[sectionModel.cellModelArray addObject:cellModel];
	
	cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										  reuseIdentifier:Identify_Cell];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		cell.textLabel.text = @"Employee";
		return cell;
	};
	
	cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		YZStrong(self);
		[self manageStoreByMember:MemberTypeEmployee withTraditionalWay:YES];
	};
	
	cellModel = [[YZSTableViewCellModel alloc] init];
	[sectionModel.cellModelArray addObject:cellModel];
	cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										  reuseIdentifier:Identify_Cell];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		cell.textLabel.text = @"Manager";
		return cell;
	};
	cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		YZStrong(self);
		[self manageStoreByMember:MemberTypeManager withTraditionalWay:YES];
	};
	
	sectionModel = [[YZSTableViewSectionModel alloc] init];
	[self.viewModel.sectionModelArray addObject:sectionModel];
	sectionModel.headerTitle = @"Better Implementation";
	sectionModel.headerHeight = 40;
	cellModel = [[YZSTableViewCellModel alloc] init];
	[sectionModel.cellModelArray addObject:cellModel];
	cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										  reuseIdentifier:Identify_Cell];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		cell.textLabel.text = @"Employee";
		return cell;
	};
	cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		YZStrong(self);
		[self manageStoreByMember:MemberTypeEmployee withTraditionalWay:NO];
	};
	cellModel = [[YZSTableViewCellModel alloc] init];
	[sectionModel.cellModelArray addObject:cellModel];
	cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										  reuseIdentifier:Identify_Cell];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		cell.textLabel.text = @"Manager";
		return cell;
	};
	cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		YZStrong(self);
		[self manageStoreByMember:MemberTypeManager withTraditionalWay:NO];
	};
}


- (void)manageStoreByMember:(MemberType)type withTraditionalWay:(BOOL)tradition {
//	BaseTableViewController *storeVC = nil;
//	if (tradition) {
//		storeVC = [[BadTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//	} else {  // better way
//		storeVC = [[GoodTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//	}
//	storeVC.type = type;
//	[self.navigationController pushViewController:storeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
