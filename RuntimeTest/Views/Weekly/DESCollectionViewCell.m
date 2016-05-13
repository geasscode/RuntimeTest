//
//  DESCollectionViewCell.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESCollectionViewCell.h"
#import "ContentTableViewController.h"

@interface DESCollectionViewCell()

@property (nonatomic,strong) ContentTableViewController *ContentTableViewController;

@end
@implementation DESCollectionViewCell

-(ContentTableViewController *)ContentTableViewController{
	
	if (_ContentTableViewController == nil) {
		_ContentTableViewController = [[ContentTableViewController alloc]init];
	}
	return _ContentTableViewController;
}

-(void)setUrlstring:(NSString *)urlstring{
	
	_urlstring = urlstring;
	
}

-(void)setTitle:(NSString *)title{
	
	_title = title;
	
	self.ContentTableViewController.titlename = title;
	self.ContentTableViewController.urlstring = _urlstring;
	
	self.ContentTableViewController.tableView.frame = self.bounds;
	[self.contentView addSubview:self.ContentTableViewController.tableView];
}

@end

