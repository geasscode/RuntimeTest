//
//  PhotoCell+ConfigureForPhoto.h
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "PhotoCell.h"
@class Photo;


@interface PhotoCell (ConfigureForPhoto)
- (void)configureForPhoto:(Photo *)photo;

@end
