//
//  FirstGongGaoListTableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/11/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "FirstGongGaoListTableViewCell.h"
#import "MyTimeInterval.h"

@implementation FirstGongGaoListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(LearningCenterHomeModel*)model{
    self.titleLabel.text = model.title;
//    self.bodyLabel.text = [QCH5BQ filterHTML:model.body];
    self.timeLabel.text = [MyTimeInterval IntervalStringToIneedDateString:model.createTime type:@"YYYY-MM-dd"];
}
@end
