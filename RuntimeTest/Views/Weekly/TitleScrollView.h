//
//  TitleScrollView.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTitleScrollViewItemsFontSize 17
#define kItemsPadding 25.0
#define kTitleScrollViewHeight 40

@class TitleScrollView;
@protocol TitleScrollViewDelegate <UIScrollViewDelegate>

/**
 *  titleScrollView上的item被点击的代理方法
 */
-(void)titleScrollView:(TitleScrollView *)titleScrollView didSelectedItemIndex:(NSInteger)index;


@end

@interface TitleScrollView : UIView

@property (nonatomic,weak) id<TitleScrollViewDelegate>delegate;

/**
 *  装有titleModel的数组
 */
@property (nonatomic,strong) NSArray *titleModelArray;

/**
 *  tabBar当前选中的item的索引
 */
@property (nonatomic, assign) NSInteger currentItemIndex;

@end
