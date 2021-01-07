//
//  SecondLaborCenterLessonDetailsTableViewCell.h
//  labor
//
//  Created by 狍子 on 2020/9/8.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherLectureHallModel.h"

NS_ASSUME_NONNULL_BEGIN
@class SecondLaborCenterLessonDetailsTableViewCell;
@protocol SecondLaborCenterLessonDetailsTableViewCellDelegate <NSObject>

- (void)SecondLaborCenterLessonDetailsTableViewCelliconActiondelegate:(SecondLaborCenterLessonDetailsTableViewCell*)cell;

@end
@interface SecondLaborCenterLessonDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (nonatomic,weak) id<SecondLaborCenterLessonDetailsTableViewCellDelegate>delegate;

- (void)reloadData:(TeacherLectureHallModel*)model;
@end

NS_ASSUME_NONNULL_END
