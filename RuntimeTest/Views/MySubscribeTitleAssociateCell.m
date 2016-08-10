//
//  MySubscribeTitleAssociateCell.m
//  RuntimeTest
//
//  Created by desmond on 16/8/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MySubscribeTitleAssociateCell.h"
#import "SubscribeModel.h"
#import "UIImageView+WebCache.h"



@interface MySubscribeTitleAssociateCell()
@property (weak, nonatomic) IBOutlet UIImageView *feedIcon;
@property (weak, nonatomic) IBOutlet UILabel *feedTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *feedButton;


@end
@implementation MySubscribeTitleAssociateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubscribeInfo:(SubscribeModel *)subscribe
{
	
	self.feedTitleLabel.text = subscribe.subscribeName;
	[self.feedIcon sd_setImageWithURL:[NSURL URLWithString:subscribe.subscribeIconPath]];
}

@end
