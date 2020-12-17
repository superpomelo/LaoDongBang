//
//  ThirdLearningCenterDetails1TableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/8/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "ThirdLearningCenterDetails1TableViewCell.h"

@implementation ThirdLearningCenterDetails1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(GetCommentVoListModel*)model{
    self.bodyLabel.text = model.body;
    if ([model.createTime containsString:@" "]) {
        NSArray *array = [model.createTime componentsSeparatedByString:@" "];
        self.timeLabel.text = [NSString stringWithFormat:@"%@",array[0]];
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%@",model.createTime];
    }
//    self.timeLabel.text = model.createTime;
    self.userNameLabel.text = model.userName;
//    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"touxiangpleasehold"]];
}
@end