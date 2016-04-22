/*!
 @abstract  定制左图右文本的控件
 @author    丁磊
 @version   1.0.0 2016/04/15 Creation
 */

#import <Foundation/Foundation.h>

@class GWWPICLabel;

typedef void (^PICLabelTouchEvent)(GWWPICLabel *label);

@interface GWWPICLabel : UIView

@property (nonatomic, strong) UIImage *imageNM; // imageView default image
@property (nonatomic, strong) UIImage *imageHL; // imageView highlight image
@property (nonatomic, strong) UIColor *colorNM; // text default color
@property (nonatomic, strong) UIColor *colorHL; // text highlight color
@property (nonatomic, strong) UIFont *font;     // text font
@property (nonatomic, assign) BOOL isNeddImageRound; // default is NO
@property (nonatomic, assign) CGFloat space; // default is 4
@property (nonatomic, assign) NSInteger numberOfLines;
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;   // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text

@property (nonatomic, strong) NSString *text;   // set label text
@property (nonatomic, assign, readonly) CGFloat sizeWidth; // calculate width after set text
@property (nonatomic, assign, readonly) CGFloat sizeHeight; // calculate height after set text

@property (nonatomic, strong) PICLabelTouchEvent touchEvent;
@property (nonatomic, assign) BOOL isNeedAnimation; // default is YES

@end