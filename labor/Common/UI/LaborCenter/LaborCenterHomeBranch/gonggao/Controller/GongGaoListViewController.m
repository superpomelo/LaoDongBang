//
//  GongGaoListViewController.m
//  labor
//
//  Created by 狍子 on 2020/11/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "GongGaoListViewController.h"
#import "ZeroTop150JieGuoTableViewCell.h"
#import "FirstGongGaoListTableViewCell.h"
#import "LaborCenterRequestDatas.h"
#import "LearningCenterDetails1NewsViewController.h"
#import "LearningCenterHomeModel.h"

@interface GongGaoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation GongGaoListViewController

//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSArray array];
    [self initUI];
    [self initmyTableView];
    [self requestinformationmobileIndexinformationone];
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
//    self.myTableView.estimatedRowHeight = 70.0;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstGongGaoListTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstGongGaoListTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ZeroTop150JieGuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZeroTop150JieGuoTableViewCellID"];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestinformationmobileIndexinformationone];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count == 0) {
        return SCR_H;

    }else{
        return 100;

    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 1;

    }else{
        return self.dataArray.count;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count == 0) {
        ZeroTop150JieGuoTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ZeroTop150JieGuoTableViewCellID"];
        return cell;

    }else{
        FirstGongGaoListTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstGongGaoListTableViewCellID"];
        [cell reloadData:self.dataArray[indexPath.row]];
        return cell;

    }


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count==0) {
        
    }else{
        LearningCenterDetails1NewsViewController *LCvc1 = [[LearningCenterDetails1NewsViewController alloc]init];
        LearningCenterHomeModel *model = self.dataArray[indexPath.row];
        LCvc1.informationId = model.idx;
        [LCvc1 setHidesBottomBarWhenPushed:YES];

        [self.navigationController pushViewController:LCvc1 animated:YES];
    }
}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//MARK: - Utility - 多用途(功能)方法
//MARK: - Network request - 网络请求
/**公示公告*/
- (void)requestinformationmobileIndexinformationone{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"type"] = @"13";
    [LaborCenterRequestDatas informationmobileIndexinformationonerequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.dataArray = result;
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
