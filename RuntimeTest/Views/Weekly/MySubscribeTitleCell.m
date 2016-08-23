//
//  MySubscribeTitleCell.m
//  RuntimeTest
//
//  Created by desmond on 16/8/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MySubscribeTitleCell.h"


@interface MySubscribeTitleCell()


@property (weak, nonatomic) IBOutlet UIView *selectedIndictor;
@property (weak, nonatomic) IBOutlet UILabel *topicNameLabel;

@end

@implementation MySubscribeTitleCell

- (void)awakeFromNib {
	NSLog(@"hello");
	[super awakeFromNib];

}


+ (UINib *)nib
{
	return [UINib nibWithNibName:@"MySubscribeTitleCell" bundle:nil];
}

- (void)setTopic:(SubscribeModel*)topic
{
	_topic = topic;
	self.topicNameLabel.text = topic.subscribeName;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	[super setSelected:selected animated:animated];
	self.selectedIndictor.hidden = !selected;
	self.topicNameLabel.textColor = selected ? [UIColor redColor] : [UIColor blueColor];
}

@end
