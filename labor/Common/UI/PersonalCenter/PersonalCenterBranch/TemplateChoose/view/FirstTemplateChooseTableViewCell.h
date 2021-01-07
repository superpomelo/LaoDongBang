//
//  FirstTemplateChooseTableViewCell.h
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstTemplateChooseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *chooseBottomView;
- (void)reloadData:(NSString*)titles subtitles:(NSString*)subtitles;

@end

NS_ASSUME_NONNULL_END
