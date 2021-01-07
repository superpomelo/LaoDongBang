//
//  TestClassificationViewController.m
//  labor
//
//  Created by 狍子 on 2020/12/30.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "TestClassificationViewController.h"
#import "TheExamRushedOffViewController.h"
#import "TheTestTipsView.h"
#import "LaborCenterRequestDatas.h"
#import "ExaminationResultsViewController.h"

@interface TestClassificationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UIView *leftBottomView;
@property (weak, nonatomic) IBOutlet UIView *rightBottomView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation TestClassificationViewController
//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    self.fd_prefersNavigationBarHidden = YES;
}

//MARK: - Initalization - 初始化
- (void)initUI{
    self.leftBottomView.layer.cornerRadius = 4;
    self.rightBottomView.layer.cornerRadius = 4;
//    self.leftImageView.layer.cornerRadius = 110/2;
//    self.rightImageView.layer.cornerRadius = 110/2;

}

//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
/**返回*/
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

/**每日一练*/
- (IBAction)leftButtonAction:(id)sender {
    [self requestmobileEvaluationcheckexamexam];
}
/**考试冲关*/
- (IBAction)rightButtonAction:(id)sender {
    TheExamRushedOffViewController *TEvc = [[TheExamRushedOffViewController alloc]init];
    [TEvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:TEvc animated:YES];
}

//MARK: - Network request - 网络请求
/**每日一练 判断已考试*/
- (void)requestmobileEvaluationcheckexamexam{
//    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    para[@"examId"] = [NSString stringWithFormat:@"%d",model.idx];
//    para[@"current"] = @"6";

    [LaborCenterRequestDatas mobileEvaluationcheckeverydayexamrequestDataWithparameters:nil success:^(id  _Nonnull result) {
        if ([result[@"data"] boolValue] == YES) {
          //已考试
            
            ExaminationResultsViewController *ERvc = [[ExaminationResultsViewController alloc]init];
//            ERvc.model = model;
            ERvc.from = ExaminationResultsMeiRi;
            [self.navigationController pushViewController:ERvc animated:YES];
        }else{
            //未考试
             TheTestViewController *TTvc = [[TheTestViewController alloc]init];
//             TTvc.model = model;
             TTvc.from = ExaminationResultsMeiRi;

             [self.navigationController pushViewController:TTvc animated:YES];
        }

        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
