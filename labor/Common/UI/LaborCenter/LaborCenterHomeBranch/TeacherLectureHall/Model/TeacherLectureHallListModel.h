//
//  TeacherLectureHallListModel.h
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherLectureHallListModel : NSObject

@property (nonatomic, copy) NSString *auth;
@property (nonatomic, copy) NSString *body;

@property (nonatomic, assign) int idx;
@property (nonatomic, assign) int count;

@property (nonatomic, assign) int courseId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *faceUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, assign) int videoLength;
@end

NS_ASSUME_NONNULL_END
