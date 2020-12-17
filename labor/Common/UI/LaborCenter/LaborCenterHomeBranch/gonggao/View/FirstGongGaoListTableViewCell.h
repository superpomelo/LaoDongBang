//
//  FirstGongGaoListTableViewCell.h
//  labor
//
//  Created by 狍子 on 2020/11/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningCenterHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstGongGaoListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (void)reloadData:(LearningCenterHomeModel*)model;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@end

NS_ASSUME_NONNULL_END
