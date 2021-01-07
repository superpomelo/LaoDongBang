//
//  FirstTeacherLectureHallListCollectionViewCell.h
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherLectureHallModel.h"
#import "TeacherLectureHallListSModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstTeacherLectureHallListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *firstVideoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
- (void)reloadData:(TeacherLectureHallListSModel*)model;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;
@end

NS_ASSUME_NONNULL_END
