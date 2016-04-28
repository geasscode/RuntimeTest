//
//  WeeklyItemCell.m
//  RuntimeTest
//
//  Created by desmond on 16/4/28.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemCell.h"
#import "WeeklyItemStageModel.h"


@interface WeeklyItemCell()

@property (weak, nonatomic) IBOutlet UILabel *stageView;

@property (weak, nonatomic) IBOutlet UILabel *timeView;

@end

@implementation WeeklyItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
	
	WeeklyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
	
	if (!cell) {
		
		cell = [[[NSBundle mainBundle] loadNibNamed:@"WeeklyItemCell" owner:nil options:nil] lastObject];
	}
	
	return cell;
}

- (void)setStageModel:(WeeklyItemStageModel *)stageModel{
	
	self.stageView.text = stageModel.title;
	
	self.timeView.text = stageModel.time;
}

@end
