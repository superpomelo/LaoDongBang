//
//  TeacherIntroducedDteailsViewController.m
//  labor
//
//  Created by 狍子 on 2020/12/30.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "TeacherIntroducedDteailsViewController.h"
#import "FirstTeacherIntroducedDteailsTableViewCell.h"
#import "SecondTeacherIntroducedDteailsTableViewCell.h"
#import "LaborCenterRequestDatas.h"
#import "TeacherIntroducedDteailsModel.h"
#import "LaborCenterLessonDetailsViewController.h"
#import "LaoShiXiangQingViewController.h"

@interface TeacherIntroducedDteailsViewController ()<UITableViewDelegate,UITableViewDataSource,FirstTeacherIntroducedDteailsTableViewCellDelegate,FirstTeacherIntroducedDteailsTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *navBottomView;
@property (weak, nonatomic) IBOutlet UIView *nav2BottomView;
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplayoutconstraint;
@property (nonatomic, strong)TeacherIntroducedDteailsModel *model;
@property (nonatomic,strong)NSMutableArray *array;
/**页码*/
@property(nonatomic,assign)NSInteger tags;
@end

@implementation TeacherIntroducedDteailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([IsIphoneX isIphoneX]==NO) {
        self.toplayoutconstraint.constant = -20.0f;
    }
    self.extendedLayoutIncludesOpaqueBars = YES;

    if (@available(iOS 11.0, *)) {

            self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    } else {

            self.automaticallyAdjustsScrollViewInsets = NO;

    }
    self.array = [NSMutableArray array];
    self.tags = 1;
    [self initUI];
    [self initmyTableView];
    [self requestlearncoursegetbyid];
    [self requestTeacherLectureHall];
    self.fd_prefersNavigationBarHidden = YES;
    

}
//MARK: - Life Cycle - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
//MARK: - Initalization - 初始化

- (void)initUI{

}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.bounces = NO;
//    self.myTableView.rowHeight = UITableViewAutomaticDimension;
//    self.myTableView.estimatedRowHeight = 70.0;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstTeacherIntroducedDteailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstTeacherIntroducedDteailsTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondTeacherIntroducedDteailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondTeacherIntroducedDteailsTableViewCellID"];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tags = 1;
        [self requestlearncoursegetbyid];
        [self requestTeacherLectureHall];

        }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        self.tags++;
//        [self requestlearncoursegetbyid];
        [self requestTeacherLectureHall];

    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 359;
    }else{
        return 90;;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.array.count;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
     
        return 45;
    }else{
        return 0.00000000001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 45)];
        vi.backgroundColor = [UIColor clearColor];
        
        UIView *vis = [[UIView alloc]initWithFrame:CGRectMake(15, 25, 3, 15)];
        vis.backgroundColor = [UIColor colorWithRed:80/255.0 green:219/255.0 blue:142/255.0 alpha:1.0];
        
        [vi addSubview:vis];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(25, 25, 150, 15);
           
        label.text = @"TA的课程视频";
        label.font = [UIFont boldSystemFontOfSize:16];
           
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [vi addSubview:label];
        return vi;

    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        FirstTeacherIntroducedDteailsTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstTeacherIntroducedDteailsTableViewCellID"];
        if (self.model != nil) {
            [cell reloadData:self.model];
            cell.delegate = self;
        }
        return cell;
    }else{
        SecondTeacherIntroducedDteailsTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondTeacherIntroducedDteailsTableViewCellID"];
        [cell reloadData:self.array[indexPath.row]];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherLectureHallListSModel *modelss = self.array[indexPath.row];
    LaborCenterLessonDetailsViewController *LCvc = [[LaborCenterLessonDetailsViewController alloc]init];
//    LCvc.model = self.array[indexPath.row];
//    LCvc.array = self.array;
    LCvc.idx = [NSString stringWithFormat:@"%d",modelss.idx];
    LCvc.courseId = [NSString stringWithFormat:@"%d",modelss.courseId];

    [self.navigationController pushViewController:LCvc animated:YES];
}

//MARK: - SubViews - 子视图



//MARK: - Button Action - 点击事件
/**返回*/
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
/**点击介绍详情*/
- (void)FirstTeacherIntroducedDteailsTableViewCellDelegateButtonAction{
    if (self.model != nil) {
        LaoShiXiangQingViewController *Lvc = [[LaoShiXiangQingViewController alloc]init];
        Lvc.name = self.model.userName;
        Lvc.body = self.model.introduction;
        [self.navigationController pushViewController:Lvc animated:YES];
    }
  
}


//MARK: - Utility - 多用途(功能)方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 44) {
        self.navBottomView.backgroundColor = [UIColor whiteColor];
        self.nav2BottomView.backgroundColor = [UIColor whiteColor];
        self.titlesLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.backImageView.image = [UIImage imageNamed:@"ic_return"];
        if (self.model != nil) {
            self.titlesLabel.text = self.model.userName;
        }
    }else{
        self.navBottomView.backgroundColor = [UIColor clearColor];
        self.nav2BottomView.backgroundColor = [UIColor clearColor];
        self.titlesLabel.textColor = [UIColor whiteColor];
        self.backImageView.image = [UIImage imageNamed:@"ic_return2"];
        if (self.model != nil) {
            self.titlesLabel.text = @"";
        }
    }
}
//MARK: - Network request - 网络请求
/**老师详情*/
- (void)requestlearncoursegetbyid{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
   
    para[@"id"] = [NSString stringWithFormat:@"%ld",(long)self.courseId];
//
    [LaborCenterRequestDatas learncoursegetbyidrequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.model = result;
        [self.myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**名师讲堂-<课时列表>*/

- (void)requestTeacherLectureHall{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"courseId"] = [NSString stringWithFormat:@"%ld",self.courseId];
    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];
    
    [LaborCenterRequestDatas TeacherLectureHallrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.array = [NSArray array];
//        self.array = result;
//        [self.myTableView reloadData];
        
        if (self.tags == 1) {
            self.array = result;
        }else{
            [self.array addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
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
