//
//  FirstLaoShiXiangQingTableViewCell.h
//  labor
//
//  Created by 狍子 on 2021/1/6.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstLaoShiXiangQingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
- (void)reloadData:(NSString*)title body:(NSString*)body;
@end

NS_ASSUME_NONNULL_END
