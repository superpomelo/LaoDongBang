//
//  FirstLaborCenterHomeCollectionViewCell.h
//  labor
//
//  Created by 狍子 on 2020/8/28.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherLectureHallModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstLaborCenterHomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (void)initUI;
- (void)reloadData:(TeacherLectureHallModel*)model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bofangliangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstVideoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

@end

NS_ASSUME_NONNULL_END