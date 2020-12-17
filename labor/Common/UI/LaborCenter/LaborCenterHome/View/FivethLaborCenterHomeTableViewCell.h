//
//  FivethLaborCenterHomeTableViewCell.h
//  labor
//
//  Created by 狍子 on 2020/11/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningCenterHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FivethLaborCenterHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

- (void)reloadData:(LearningCenterHomeModel*)model;

@end

NS_ASSUME_NONNULL_END
