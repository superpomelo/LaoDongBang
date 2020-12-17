//
//  FivethMyCircleCenterDetails1TableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/8/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "FivethMyCircleCenterDetails1TableViewCell.h"
#import "MyTimeInterval.h"

@implementation FivethMyCircleCenterDetails1TableViewCell

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
    self.bodyLabel.text = model.content;
    self.timeLabel.text = [MyTimeInterval IntervalStringToIneedDateString:model.createTime type:@"MM.dd HH:mm"];
    self.userNameLabel.text = model.realName;
//    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"touxiangpleasehold"]];
}
@end
