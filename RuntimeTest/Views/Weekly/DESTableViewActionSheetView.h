//
//  DESTableViewActionSheetView.h
//  RuntimeTest
//
//  Created by desmond on 16/6/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DESTableViewActionSheetView : UIView

/**
 *  创建自定义TableViewActionSheet
 *
 *  @param frame         frame
 *  @param itemArray     数据源
 *  @param showItemCount 界面展示几条数据
 *  @param bottomTitle   底部文字
 *
 *  @return NDTableViewActionSheetView
 */
+ (DESTableViewActionSheetView *)DESTableViewActionSheetViewWithFrame:(CGRect)frame
														  itemArray:(NSArray *)itemArray
													  showItemCount:(NSInteger) showItemCount
													bottomCellTitle:(NSString *)bottomTitle;

/**
 *  控件展示
 */
- (void)show;
@end
