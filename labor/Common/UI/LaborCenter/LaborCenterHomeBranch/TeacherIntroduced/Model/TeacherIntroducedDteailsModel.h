//
//  TeacherIntroducedDteailsModel.h
//  labor
//
//  Created by 狍子 on 2021/1/6.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherIntroducedDteailsModel : NSObject
/***/
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * introduction;

@property (nonatomic, copy) NSString * sourceUrl;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * userName;

@property (nonatomic, assign) int virtualNum;
/**id*/
@property (nonatomic, assign) int idx;
@end

NS_ASSUME_NONNULL_END
