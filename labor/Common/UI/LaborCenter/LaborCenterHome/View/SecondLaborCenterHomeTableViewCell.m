//
//  SecondLaborCenterHomeTableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/8/24.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "SecondLaborCenterHomeTableViewCell.h"

@implementation SecondLaborCenterHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**名师讲堂*/
- (IBAction)teacherLectureHallButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SecondLaborCenterHomeTableViewCellButtonActiondelegate:button:state:)]) {
        [self.delegate SecondLaborCenterHomeTableViewCellButtonActiondelegate:self button:sender state:LaborCenterStateTeacherLectureHall];
       }
}
/**考试冲关*/
- (IBAction)theTestButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SecondLaborCenterHomeTableViewCellButtonActiondelegate:button:state:)]) {
        [self.delegate SecondLaborCenterHomeTableViewCellButtonActiondelegate:self button:sender state:LaborCenterStateTheTest];
       }
}
/**任务考核*/
- (IBAction)theExamRushedOffButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SecondLaborCenterHomeTableViewCellButtonActiondelegate:button:state:)]) {
        [self.delegate SecondLaborCenterHomeTableViewCellButtonActiondelegate:self button:sender state:LaborCenterStateTheExamRushedOff];
       }
}
/**VR看校园*/
- (IBAction)vRSeeCampusButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SecondLaborCenterHomeTableViewCellButtonActiondelegate:button:state:)]) {
        [self.delegate SecondLaborCenterHomeTableViewCellButtonActiondelegate:self button:sender state:LaborCenterStateVRSeeCampus];
       }
}

@end
