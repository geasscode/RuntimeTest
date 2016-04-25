//
//  PhotoViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "PhotoViewController.h"
#import "Photo.h"
#import "MyUser.h"
#import "DetailsViewController.h"
#import "DetailViewController.h"

@interface PhotoViewController ()<DetailsViewControllerDelegate>

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self updateForPhoto];
	[self addPhotoDetailsTableView];
}

- (void)updateForPhoto
{
	self.navigationItem.title = self.photo.name;
	self.authorLabel.text = self.photo.authorFullName;
	self.photosTakenLabel.text = [NSString stringWithFormat:@"%d", self.photo.user.numberOfPhotosTaken];
}

- (void)addPhotoDetailsTableView
{
	DetailsViewController *details = [[DetailsViewController alloc] init];
	details.photo = self.photo;
	details.delegate = self;
	[self addChildViewController:details];
	CGRect frame = self.view.bounds;
	frame.origin.y = 110;
	details.view.frame = frame;
	[self.view addSubview:details.view];
	[details didMoveToParentViewController:self];
}


#pragma mark OBJPhotoDetailsViewControllerDelegate

- (void)didSelectPhotoAttributeWithKey:(NSString *)key
{
	DetailViewController *detailViewController = [[DetailViewController alloc] init];
	detailViewController.key = key;
	[self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
