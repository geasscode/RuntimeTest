//
//  ReadFeedbackTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/7/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ReadFeedbackTableViewController.h"

@interface ReadFeedbackTableViewController ()

@property(strong,nonatomic) NSMutableArray *feedbacksArray;

@end

@implementation ReadFeedbackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];

//	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"feedBackCell"];
	_feedbacksArray = [[NSMutableArray alloc] init];
	self.tableView.tableFooterView  = [UITableView new];

	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		//		[self readDataByDB];
		[self.tableView.mj_header endRefreshing];
		
	}];
	self.dk_manager.themeVersion = DKThemeVersionNight;
	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	self.tableView.separatorColor = [UIColor darkGrayColor];

	
	[self performSelector:@selector(searchFeedback) withObject:nil afterDelay:0.7f];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)searchFeedback{
	BmobQuery *query = [BmobQuery queryWithClassName:@"Feedback"];
	[query orderByDescending:@"updatedAt"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
		for (BmobObject *obj in array) {
			NSMutableDictionary *dic = [NSMutableDictionary dictionary];
			[dic setObject:[obj objectForKey:@"content"] forKey:@"content"];
			[dic setObject:[obj objectForKey:@"contact"] forKey:@"contact"];
			[dic setObject:obj.createdAt forKey:@"time"];
			[_feedbacksArray addObject:dic];
			[self.tableView reloadData];
		}
	}];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//	
//	return 1;
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
	return [_feedbacksArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedBackCell"];
	
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedBackCell" forIndexPath:indexPath];
	
	if(cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"feedBackCell"];
		cell.textLabel.font = [UIFont systemFontOfSize:14];
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"反馈内容:%@", [[[_feedbacksArray objectAtIndex:indexPath.row] objectForKey:@"content"] description]];
	
	cell.textLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"反馈时间:%@", [[[_feedbacksArray objectAtIndex:indexPath.row] objectForKey:@"time"] description]];
	
	cell.detailTextLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	return cell;

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

@end
