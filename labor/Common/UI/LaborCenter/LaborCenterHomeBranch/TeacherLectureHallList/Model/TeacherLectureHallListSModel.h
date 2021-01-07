//
//  TeacherLectureHallListSModel.h
//  labor
//
//  Created by 狍子 on 2021/1/6.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherLectureHallListSModel : NSObject
/**课程id*/
@property (nonatomic, assign) int courseId;
@property (nonatomic, copy) NSString *auth;
/**课时id*/
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int sort;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) int idx;
@property (nonatomic, copy) NSString *faceUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *videoUrl;


@end

NS_ASSUME_NONNULL_END
