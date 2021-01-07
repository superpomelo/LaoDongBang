//
//  FirstTeacherIntroducedDteailsTableViewCell.m
//  labor
//
//  Created by 狍子 on 2020/12/30.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "FirstTeacherIntroducedDteailsTableViewCell.h"

@implementation FirstTeacherIntroducedDteailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.cornerRadius = 80/2;
    self.iconImageView.layer.borderWidth = 3;
    self.iconImageView.layer.borderColor = [UIColor colorWithRed:107/255.0 green:209/255.0 blue:149/255.0 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(TeacherIntroducedDteailsModel*)model{
    NSString *http;
    if ([model.cover containsString:@"http"]) {
        http = @"";
        
    }else{
        http = [NSString stringWithFormat:@"%@",VideoHost];
//        Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VideoHost,model.cover]];

    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http,model.cover]]];
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.usernameLabel.text = model.userName;
    NSMutableAttributedString *abt = [[NSMutableAttributedString alloc]initWithString:model.introduction];
    self.jieshaoLabel.attributedText = abt;
}
/**点击介绍*/
- (IBAction)jieshaoButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(FirstTeacherIntroducedDteailsTableViewCellDelegateButtonAction)]) {
        [self.delegate FirstTeacherIntroducedDteailsTableViewCellDelegateButtonAction];
    }
}


@end
