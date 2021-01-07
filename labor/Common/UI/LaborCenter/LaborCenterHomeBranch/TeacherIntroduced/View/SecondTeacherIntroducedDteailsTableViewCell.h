//
//  SecondTeacherIntroducedDteailsTableViewCell.h
//  labor
//
//  Created by 狍子 on 2021/1/4.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherLectureHallListSModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SecondTeacherIntroducedDteailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

- (void)reloadData:(TeacherLectureHallListSModel*)model;
@end

NS_ASSUME_NONNULL_END
