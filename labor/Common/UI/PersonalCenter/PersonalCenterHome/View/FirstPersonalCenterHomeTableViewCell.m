//
//  FirstPersonalCenterHomeTableViewCell.m
//  com.tkhy.driver
//
//  Created by 狍子 on 2020/8/4.
//  Copyright © 2020 TK. All rights reserved.
//

#import "FirstPersonalCenterHomeTableViewCell.h"

@implementation FirstPersonalCenterHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)myPointButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(FirstPersonalCenterHomeTableViewCellmyPointButtonActiondelegate:)]) {
        [self.delegate FirstPersonalCenterHomeTableViewCellmyPointButtonActiondelegate:self];
    }
}

- (void)reloadData:(PersonalCenterHomeModel*)model{
//    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"touxiangpleasehold"]];
    self.userNameLabel.text = model.realName;
    self.classNumLabel.text = @"";
    
}

@end
