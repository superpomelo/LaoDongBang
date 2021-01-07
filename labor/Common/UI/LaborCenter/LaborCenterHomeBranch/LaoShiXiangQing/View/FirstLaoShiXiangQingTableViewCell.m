//
//  FirstLaoShiXiangQingTableViewCell.m
//  labor
//
//  Created by 狍子 on 2021/1/6.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "FirstLaoShiXiangQingTableViewCell.h"

@implementation FirstLaoShiXiangQingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadData:(NSString*)title body:(NSString*)body{
    self.nameLabel.text = title;
    self.bodyLabel.text = body;
}

@end
