//
//  MyClassViewController.m
//  labor
//
//  Created by 狍子 on 2020/8/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "MyClassViewController.h"
#import "FirstMyClassTableViewCell.h"
#import "SecondMyClassTableViewCell.h"
#import "ThirdMyClassTableViewCell.h"
#import "PersonalCenterRequestDatas.h"
#import "PublishTaskClassModel.h"
#import "PublishTaskClassStudentModel.h"

@interface MyClassViewController ()<UITableViewDelegate,UITableViewDataSource,FirstMyClassTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@property (nonatomic,strong)NSMutableArray *studentdataArrayM;


@end

@implementation MyClassViewController

//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArrayM = [NSMutableArray array];
    self.studentdataArrayM = [NSMutableArray array];

    [self initUI];
    [self initmyTableView];
    [self requestsysclassgetbytecuserid];
    self.fd_prefersNavigationBarHidden = YES;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


//MARK: - Initalization - 初始化
- (void)initUI{
}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstMyClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstMyClassTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondMyClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondMyClassTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ThirdMyClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThirdMyClassTableViewCellID"];
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 115;
            break;
        case 1:
                return 70;
                break;
        case 2:
                return 40;
                break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
                return 1;
                break;
        case 2:
                return self.studentdataArrayM.count;
                break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstMyClassTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstMyClassTableViewCellID"];
        cell.delegate = self;
        cell.array  = self.dataArrayM;
        [cell reloadData];
         return cell;

    }else if (indexPath.section == 1) {
        SecondMyClassTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondMyClassTableViewCellID"];
         return cell;
    }else{
        ThirdMyClassTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ThirdMyClassTableViewCellID"];
        [cell reloadData:self.studentdataArrayM[indexPath.row] xuhao:indexPath.row];
         return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//MARK: - Utility - 多用途(功能)方法
- (void)FirstMyClassTableViewCellCollectionViewActiondelegate:(FirstMyClassTableViewCell*)cell  CollectionViewindexPath:(NSIndexPath*)indexPath{
    PublishTaskClassModel *model = self.dataArrayM[indexPath.row];
    self.studentdataArrayM = [PublishTaskClassStudentModel mj_objectArrayWithKeyValuesArray:model.count];
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
//    [self requestsysclassgetbyclassid:[NSString stringWithFormat:@"%d",model.classId]];
    
}
//MARK: - Network request - 网络请求
/**教师端获取班级列表<>*/
- (void)requestsysclassgetbytecuserid{
    [PersonalCenterRequestDatas sysclassgetbytecuseridrequestDataWithparameters:nil success:^(id  _Nonnull result) {
 
        self.dataArrayM = [NSMutableArray arrayWithArray:result];
        if (self.dataArrayM.count>0) {
            PublishTaskClassModel *model = self.dataArrayM[0];
           self.studentdataArrayM =  [PublishTaskClassStudentModel mj_objectArrayWithKeyValuesArray:model.count]; //数组
        }
      
        [self.myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**教师端查询学生表*/
//- (void)requestsysclassgetbyclassid:(NSString*)classId{
//    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    para[@"classId"] = classId;
//    [PersonalCenterRequestDatas sysclassgetbyclassidrequestDataWithparameters:para success:^(id  _Nonnull result) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
