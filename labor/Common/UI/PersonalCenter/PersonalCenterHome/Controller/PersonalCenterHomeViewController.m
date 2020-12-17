//
//  PersonalCenterHomeViewController.m
//  com.tkhy.driver
//
//  Created by 狍子 on 2020/8/3.
//  Copyright © 2020 TK. All rights reserved.
//

#import "PersonalCenterHomeViewController.h"
#import "FirstPersonalCenterHomeTableViewCell.h"
#import "SecondPersonalCenterHomeTableViewCell.h"
#import "ThirdPersonalCenterHomeTableViewCell.h"
#import "PersonalinformationViewController.h"
#import "MyCollectionViewController.h"
#import "StudyingHistoryViewController.h"
#import "CommentOnHistoryViewController.h"
#import "MyTestViewController.h"
#import "MyTaskAssessmentViewController.h"
#import "SettingUpViewController.h"
#import "MyPointsViewController.h"
#import "MyClassViewController.h"
#import "PersonalCenterRequestDatas.h"
#import "PersonalCenterHomeModel.h"
#import "UserNameViewController.h"
#import "PersonalMyCircleViewController.h"
#import "MyTaskAssessmentTeacherViewController.h"
#import "UserInfoManager.h"

@interface PersonalCenterHomeViewController ()<UITableViewDelegate,UITableViewDataSource,FirstPersonalCenterHomeTableViewCellDelegate>
{
    NSArray *_leftInformationArray1;
    NSArray *_leftInformationArray2;
    NSArray *_leftInformationArray3;
    NSArray *_leftInformationArray4;
    
    NSArray *_leftInformationImageArray1;
    NSArray *_leftInformationImageArray2;
    NSArray *_leftInformationImageArray3;
    NSArray *_leftInformationImageArray4;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)PersonalCenterHomeModel *model;
@property(nonatomic,assign)NSInteger score;
@end

@implementation PersonalCenterHomeViewController
//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.score = 0;
    //老师 TEA_NOW / 学生 STU_NOW
    if ([[UserInfoManager getJiaoSe] isEqualToString:@"TEA_NOW"]) {
     
        _leftInformationArray1 = @[@"个人信息",@"我的班级"];
    }else{
        _leftInformationArray1 = @[@"个人信息"];
    }
 
    _leftInformationArray2 = @[@"评论历史",@"任务考核"];
    _leftInformationArray3 = @[@"我的收藏",@"我的考试",@"我的圈子"];
    _leftInformationArray4 = @[@"设置"];
    
    _leftInformationImageArray1 = @[@"ic_my_1",@"ic_my_2"];
    _leftInformationImageArray2 = @[@"ic_my_4",@"ic_my_5"];
    _leftInformationImageArray3 = @[@"ic_my_sc",@"ic_my_6",@"ic_my_7"];
    _leftInformationImageArray4 = @[@"ic_my_8"];
    [self initmyTableView];
    self.fd_prefersNavigationBarHidden = YES;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self requestmobileUsergetPersonalCenterVo];
    [self requestsysintegralgetSysIntegral];
    
    if ([[UserInfoManager getJiaoSe] isEqualToString:@"TEA_NOW"]) {
     
        _leftInformationArray1 = @[@"个人信息",@"我的班级"];
    }else{
        _leftInformationArray1 = @[@"个人信息"];
    }
    [self.myTableView reloadData];
}


//MARK: - Initalization - 初始化
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstPersonalCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstPersonalCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondPersonalCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondPersonalCenterHomeTableViewCellID"];
    self.myTableView.tableFooterView = [[UIView alloc] init];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 100;
            break;
            
        default:
            break;
    }
    return 55;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _leftInformationArray1.count;
            break;
        case 2:
            return _leftInformationArray2.count;
                break;
        case 3:
            return _leftInformationArray3.count;
                break;
        case 4:
            return _leftInformationArray4.count;
                break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            break;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 10)];
    vi.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    return vi;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstPersonalCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstPersonalCenterHomeTableViewCellID"];
        cell.delegate = self;
        cell.jiFenLabel.text = [NSString stringWithFormat:@"我的积分  %ld",self.score];
        if (self.model != nil) {
            [cell reloadData:self.model];
        }
        return cell;
    }else if (indexPath.section == 1){
        SecondPersonalCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondPersonalCenterHomeTableViewCellID"];
        cell.leftLabel.text = _leftInformationArray1[indexPath.row];
        cell.leftImageView.image = [UIImage imageNamed: _leftInformationImageArray1[indexPath.row]];

        return cell;
    }else if (indexPath.section == 2){
        SecondPersonalCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondPersonalCenterHomeTableViewCellID"];
        cell.leftLabel.text = _leftInformationArray2[indexPath.row];
        cell.leftImageView.image = [UIImage imageNamed: _leftInformationImageArray2[indexPath.row]];

        return cell;
    }else if (indexPath.section == 3){
        SecondPersonalCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondPersonalCenterHomeTableViewCellID"];
        cell.leftLabel.text = _leftInformationArray3[indexPath.row];
        cell.leftImageView.image = [UIImage imageNamed: _leftInformationImageArray3[indexPath.row]];


        return cell;
    }else{
        SecondPersonalCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondPersonalCenterHomeTableViewCellID"];
        cell.leftLabel.text = _leftInformationArray4[indexPath.row];
        cell.leftImageView.image = [UIImage imageNamed: _leftInformationImageArray4[indexPath.row]];


        return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (self.model == nil) {
            return;
        }
        MyPointsViewController *MPvc = [[MyPointsViewController alloc]init];
        [MPvc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:MPvc animated:YES];
    }else if (indexPath.section == 1){
        if (self.model == nil) {
            return;
        }
        if (indexPath.row == 0) {
            PersonalinformationViewController *PIvc = [[PersonalinformationViewController alloc]init];
            [PIvc setHidesBottomBarWhenPushed:YES];
            PIvc.model = self.model;
            [self.navigationController pushViewController:PIvc animated:YES];

        }else if (indexPath.row == 1){
            MyClassViewController *MCvc = [[MyClassViewController alloc]init];
            [MCvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:MCvc animated:YES];
        }
    }else if (indexPath.section == 2){
        if (self.model == nil) {
            return;
        }
        if (indexPath.row == 0){
            CommentOnHistoryViewController *COvc = [[CommentOnHistoryViewController alloc]init];
            [COvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:COvc animated:YES];
            
        }else if (indexPath.row == 1){
            //老师 TEA_NOW / 学生 STU_NOW
            if ([[UserInfoManager getJiaoSe] isEqualToString:@"TEA_NOW"]) {
                MyTaskAssessmentTeacherViewController *MTvc = [[MyTaskAssessmentTeacherViewController alloc]init];
                [MTvc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:MTvc animated:YES];

            }else{
                MyTaskAssessmentViewController *MTvc = [[MyTaskAssessmentViewController alloc]init];
                [MTvc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:MTvc animated:YES];
            }
            
//            MyTaskAssessmentTeacherViewController *MTvc = [[MyTaskAssessmentTeacherViewController alloc]init];
//            [MTvc setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:MTvc animated:YES];

        }
    }else if (indexPath.section == 3){
        if (self.model == nil) {
            return;
        }
        if (indexPath.row == 0){
            MyCollectionViewController *MCvc = [[MyCollectionViewController alloc]init];
            [MCvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:MCvc animated:YES];
            
        }else if (indexPath.row == 1){

            MyTestViewController *MTvc = [[MyTestViewController alloc]init];
            [MTvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:MTvc animated:YES];
        }else if (indexPath.row == 2){
            
            PersonalMyCircleViewController *PMvc = [[PersonalMyCircleViewController alloc]init];
            [PMvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:PMvc animated:YES];
        }
    }else if (indexPath.section == 4){
        SettingUpViewController *SUvc = [[SettingUpViewController alloc]init];
        [SUvc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:SUvc animated:YES];
    }
  
    
}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (void)FirstPersonalCenterHomeTableViewCellmyPointButtonActiondelegate:(FirstPersonalCenterHomeTableViewCell*)cell{
    MyPointsViewController *MPvc = [[MyPointsViewController alloc]init];
    [MPvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:MPvc animated:YES];
}
//MARK: - Utility - 多用途(功能)方法
//MARK: - Network request - 网络请求
/**个人资料*/
- (void)requestmobileUsergetPersonalCenterVo{
    [PersonalCenterRequestDatas mobileUsergetPersonalCenterVorequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.model = result;
        [self.myTableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            
        }];
}

/**查询积分对象<总积分>*/
- (void)requestsysintegralgetSysIntegral{
    [PersonalCenterRequestDatas sysintegralgetSysIntegralrequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.score = [result[@"data"][@"score"] integerValue];
        [self.myTableView reloadData];
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
