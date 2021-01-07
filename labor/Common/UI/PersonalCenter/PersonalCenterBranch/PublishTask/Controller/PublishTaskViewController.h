//
//  PublishTaskViewController.h
//  labor
//
//  Created by 狍子 on 2020/8/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//  发布任务
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishTaskViewController : UIViewController
/**任务名称*/
@property (nonatomic,strong)NSString *titlestr;
/**活动描述*/
@property (nonatomic,strong)NSString *content;
@end

NS_ASSUME_NONNULL_END
