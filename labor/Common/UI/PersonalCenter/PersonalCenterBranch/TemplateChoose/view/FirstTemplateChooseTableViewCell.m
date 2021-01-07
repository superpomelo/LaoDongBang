//
//  FirstTemplateChooseTableViewCell.m
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "FirstTemplateChooseTableViewCell.h"

@implementation FirstTemplateChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.chooseBottomView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(NSString*)titles subtitles:(NSString*)subtitles{
    self.titleLabel.text = titles;
    self.subTitleLabel.text = subtitles;
}

@end
