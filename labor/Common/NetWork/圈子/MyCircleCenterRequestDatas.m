//
//  MyCircleCenterRequestDatas.m
//  labor
//
//  Created by 狍子 on 2020/9/14.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "MyCircleCenterRequestDatas.h"
#import "BaseRequestDatas.h"
#import "JsonString.h"
#import "MyCircleCenterHomeModel.h"
#import "GetCommentVoListModel.h"

@implementation MyCircleCenterRequestDatas
/**新增我的劳动圈*/
+ (void)myzonerequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
           NSString *path = [NSString stringWithFormat:@"%@activity/myzone/addmyzoneios",Host];
            NSString *JsonStr = [JsonString convertToJsonData:parameters];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"myzone"] = JsonStr;
    [BaseRequestDatas requestDataWithPath:path parameters:dict HTTPMethod:HTTPMethodPOST HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                NSLog(@"%@",result);
                NSDictionary *dict = [NSDictionary dictionary];
                dict = result;
                if ([dict.allKeys containsObject:@"data"]) {
    //             NSArray *array =  [LearningCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
                    success(@"1");

                }else{
                    NSLog(@"4");

                }
            } failure:^(NSError * _Nonnull error) {
               [SVProgressHUD showInfoWithStatus:@"服务器开小差了"];
                failure(error);
                NSLog(@"新增我的劳动圈 %@ ---%@",parameters,path);
            }];
}

/**分页查询*/
+ (void)myzonepagerequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
           NSString *path = [NSString stringWithFormat:@"%@activity/myzone/getall",Host];
//            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"myzone"] = JsonStr;
            [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                NSLog(@"%@",result);
                NSDictionary *dict = [NSDictionary dictionary];
                dict = result;
                if ([dict.allKeys containsObject:@"data"]) {
                 NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"records"]]; //数组
                    
//                 NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"records"]]; //数组
                    success(array);

                }else{
                    NSLog(@"4");

                }
            } failure:^(NSError * _Nonnull error) {
//               [SVProgressHUD showInfoWithStatus:@"failure"];
                failure(error);
                NSLog(@"分页查询 %@ ---%@",parameters,path);
            }];
}

/**学校圈<图片接口>*/
+ (void)myzonepageimgrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
               NSString *path = [NSString stringWithFormat:@"%@activity/myzone/pageimg",Host];
    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    dict[@"myzone"] = JsonStr;
                [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
                    NSLog(@"%@",result);

                    NSDictionary *dict = [NSDictionary dictionary];
                    dict = result;
                    if ([dict.allKeys containsObject:@"data"]) {
                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"records"]]; //数组
                        
    //                 NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"records"]]; //数组
                        success(array);

                    }else{
                        NSLog(@"4");

                    }
                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
                    failure(error);
                    NSLog(@"学校圈<图片接口> %@ ---%@",parameters,path);
                }];
}

/**视频圈*/
+ (void)myzonepagevidrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
            NSString *path = [NSString stringWithFormat:@"%@activity/myzone/pagevid",Host];
    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    dict[@"myzone"] = JsonStr;
                [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                    NSLog(@"%@",result);
                    NSDictionary *dict = [NSDictionary dictionary];
                    dict = result;
                    if ([dict.allKeys containsObject:@"data"]) {
                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"records"]]; //数组
                        
    //                 NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"records"]]; //数组
                        success(array);

                    }else{
                        NSLog(@"4");

                    }
                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
                    failure(error);
                    NSLog(@"视频圈 %@ ---%@",parameters,path);
                }];
}
/**查询到置顶的帖子*/
+ (void)myzonegetupzonerequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
               NSString *path = [NSString stringWithFormat:@"%@activity/myzone/getupzone",Host];
    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    dict[@"myzone"] = JsonStr;
        [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                    NSLog(@"%@",result);
                    NSDictionary *dict = [NSDictionary dictionary];
                    dict = result;
                    if ([dict.allKeys containsObject:@"data"]) {
                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
                        

                        success(array);

                    }else{
                        NSLog(@"4");

                    }
                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
                    failure(error);
                    NSLog(@"查询到置顶的帖子 %@ ---%@",parameters,path);
                }];
}

/**热度*/
+ (void)myzonegetFirerequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
               NSString *path = [NSString stringWithFormat:@"%@activity/myzone/getFire",Host];
    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    dict[@"myzone"] = JsonStr;
        [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                    NSLog(@"%@",result);
                    NSDictionary *dict = [NSDictionary dictionary];
                    dict = result;
                    if ([dict.allKeys containsObject:@"data"]) {
//                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
                        

                        success(dict);

                    }else{
                        NSLog(@"4");

                    }
                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
                    failure(error);
                    NSLog(@"热度 %@ ---%@",parameters,path);
                }];
}

/**点击签到*/
+ (void)syssignaddsignrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"%@activity/syssign/addsign",Host];
//            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"myzone"] = JsonStr;
[BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodPOST HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//         NSLog(@"%@",result);
         NSDictionary *dict = [NSDictionary dictionary];
         dict = result;
         if ([dict.allKeys containsObject:@"data"]) {
//                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
             

             success(dict);

         }else{
             NSLog(@"4");

         }
     } failure:^(NSError * _Nonnull error) {
//        [SVProgressHUD showInfoWithStatus:@"failure"];
         failure(error);
         NSLog(@"点击签到 %@ ---%@",parameters,path);

     }];
}

/**签到状态*/
+ (void)syssignsignstatusrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"%@activity/syssign/signstatus",Host];
//            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"myzone"] = JsonStr;
[BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodPOST HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//         NSLog(@"%@",result);
         NSDictionary *dict = [NSDictionary dictionary];
         dict = result;
         if ([dict.allKeys containsObject:@"data"]) {
//                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
             

             success(dict);

         }else{
             NSLog(@"4");

         }
     } failure:^(NSError * _Nonnull error) {
//        [SVProgressHUD showInfoWithStatus:@"failure"];
         failure(error);
         NSLog(@"签到状态 %@ ---%@",parameters,path);

     }];
}

/**查询连续登签到天数*/
+ (void)syssigngetsigninrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"%@activity/syssign/getsignin",Host];
//            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"myzone"] = JsonStr;
[BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
         
         NSDictionary *dict = [NSDictionary dictionary];
         dict = result;
         if ([dict.allKeys containsObject:@"data"]) {
//                     NSArray *array =  [MyCircleCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
             

             success(dict);

         }else{
             NSLog(@"4");

         }
     } failure:^(NSError * _Nonnull error) {
   
//        [SVProgressHUD showInfoWithStatus:@"failure"];
         failure(error);
         NSLog(@"查询连续登签到天数 %@ ---%@",parameters,path);

     }];
}

/**评论列表*/
+ (void)CCmobileIndexgetCommentVoListrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
       NSString *path = [NSString stringWithFormat:@"%@activity/myzonemember/getcomment",Host];
    //    NSString *JsonStr = [JsonString convertToJsonData:parameters];
        [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//            NSLog(@"%@",result);
            NSDictionary *dict = [NSDictionary dictionary];
            dict = result;
            if ([dict.allKeys containsObject:@"data"]) {
             NSArray *array =  [GetCommentVoListModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
                success(array);

            }else{
                NSLog(@"4");

            }
        } failure:^(NSError * _Nonnull error) {
//           [SVProgressHUD showInfoWithStatus:@"failure"];
            failure(error);
            NSLog(@"评论列表 %@ ---%@",parameters,path);

        }];
}
/**提交评论*/
+ (void)CCmobileIndexsubmitCommentrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
           NSString *path = [NSString stringWithFormat:@"%@activity/myzonemember/submitComment",Host];
        //    NSString *JsonStr = [JsonString convertToJsonData:parameters];
            [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodPOST HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                NSLog(@"%@",result);
                NSDictionary *dict = [NSDictionary dictionary];
                dict = result;
                if ([dict.allKeys containsObject:@"data"]) {
    //             NSArray *array =  [LearningCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
                    success(@"1");

                }else{
                    NSLog(@"4");

                }
            } failure:^(NSError * _Nonnull error) {
//               [SVProgressHUD showInfoWithStatus:@"failure"];
                failure(error);
                NSLog(@"提交评论 %@ ---%@",parameters,path);

            }];
}

/**劳动圈详情*/
+ (void)myzonegetbyidrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"%@activity/myzone/getbyid",Host];
 //    NSString *JsonStr = [JsonString convertToJsonData:parameters];
     [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
                NSLog(@"%@",result);
         NSDictionary *dict = [NSDictionary dictionary];
         dict = result;
         if ([dict.allKeys containsObject:@"data"]) {
//             NSArray *array =  [LearningCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
             MyCircleCenterHomeModel *model = [MyCircleCenterHomeModel mj_objectWithKeyValues:dict[@"data"]];
             success(model);

         }else{
             NSLog(@"4");

         }
     } failure:^(NSError * _Nonnull error) {
//               [SVProgressHUD showInfoWithStatus:@"failure"];
         failure(error);
         NSLog(@"劳动圈详情 %@ ---%@",parameters,path);

     }];
}

///**新增点赞表*/
//+ (void)CCsysuprequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
//           NSString *path = [NSString stringWithFormat:@"%@admin/sysup",Host];
//        //    NSString *JsonStr = [JsonString convertToJsonData:parameters];
//            [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodPOST HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                NSLog(@"%@",result);
//                NSDictionary *dict = [NSDictionary dictionary];
//                dict = result;
//                if ([dict.allKeys containsObject:@"data"]) {
//    //             NSArray *array =  [LearningCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
//                    success(@"1");
//
//                }else{
//                    NSLog(@"4");
//
//                }
//            } failure:^(NSError * _Nonnull error) {
//               [SVProgressHUD showInfoWithStatus:@"failure"];
//                failure(error);
//            }];
//}
//
///**取消点赞*/
//+ (void)CCsysupmycollectdelerequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
//           NSString *path = [NSString stringWithFormat:@"%@admin/sysup/mycollectdele",Host];
//        //    NSString *JsonStr = [JsonString convertToJsonData:parameters];
//            [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                NSLog(@"%@",result);
//                NSDictionary *dict = [NSDictionary dictionary];
//                dict = result;
//                if ([dict.allKeys containsObject:@"data"]) {
//    //             NSArray *array =  [LearningCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
//                    success(@"1");
//
//                }else{
//                    NSLog(@"4");
//
//                }
//            } failure:^(NSError * _Nonnull error) {
//               [SVProgressHUD showInfoWithStatus:@"failure"];
//                failure(error);
//            }];
//}
//
///**点赞状态*/
//+ (void)CCsysupmycollectstatusrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
//           NSString *path = [NSString stringWithFormat:@"%@admin/sysup/mycollectstatus",Host];
//        //    NSString *JsonStr = [JsonString convertToJsonData:parameters];
//            [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeContentTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                NSLog(@"%@",result);
//                NSDictionary *dict = [NSDictionary dictionary];
//                dict = result;
//                if ([dict.allKeys containsObject:@"data"]) {
//    //             NSArray *array =  [LearningCenterHomeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
//                    success(dict);
//
//                }else{
//                    NSLog(@"4");
//
//                }
//            } failure:^(NSError * _Nonnull error) {
//               [SVProgressHUD showInfoWithStatus:@"failure"];
//                failure(error);
//            }];
//}
//
///**新增收藏*/
//+ (void)CCsyscollectrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
//                NSString *path = [NSString stringWithFormat:@"%@activity/syscollect",Host];
//    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//                [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodPOST HeaderType:HeaderTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                    NSLog(@"%@",result);
//                    NSDictionary *dict = [NSDictionary dictionary];
//                    dict = result;
//                    if ([dict.allKeys containsObject:@"data"]) {
//                        NSLog(@"200");
//                        
//        //                NSArray *array =  [TeacherLectureHallModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
//                        success(@"200");
//
//                    }else{
//                        NSLog(@"4");
//
//                    }
//                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
//                    failure(error);
//                }];
//}
//
///**删除收藏*/
//+ (void)CCsyscollectmycollectdelerequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
//                NSString *path = [NSString stringWithFormat:@"%@activity/syscollect/mycollectdele",Host];
//    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//                [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                    NSLog(@"%@",result);
//                    NSDictionary *dict = [NSDictionary dictionary];
//                    dict = result;
//                    if ([dict.allKeys containsObject:@"data"]) {
//                        NSLog(@"200");
//                        
//        //                NSArray *array =  [TeacherLectureHallModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
//                        success(@"200");
//
//                    }else{
//                        NSLog(@"4");
//
//                    }
//                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
//                    failure(error);
//                }];
//}
//
///**收藏状态*/
//+ (void)CCsyscollectmycollectstatusrequestDataWithparameters:(nullable  id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
//                NSString *path = [NSString stringWithFormat:@"%@activity/syscollect/mycollectstatus",Host];
//    //            NSString *JsonStr = [JsonString convertToJsonData:parameters];
//                [BaseRequestDatas requestDataWithPath:path parameters:parameters HTTPMethod:HTTPMethodGET HeaderType:HeaderTypeTOKEN isShowLoading:NO success:^(id  _Nonnull result) {
//                    NSDictionary *dict = [NSDictionary dictionary];
//                    dict = result;
//                    if ([dict.allKeys containsObject:@"data"]) {
//                        NSLog(@"200");
//                        
//        //                NSArray *array =  [TeacherLectureHallModel mj_objectArrayWithKeyValuesArray:dict[@"data"]]; //数组
//                        success(dict);
//
//                    }else{
//                        NSLog(@"4");
//
//                    }
//                } failure:^(NSError * _Nonnull error) {
//                   [SVProgressHUD showInfoWithStatus:@"failure"];
//                    failure(error);
//                }];
//}
@end
