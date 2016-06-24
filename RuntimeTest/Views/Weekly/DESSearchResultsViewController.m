//
//  DESSearchResultsViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/22.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESSearchResultsViewController.h"
#import "DetailModel.h"
#import "DetailViewController.h"
NSString *const DESSearchResultsViewControllerStoryboardIdentifier = @"DESSearchResultsViewControllerStoryboardIdentifier";

@implementation DESSearchResultsViewController

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
	/*
	 -updateSearchResultsForSearchController: is called when the controller is
	 being dismissed to allow those who are using the controller they are search
	 as the results controller a chance to reset their state. No need to update
	 anything if we're being dismissed.
	 */
	if (!searchController.active) {
		return;
	}
	
	self.filterString = searchController.searchBar.text;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	DetailModel *model = self.visibleResults[indexPath.row];
	
	DetailViewController *detail = [[DetailViewController alloc] init];
	detail.detailTextId = model.detatilArticleId;
	[self.navigationController pushViewController:detail animated:YES];

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	NSLog(@"hello");
	//perform the same functionality of the create button
}
@end
