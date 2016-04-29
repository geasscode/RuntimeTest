//
//  ImageModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property (nonatomic,copy) NSString *image_id;

@property (nonatomic,assign) float w;

@property (nonatomic,assign) float h;

@property (nonatomic,copy) NSString *src;

@end
