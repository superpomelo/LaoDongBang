//
//  SecondTeacherIntroducedDteailsTableViewCell.m
//  labor
//
//  Created by 狍子 on 2021/1/4.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "SecondTeacherIntroducedDteailsTableViewCell.h"

@implementation SecondTeacherIntroducedDteailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.myImageView.layer.cornerRadius = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(TeacherLectureHallListSModel*)model{
    NSString *http;
    if ([model.faceUrl containsString:@"http"]) {
        http = @"";
        
    }else{
        http = [NSString stringWithFormat:@"%@",VideoHost];
//        Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VideoHost,model.cover]];

    }
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http,model.faceUrl]]];
    self.titleLabel.text = model.title;
    self.teacherNameLabel.text = model.body;
}

@end
