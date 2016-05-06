//
//  JMCollectionItem.h
//  RuntimeTest
//
//  Created by desmond on 16/5/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMActionSheetCollectionItem.h"

@interface JMCollectionItem : NSObject <JMActionSheetCollectionItem>

@property (strong, nonatomic) NSString *actionName;
@property (strong, nonatomic) UIImage *actionImage;
@property (assign, nonatomic) UIViewContentMode actionImageContentMode;

@end