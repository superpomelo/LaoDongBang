//
//  SecondLaborCenterHomeTableViewCell.h
//  labor
//
//  Created by 狍子 on 2020/8/24.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {

LaborCenterStateTeacherLectureHall  = 0, //名师讲堂

LaborCenterStateTheTest = 1,  //考试冲关

LaborCenterStateTheExamRushedOff = 2, //任务考核

LaborCenterStateVRSeeCampus //VR看校园

} LaborCenterState; //用户选择 名师讲堂/考试冲关/任务考核/VR看校园 的枚举

NS_ASSUME_NONNULL_BEGIN
@class SecondLaborCenterHomeTableViewCell;
@protocol SecondLaborCenterHomeTableViewCellDelegate <NSObject>
/**名师讲堂/考试冲关/任务考核/VR看校园*/
- (void)SecondLaborCenterHomeTableViewCellButtonActiondelegate:(SecondLaborCenterHomeTableViewCell*)cell button:(UIButton*)sender state:(LaborCenterState)state;

@end
@interface SecondLaborCenterHomeTableViewCell : UITableViewCell
@property (nonatomic,weak) id<SecondLaborCenterHomeTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
