//
//  PhotosViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "PhotosViewController.h"
#import "ArrayDataSource.h"
#import "PhotoCell.h"
#import "AppDelegate.h"
#import "MyUser.h"
#import "Photo.h"
#import "PhotoCell.h"
#import "PhotoViewController.h"
#import "PhotoCell+ConfigureForPhoto.h"
#import "Store.h"



static NSString * const PhotoCellIdentifier = @"PhotoCell";

@interface PhotosViewController ()

@property (nonatomic, strong) ArrayDataSource *photosArrayDataSource;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Photos";
	[self setupTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView
{
	TableViewCellConfigureBlock configureCell = ^(PhotoCell *cell, Photo *photo) {
		[cell configureForPhoto:photo];
	};
	NSArray *photos = [AppDelegate sharedDelegate].store.sortedPhotos;
	self.photosArrayDataSource = [[ArrayDataSource alloc] initWithItems:photos
														 cellIdentifier:PhotoCellIdentifier
													 configureCellBlock:configureCell];
	self.tableView.dataSource = self.photosArrayDataSource;
	[self.tableView registerNib:[PhotoCell nib] forCellReuseIdentifier:PhotoCellIdentifier];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	PhotoViewController *photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController"
																					 bundle:nil];
	photoViewController.photo = [self.photosArrayDataSource itemAtIndexPath:indexPath];
	[self.navigationController pushViewController:photoViewController animated:YES];
}
@end
