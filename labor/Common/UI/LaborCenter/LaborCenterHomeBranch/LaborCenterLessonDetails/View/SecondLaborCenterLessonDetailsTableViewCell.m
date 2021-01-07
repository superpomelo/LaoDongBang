//
//  SecondLaborCenterLessonDetailsTableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/9/8.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "SecondLaborCenterLessonDetailsTableViewCell.h"

@implementation SecondLaborCenterLessonDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.cornerRadius = 25/2;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(TeacherLectureHallModel*)model{
    self.nameLabel.text = model.auth;

    NSAttributedString *abt = [[NSAttributedString alloc]initWithString:model.title];
    self.titleLabel.attributedText = abt;
    self.playNumLabel.text = [NSString stringWithFormat:@"播放量:%d",model.count];
    NSString *http;
    if ([model.cover containsString:@"http"]) {
        http = @"";
        
    }else{
        http = [NSString stringWithFormat:@"%@",VideoHost];
//        Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VideoHost,model.cover]];

    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http,model.cover]]];
}
/**点击头像*/
- (IBAction)iconButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SecondLaborCenterLessonDetailsTableViewCelliconActiondelegate:)]) {
        [self.delegate SecondLaborCenterLessonDetailsTableViewCelliconActiondelegate:self];
    }
}


@end
