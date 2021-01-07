//
//  FirstTeacherIntroducedDteailsTableViewCell.h
//  labor
//
//  Created by 狍子 on 2020/12/30.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherIntroducedDteailsModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FirstTeacherIntroducedDteailsTableViewCellDelegate <NSObject>
/**点击介绍详情*/
- (void)FirstTeacherIntroducedDteailsTableViewCellDelegateButtonAction;

@end
@interface FirstTeacherIntroducedDteailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *jieshaoLabel;
@property (nonatomic,weak) id<FirstTeacherIntroducedDteailsTableViewCellDelegate>delegate;

- (void)reloadData:(TeacherIntroducedDteailsModel*)model;
@end

NS_ASSUME_NONNULL_END
