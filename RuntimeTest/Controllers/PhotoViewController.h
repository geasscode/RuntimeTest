//
//  PhotoViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;

@interface PhotoViewController : UIViewController
@property (nonatomic, strong) Photo *photo;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *photosTakenLabel;

@end
