//
//  FirstMyTaskAssessmentDetailsTableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/9/30.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "FirstMyTaskAssessmentDetailsTableViewCell.h"

@implementation FirstMyTaskAssessmentDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(TaskAssessmentDetailsModel*)model{
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}

@end
