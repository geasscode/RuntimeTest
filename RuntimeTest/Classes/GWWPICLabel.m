/*!
 @abstract  定制左图右文本的控件
 @author    丁磊
 @version   1.0.0 2016/04/15 Creation
 */

#import "GWWPICLabel.h"

@interface GWWPICLabel ()
@property (nonatomic, assign, readwrite) CGFloat sizeWidth;
@property (nonatomic, assign, readwrite) CGFloat sizeHeight;
@end

@implementation GWWPICLabel
{
    UIImageView *_imageView;
    UILabel *_label;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self bulidUIElements];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self bulidUIElements];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _imageView.frame = CGRectMake(0, (CGRectGetHeight(self.bounds) - _imageNM.size.height)/2.0, _imageNM.size.width, _imageNM.size.height);
    _imageView.layer.masksToBounds = _isNeddImageRound;
    _imageView.layer.cornerRadius = (CGFloat) (_isNeddImageRound ? _imageView.bounds.size.height/2.0 : 0);

    CGFloat x = _imageView.bounds.size.width + _imageView.frame.origin.x + _space;
    _label.frame = CGRectMake(x, (CGRectGetHeight(self.bounds) - _font.lineHeight)/2.0, CGRectGetWidth(self.bounds) - x, _font.lineHeight);
}

- (void)calculateSize
{
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = _lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:_font, NSParagraphStyleAttributeName:textStyle};
    CGSize size =  [_text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    self.sizeWidth = ceilf(size.width) + 1 + _space + _imageNM.size.width;
    self.sizeHeight = MAX(ceilf(size.height) + 1, _imageNM.size.height);
}

#pragma mark -
#pragma mark - setProperty

- (void)setImageNM:(UIImage *)imageNM
{
    _imageNM = imageNM;
    _imageView.image = _imageNM;
}

- (void)setImageHL:(UIImage *)imageHL
{
    _imageHL = imageHL;
    _imageView.highlightedImage = _imageHL;
}

- (void)setColorNM:(UIColor *)colorNM
{
    _colorNM = colorNM;
    _label.textColor = _colorNM;
}

- (void)setColorHL:(UIColor *)colorHL
{
    _colorHL = colorHL;
    _label.highlightedTextColor = _colorHL;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    _label.font = _font;
}

- (void)setNumberOfLines: (NSInteger)numberOfLines
{
    _numberOfLines = numberOfLines;
    _label.numberOfLines = _numberOfLines;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    _lineBreakMode = lineBreakMode;
    _label.lineBreakMode = _lineBreakMode;
}

- (void)setText:(NSString *)text
{
    if (!text.length || [_text isEqualToString:text])
        return;

    _text = text;
    _label.text = _text;
    [self calculateSize];
}

#pragma mark -
#pragma mark - UI

- (void)bulidUIElements
{
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];

    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor clearColor];
    [self addSubview:_label];

    [self setDefaultProperty];
}

- (void)setDefaultProperty
{
    self.colorNM = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:14.0];
    self.space = 4.0;
    self.sizeWidth = 0.0;
    self.sizeHeight = 0.0;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    self.isNeedAnimation = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesEnded:touches withEvent:event];
    if (_isNeedAnimation)
    {
        [self touchAnimation:touches];
        return;
    }

    if (_touchEvent)
        _touchEvent(self);
}

- (void)touchAnimation:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint clickPoint = [touch locationInView:self];

    CALayer *clickLayer = [CALayer layer];
    clickLayer.backgroundColor = [UIColor whiteColor].CGColor;
    clickLayer.masksToBounds = YES;
    clickLayer.cornerRadius = 3;
    clickLayer.frame = CGRectMake(0, 0, 6, 6);
    clickLayer.position = clickPoint;
    clickLayer.opacity = 0.3;
    clickLayer.name = @"clickLayer";
    [self.layer addSublayer:clickLayer];

    CABasicAnimation* zoom = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoom.toValue = @38.0;
    zoom.duration = .4;

    CABasicAnimation *fadeout = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeout.toValue = @0.0;
    fadeout.duration = .4;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.4;
    [group setAnimations:@[zoom,fadeout]];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [clickLayer addAnimation:group forKey:@"animationKey"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        for (int i = 0; i < self.layer.sublayers.count; i++) {
            CALayer *obj = self.layer.sublayers[i];
            if (obj.name != nil && [@"clickLayer" isEqualToString:obj.name] && [obj animationForKey:@"animationKey"] == anim) {
                [obj removeFromSuperlayer];
            }
        }

        if (_touchEvent)
            _touchEvent(self);
    }
}
@end