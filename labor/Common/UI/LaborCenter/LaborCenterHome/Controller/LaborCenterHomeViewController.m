//
//  LaborCenterHomeViewController.m
//  labor
//
//  Created by 狍子 on 2020/8/24.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "LaborCenterHomeViewController.h"
#import "FirstLaborCenterHomeTableViewCell.h"
#import "SecondLaborCenterHomeTableViewCell.h"
#import "ThirdLaborCenterHomeTableViewCell.h"
#import "FourthLaborCenterHomeTableViewCell.h"
#import "TeacherLectureHallViewController.h"
#import "TheExamRushedOffViewController.h"
#import "AssessmentOfTheTaskViewController.h"
#import "VRSeeCampusViewController.h"
#import "TheMessageCenterViewController.h"
#import "LaborCenterHomeSearchViewController.h"
#import "LaborCenterRequestDatas.h"
#import "LaborCenterLessonDetailsViewController.h"
#import "TaskAssessmentDetailsViewController.h"
#import "LaborLunBoModel.h"
#import "LearningCenterDetails1ViewController.h"
#import "LearningCenterDetails1NewsViewController.h"
#import "FivethLaborCenterHomeTableViewCell.h"
#import "GongGaoListViewController.h"
#import "EightLaborCenterHomeNewsTableViewCell.h"
#import "TestClassificationViewController.h"
#import "DQWKViewController.h"


//#import "UINavigationController+FDFullscreenPopGesture.h"

@interface LaborCenterHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SecondLaborCenterHomeTableViewCellDelegate,FourthLaborCenterHomeTableViewCellDelegate,JLCycleScrollerViewDelegate,EightLaborCenterHomeNewsTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *searchBottomView;
/**小红点底部view*/
@property (weak, nonatomic) IBOutlet UIView *messageCountBottomView;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;

/**选择城市*/
@property (weak, nonatomic) IBOutlet UIView *cityBottomView;

/**课程推荐数组*/
@property (nonatomic,strong)NSArray *array;
/**特别提醒数组*/
@property (nonatomic,strong)NSArray *activityarray;
/**公告数组*/
//@property (nonatomic,strong)NSArray *gongaoarray;
/**轮播数组*/
@property (nonatomic,strong)NSArray *lunboarray;
/**跑马灯*/
@property (nonatomic,strong)NSArray *paomadengarray;

@end

@implementation LaborCenterHomeViewController

//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.array = [NSArray array];
    self.activityarray = [NSArray array];
    self.lunboarray = [NSArray array];
//    self.gongaoarray = [NSArray array];
    self.paomadengarray = [NSArray array];

    [self initmyTableView];
    [self initUI];
    [self requestmobileIndexcarouselIndex];
    [self requestactivitygetActivitysList];
    [self requestTeacherLectureHall];
    [self requestinformationmobileIndexinformationone];
    self.fd_prefersNavigationBarHidden = YES;
    
//    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"data" inBundle:[NSBundle mainBundle]];
//    animation.frame = CGRectMake(SCR_W/2-45, 350, 90, 90);
//    animation.loopAnimation = YES;
//    [self.view addSubview:animation];
//    [animation playWithCompletion:^(BOOL animationFinished) {
//      // Do Something
//    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self requestremindMYREMINDsize];
}


//MARK: - Initalization - 初始化
- (void)initUI{
    self.cityBottomView.hidden = YES;
    self.messageCountBottomView.layer.cornerRadius = self.messageCountBottomView.bounds.size.height/2;
    self.messageCountBottomView.hidden = YES;
    
    self.searchBottomView.layer.cornerRadius = self.searchBottomView.bounds.size.height/2;
}

- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstLaborCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstLaborCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondLaborCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondLaborCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ThirdLaborCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThirdLaborCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FourthLaborCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FourthLaborCenterHomeTableViewCellID"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"FivethLaborCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FivethLaborCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"EightLaborCenterHomeNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"EightLaborCenterHomeNewsTableViewCellID"];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestmobileIndexcarouselIndex];
        [self requestactivitygetActivitysList];
        [self requestTeacherLectureHall];
        [self requestinformationmobileIndexinformationone];

        }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 160;
            break;
        case 1:
            return 40;
            break;
        case 2:
            //政策公告
//            if (self.gongaoarray.count>0) {
                return 110;

//            }else{
//                return 0.0000001;
//            }
            break;
        case 3:
            if (self.activityarray.count>0) {
                return 115;

            }else{
                return 0.0000001;
            }
            break;
        case 4:
            if (self.array.count%2 == 0) {
                return ((SCR_W-40)/2+5)*self.array.count/2 +(self.array.count/2*10);
            }else{
                return ((SCR_W-40)/2+5)*(self.array.count+1)/2 +((self.array.count+1)/2*10);
            }

//            return ((SCR_W-40)/2+5)*2-15;
            break;

            
        default:
            break;
    }
    return 0;
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
            return 1;
            break;
        case 2:
            return 1;
//            if (self.gongaoarray.count>2) {
//                return 2;
//            }else{
//                return self.gongaoarray.count;
//
//            }
            break;
        case 3:
            return self.activityarray.count;
            break;
        case 4:
            return 1;
            break;

        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        if (self.activityarray.count>0) {
            return 35;
        }else{
            return 0.00000000001;
        }
    }else if (section == 4) {
        return 45;
    }else{
        return 0.00000000001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        if (self.activityarray.count>0) {
            UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 35)];
            vi.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];

            [tableView addSubview:vi];
            UIView *vibg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 10)];
//            vibg.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
            vibg.backgroundColor = [UIColor whiteColor];
            [vi addSubview:vibg];


            
            UILabel *lbR = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 4, 15)];
            lbR.backgroundColor = [UIColor colorWithRed:80/255.0 green:219/255.0 blue:142/255.0 alpha:1.0];
            [vi addSubview:lbR];

            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, SCR_W, 35)];
    //        lb.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"特别提醒" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            lb.attributedText = attributedString;
            [vi addSubview:lb];
            return vi;
        }else{
            UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.00000000001)];
            return vi;
        }

    }else if (section == 41) {
        
//        if (self.gongaoarray.count>0) {
//            UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 35)];
//            vi.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//
//            [tableView addSubview:vi];
//            UIView *vibg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 10)];
//            vibg.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//
//            [vi addSubview:vibg];
//
//
//
//            UILabel *lbR = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 4, 15)];
//            lbR.backgroundColor = [UIColor colorWithRed:236/255.0 green:147/255.0 blue:41/255.0 alpha:1.0];
//            [vi addSubview:lbR];
//
//            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, SCR_W, 35)];
//    //        lb.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"政策公告" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
//            lb.attributedText = attributedString;
//            [vi addSubview:lb];
//
//            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCR_W-60, 10, 30, 35)];
//            lab.text = @"更多";
//            lab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//            lab.font = [UIFont systemFontOfSize:14];
//            [vi addSubview:lab];
//
//            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCR_W-30, 22.5, 10, 10)];
//            img.image = [UIImage imageNamed:@"ic_go3"];
//            [vi addSubview:img];
//
//            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCR_W-60, 5, 45, 40)];
//            [btn addTarget:self action:@selector(gonggaoActionMore:) forControlEvents:UIControlEventTouchUpInside];
//            [vi addSubview:btn];
//            return vi;
//        }else{
            UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.00000000001)];
            vi.backgroundColor = [UIColor redColor];
            return vi;
//        }
    
        

    }else if (section == 4) {
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 35)];
        vi.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];

        [tableView addSubview:vi];
        UIView *vibg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 10)];
//        vibg.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        vibg.backgroundColor = [UIColor whiteColor];
        [vi addSubview:vibg];


        
        UILabel *lbR = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 4, 15)];
//        lbR.backgroundColor = [UIColor colorWithRed:236/255.0 green:147/255.0 blue:41/255.0 alpha:1.0];
        
        lbR.backgroundColor = [UIColor colorWithRed:80/255.0 green:219/255.0 blue:142/255.0 alpha:1.0];
        [vi addSubview:lbR];

        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, SCR_W, 35)];
//        lb.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"课程推荐" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        lb.attributedText = attributedString;
        [vi addSubview:lb];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCR_W-60, 10, 30, 35)];
        lab.text = @"更多";
        lab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        lab.font = [UIFont systemFontOfSize:14];
        [vi addSubview:lab];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCR_W-30, 22.5, 10, 10)];
        img.image = [UIImage imageNamed:@"ic_go3"];
        [vi addSubview:img];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCR_W-60, 5, 45, 40)];
        [btn addTarget:self action:@selector(kechengActionMore:) forControlEvents:UIControlEventTouchUpInside];
        [vi addSubview:btn];
        return vi;
        

    }else{
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.00000000001)];
        return vi;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstLaborCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstLaborCenterHomeTableViewCellID"];
        if (self.lunboarray.count>0) {
            NSMutableArray *aryM = [NSMutableArray array];
            NSMutableArray *titlearyM = [NSMutableArray array];
            for (int i=0; i<self.lunboarray.count; i++) {
        
                if (i<4) {
                    LaborLunBoModel *model = self.lunboarray[i];
                    [aryM addObject:model.thumbnail];
                    [titlearyM addObject:model.title];
                }
            }
            cell.cycleView.titlessourceArray = titlearyM;
            cell.cycleView.sourceArray = aryM;
            cell.cycleView.delegate = self;
            cell.cycleView.pageControl_right = 0;

        }
        return cell;
    }else if (indexPath.section == 1){
        EightLaborCenterHomeNewsTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"EightLaborCenterHomeNewsTableViewCellID"];
        cell.delegate = self;
        if (self.paomadengarray.count>0) {
//            NSMutableArray *aryM = [NSMutableArray array];
            NSMutableArray *titlearyM = [NSMutableArray array];
            for (int i=0; i<self.paomadengarray.count; i++) {
//                if (i<3) {
                    LearningCenterHomeModel *model = self.paomadengarray[i];
//                    [aryM addObject:model.thumbnail];
                    [titlearyM addObject:model.title];
//                }

            }
            [cell reloadData:titlearyM];

         
        }
        return cell;
        
       
    }else if (indexPath.section == 2){
        SecondLaborCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondLaborCenterHomeTableViewCellID"];
        cell.delegate = self;
        return cell;



    }else if (indexPath.section == 3){
        ThirdLaborCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ThirdLaborCenterHomeTableViewCellID"];
        
        [cell reloadData:self.activityarray[indexPath.row]];
        return cell;
//        FivethLaborCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FivethLaborCenterHomeTableViewCellID"];
////        cell.delegate = self;
//        if (self.gongaoarray.count>1) {
//            if (indexPath.row==0) {
//                cell.lineLabel.hidden = NO;
//            }else{
//                cell.lineLabel.hidden = YES;
//            }
//        }
//
//        [cell reloadData:self.gongaoarray[indexPath.row]];
//        return cell;
        
      
    }else{
       FourthLaborCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FourthLaborCenterHomeTableViewCellID"];
        cell.delegate = self;
        cell.dataArray = self.array;
        [cell.myCollectionView reloadData];
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        //特别提醒
        TaskAssessmentDetailsViewController *TAvc = [[TaskAssessmentDetailsViewController alloc]init];
        TAvc.model = self.activityarray[indexPath.row];
        [TAvc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:TAvc animated:YES];
    }
//    if (indexPath.section == 3) {
//        LearningCenterDetails1NewsViewController *LCvc1 = [[LearningCenterDetails1NewsViewController alloc]init];
//        LearningCenterHomeModel *model = self.gongaoarray[indexPath.row];
//        LCvc1.informationId = model.idx;
//        [LCvc1 setHidesBottomBarWhenPushed:YES];
//
//        [self.navigationController pushViewController:LCvc1 animated:YES];
//    }
}


/**跑马灯delegate*/
- (void)EightLaborCenterHomeNewsTableViewCellActiondelegate:(EightLaborCenterHomeNewsTableViewCell*)cell index:(NSInteger)index{
    if (self.paomadengarray.count>0) {
//        LearningCenterDetails1NewsViewController *LCvc1 = [[LearningCenterDetails1NewsViewController alloc]init];
//        LearningCenterHomeModel *model = self.paomadengarray[index];
//            LCvc1.informationId = model.idx;
//            [LCvc1 setHidesBottomBarWhenPushed:YES];
//
//            [self.navigationController pushViewController:LCvc1 animated:YES];
        LearningCenterHomeModel *model = self.paomadengarray[index];
//
//        [self requestinformationinformationpageforzc:[NSString stringWithFormat:@"%d",model.idx]];
        
        DQWKViewController *PIvc = [[DQWKViewController alloc]initWithNibName:@"DQWKViewController" bundle:nil];
        [PIvc setHidesBottomBarWhenPushed:YES];
        PIvc.titleStr = @"政策详情";
        PIvc.urlstring = model.sourceUrl;
        [self.navigationController pushViewController:PIvc animated:NO];
       
    }
}

/**
 点击轮播Cell代理
 @param index 点击的<0.1.2...>
 @param sourceArray 传入进来的原始数据
 */
-(void)jl_cycleScrollerView:(JLCycleScrollerView*)view didSelectItemAtIndex:(NSInteger)index sourceArray:(NSArray*)sourceArray{
    if (self.lunboarray.count>0) {
        LearningCenterDetails1NewsViewController *LCvc1 = [[LearningCenterDetails1NewsViewController alloc]init];
        LaborLunBoModel *model = self.lunboarray[index];
        LCvc1.informationId = model.idx;
        [LCvc1 setHidesBottomBarWhenPushed:YES];

        [self.navigationController pushViewController:LCvc1 animated:YES];
        
//            LearningCenterDetails1ViewController *LCvc1 = [[LearningCenterDetails1ViewController alloc]init];
//           LaborLunBoModel *model = self.lunboarray[index];
//            LCvc1.informationId = model.idx;
//            [LCvc1 setHidesBottomBarWhenPushed:YES];
//
//            [self.navigationController pushViewController:LCvc1 animated:YES];
        
    }
    NSLog(@"%@",sourceArray[index]);
}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)messageButtonAction:(id)sender {
    TheMessageCenterViewController *TMvc = [[TheMessageCenterViewController alloc]init];
    [TMvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:TMvc animated:YES];
}

/**名师讲堂/考试冲关/任务考核/VR看校园 SecondLaborCenterHomeTableViewCellButtonActiondelegate */
- (void)SecondLaborCenterHomeTableViewCellButtonActiondelegate:(SecondLaborCenterHomeTableViewCell*)cell button:(UIButton*)sender state:(LaborCenterState)state{
    TeacherLectureHallViewController *TLvc = [[TeacherLectureHallViewController alloc]init];
    AssessmentOfTheTaskViewController *AOvc = [[AssessmentOfTheTaskViewController alloc]init];
    TheExamRushedOffViewController *TEvc = [[TheExamRushedOffViewController alloc]init];
    VRSeeCampusViewController *VRvc = [[VRSeeCampusViewController alloc]init];
    TestClassificationViewController *TCVc = [[TestClassificationViewController alloc]init];
    switch (state) {
        case LaborCenterStateTeacherLectureHall://名师讲堂
            [TLvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:TLvc animated:YES];
            break;
        case LaborCenterStateTheTest://考试冲关
            [TCVc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:TCVc animated:YES];
            
            break;
        case LaborCenterStateTheExamRushedOff://任务考核
            [AOvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:AOvc animated:YES];
            break;
        case LaborCenterStateVRSeeCampus://VR看校园
            [VRvc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VRvc animated:YES];
            break;
        default:
            break;
    }
}
- (IBAction)seachButtonAction:(id)sender {
    LaborCenterHomeSearchViewController *LCvc = [[LaborCenterHomeSearchViewController alloc]init];
    [LCvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:LCvc animated:YES];
    
}

/**公告更多*/
- (void)gonggaoActionMore:(UIButton*)sender{
    
    GongGaoListViewController *TLvc = [[GongGaoListViewController alloc]init];
    [TLvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:TLvc animated:YES];
}

/**课程更多*/
- (void)kechengActionMore:(UIButton*)sender{
    TeacherLectureHallViewController *TLvc = [[TeacherLectureHallViewController alloc]init];
    [TLvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:TLvc animated:YES];
}
//MARK: - Utility - 多用途(功能)方法
/**点击视频*/
- (void)FourthLaborCenterHomeTableViewCellCollectionViewActiondelegate:(FourthLaborCenterHomeTableViewCell*)cell index:(NSIndexPath*)indexPath{
//    LaborCenterLessonDetailsViewController *LCvc = [[LaborCenterLessonDetailsViewController alloc]init];
//    LCvc.model = self.array[indexPath.row];
//    LCvc.array = self.array;
//    [LCvc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:LCvc animated:YES];
    
    TeacherLectureHallModel *modelss = self.array[indexPath.row];
    LaborCenterLessonDetailsViewController *LCvc = [[LaborCenterLessonDetailsViewController alloc]init];
//    LCvc.model = self.array[indexPath.row];
//    LCvc.array = self.array;
    LCvc.idx = [NSString stringWithFormat:@"%d",modelss.idx];
    LCvc.courseId = [NSString stringWithFormat:@"%d",modelss.courseId];
    [LCvc setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:LCvc animated:YES];
}
//MARK: - Network request - 网络请求

/**名师讲堂-<课时列表>*/
- (void)requestTeacherLectureHall{
//    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    para[@"courseId"] = @"6";
    [LaborCenterRequestDatas TeacherLectureHallrequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.array = [NSArray array];
        self.array = result;
        [self.myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**活动-即将开始<特别提醒>*/
- (void)requestactivitygetActivitysList{
//    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    para[@"courseId"] = @"6";
    [LaborCenterRequestDatas activitygetActivitysListrequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.activityarray = [NSArray array];
        self.activityarray = result;
        [self.myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**首页轮播*/
- (void)requestmobileIndexcarouselIndex{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"type"] = @"10";
    [LaborCenterRequestDatas mobileIndexcarouselIndexrequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.lunboarray = result;
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
    }];
}

/**系统消息数量*/
- (void)requestremindMYREMINDsize{
    [LaborCenterRequestDatas remindMYREMINDsizerequestDataWithparameters:nil success:^(id  _Nonnull result) {
        NSArray *ary = result;
        if (ary.count == 0) {
            self.messageCountBottomView.hidden = YES;
        }else{
            NSMutableAttributedString *abt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",ary.count]];
            self.messageCountLabel.attributedText = abt;
            self.messageCountBottomView.hidden = NO;

        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**公示公告*/
- (void)requestinformationmobileIndexinformationone{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

//    para[@"type"] = @"13";
    para[@"classificationId"] = @"13";

    
    [LaborCenterRequestDatas informationmobileIndexinformationonerequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.paomadengarray = result;
        [self.myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**通过id获取官网地址*/
- (void)requestinformationinformationpageforzc:(NSString*)classificationId{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"classificationId"] = classificationId;
    [LaborCenterRequestDatas informationinformationpageforzcrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.paomadengarray = result;
//        [self.myTableView reloadData];
        DQWKViewController *PIvc = [[DQWKViewController alloc]initWithNibName:@"DQWKViewController" bundle:nil];

        PIvc.urlstring = @"";
        [self.navigationController pushViewController:PIvc animated:NO];
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
