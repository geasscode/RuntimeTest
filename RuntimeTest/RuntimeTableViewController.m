//
//  RuntimeTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/20.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "RuntimeTableViewController.h"
#import "IvarListViewController.h"
#import "DynamicAddMethodViewController.h"
#import "DynamicExchangeMethodViewController.h"
#import "ReplaceMethodViewController.h"
#import "OtherFunctionViewController.h"
#import "HWPopTool.h"

@interface RuntimeTableViewController ()

@property(nonatomic,strong) NSArray *runtimeData;

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIButton *popBtn;

@end

@implementation RuntimeTableViewController

static NSString *cellIdentifier = @"runtimeID";




- (void)viewDidLoad {
	[super viewDidLoad];
	_contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
	_contentView.backgroundColor = [UIColor clearColor];
	_popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_popBtn.frame = CGRectMake(0, 250, 200, 50);
	_popBtn.backgroundColor = [UIColor greenColor];
	[_popBtn addTarget:self action:@selector(closeAndBack) forControlEvents:UIControlEventTouchUpInside];
	
	self.title = @"rumtime";
	_runtimeData = @[@"动态变量控制",
					 @"动态添加方法",
					 @"动态交换两个方法的实现",
					 @"拦截并替换方法",
					 @"在方法上增加额外功能(自定义popView)",
					 @"实现NSCoding的自动归档和解档",
					 @"实现字典转模型的自动转换"
					 ];
	
	self.tableView.tableFooterView = [UIView new];
	
	//ios6 之后注册tableView 必用。
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
	
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (void)closeAndBack {
	[[HWPopTool sharedInstance] closeWithBlcok:^{
		[self.navigationController popViewControllerAnimated:YES];
		
	}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
	return _runtimeData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	//使用ios6以后的方法必须注册一个nib或者class否则会提示'unable to dequeue a cell with identifier runtimeID - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	
//	下面 ios 6 以前的方法：

//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//	
//	if (cell == nil) {
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//	}
	
	
	cell.textLabel.text = _runtimeData[indexPath.row];
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSInteger index = indexPath.row;
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
	
	switch (index) {
			
		case 0:{
		
			//Storyboard (<UIStoryboard: 0x10e40bae0>) doesn't contain a view controller with identifier 'ivarList''
			IvarListViewController * ivarList = (IvarListViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"ivarlist"];
			[self.navigationController pushViewController:ivarList animated:YES];
				break;
		}
		case 1:{
			DynamicAddMethodViewController * addMethod = (DynamicAddMethodViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"addMethod"];
			[self.navigationController pushViewController:addMethod animated:YES];
			break;
		}
			
		case 2:{
			DynamicExchangeMethodViewController * exchangeMethod = (DynamicExchangeMethodViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"exchangeMethod"];
			[self.navigationController pushViewController:exchangeMethod animated:YES];
			break;
		}
			
		case 3:{
			ReplaceMethodViewController * replaceMethod = (ReplaceMethodViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"replaceMethod"];
			[self.navigationController pushViewController:replaceMethod animated:YES];
		}
			
		case 4:{
			
			UIImageView *imageV = [[UIImageView alloc]initWithFrame:_contentView.bounds];
			imageV.image = [UIImage imageNamed:@"girl"];
			[_contentView addSubview:imageV];
			
			[HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
			[HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
			[[HWPopTool sharedInstance] showWithPresentView:_contentView animated:YES];
			
		

		}
			
		default:
				break;
	}
	
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


 #pragma mark - Navigation
//利用performSegueWithIdentifier:sender:来进行任何形式的转场。Segue为我们的转场提供了不同的Action，囊括了常见的UINavigationViewController的push，或者所有ViewController都可以执行的Modelly Presentation。
//self performSegueWithIdentifier:[PSViewControllerB description] sender:parameter]
//采用Storyboard进行Scene转场的好处在于，一个ViewController的所有转场代码，都集中到了prepareForSegue:sender: 方法中，debug或者添加新功能时，可以很容易顺藤摸瓜。但缺点同样明显。每次转场的修改/删除需要同时修改Storyboard和代码文件。同时，随着项目的进行，越来越多的Scene和业务逻辑，导致Storyboard中Segue的数量剧增，难以维护。

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	 
//	 UIViewController *destination = segue.destinationViewController;
//	 if ([destination respondsToSelector:@selector(setDelegate:)]) {
//		 [destination setValue:self forKey:@"delegate"];
//	 }
//	 if ([destination respondsToSelector:@selector(setSelection:)]) {
//		 // prepare selection info
//		 NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//		 
//		 id object = _runtimeData[indexPath.row];
//		 NSDictionary *selection = @{@"indexPath" : indexPath,
//									 @"object" : object};
//		 [destination setValue:selection forKey:@"selection"];
//	 }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
