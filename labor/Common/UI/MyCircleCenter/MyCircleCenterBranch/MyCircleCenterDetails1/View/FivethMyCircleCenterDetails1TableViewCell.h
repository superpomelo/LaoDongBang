//
//  FivethMyCircleCenterDetails1TableViewCell.h
//  labor
//
//  Created by 狍子 on 2020/8/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCommentVoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FivethMyCircleCenterDetails1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (void)reloadData:(GetCommentVoListModel*)model;
@end

NS_ASSUME_NONNULL_END
