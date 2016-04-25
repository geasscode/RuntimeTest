//
//  DetailsViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;


@protocol DetailsViewControllerDelegate

- (void)didSelectPhotoAttributeWithKey:(NSString *)key;

@end


@interface DetailsViewController : UITableViewController

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, weak) id <DetailsViewControllerDelegate> delegate;

@end
