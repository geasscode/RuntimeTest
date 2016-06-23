//
//  DESSearchResultsViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/22.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESSearchResultsViewController.h"
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
@end
