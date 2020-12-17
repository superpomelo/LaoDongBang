//
//  LearningCenterHomeViewController.m
//  labor
//
//  Created by 狍子 on 2020/8/24.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "LearningCenterHomeViewController.h"
#import "FirstLearningCenterHomeTableViewCell.h"
#import "SecondLearningCenterHomeTableViewCell.h"
#import "ThirdLearningCenterHomeTableViewCell.h"
#import "FourthLearningCenterHomeTableViewCell.h"
#import "FivethLearningCenterHomeTableViewCell.h"
#import "LearningCenterDetails1ViewController.h"
#import "LearningCenterDetails2ViewController.h"
#import "LearningCenterRequest.h"
#import "LearningCenterHomeModel.h"
#import "LaborCenterRequestDatas.h"
#import "LaborLunBoModel.h"
#import "LearningCenterDetails1NewsViewController.h"

@interface LearningCenterHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,JLCycleScrollerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *theTitleView;
@property (nonatomic,weak)UIButton *lastbutton;
@property (nonatomic,assign)NSInteger mytag;
@property (nonatomic,strong)NSArray *lunboarray;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSArray *titleArray;

/**页码*/
@property(nonatomic,assign)NSInteger tags;
@end

@implementation LearningCenterHomeViewController

//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _titleArray = @[@"劳动知识",@"民俗知识",@"国学知识",@"农业科技",@"新闻时事",@"时代先锋"];
    self.dataArray = [NSMutableArray array];
    self.lunboarray = [NSArray array];
    self.tags = 1;
    self.titleArray = @[@"新闻时事",@"民俗知识",@"国学知识",@"农业科技",@"劳动知识"];
    self.mytag = 500;
    [self initscrollerView];
    [self initmyTableView];
    [self requestmobileIndexcarouselIndex];//轮播图
    [self requestmobileIndexinformationfiv]; //劳动知识
    self.fd_prefersNavigationBarHidden = YES;

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


//MARK: - Initalization - 初始化
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}
- (void)initscrollerView{
    UIScrollView *_scrollView = [[UIScrollView alloc]initWithFrame:self.theTitleView.bounds];
    _scrollView.contentSize = CGSizeMake(85*_titleArray.count+70, 35);
//    _scrollView.contentSize = CGSizeMake(SCR_W*20, 35);
    _scrollView.delegate = self;
       //  水平
    _scrollView.showsHorizontalScrollIndicator = NO;
        // 垂直
    _scrollView.showsVerticalScrollIndicator = NO;
//    [self viewDidLayoutSubviews];
    for (int i = 0; i<_titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15+85*i, 1, 85, 33)];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];

        
//                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"特别提醒" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_titleArray[i] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
        [btn setAttributedTitle:string forState:UIControlStateNormal];


        NSMutableAttributedString *Selstring = [[NSMutableAttributedString alloc] initWithString:_titleArray[i] attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        [btn setAttributedTitle:Selstring forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 500 + i;
        if (i==0) {
            btn.selected = YES;
            self.lastbutton = btn;
        }
        [_scrollView addSubview:btn];
        
    }
    [self.theTitleView addSubview:_scrollView];

}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstLearningCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstLearningCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondLearningCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondLearningCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ThirdLearningCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThirdLearningCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FourthLearningCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FourthLearningCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FivethLearningCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FivethLearningCenterHomeTableViewCellID"];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tags = 1;

        [self requestmobileIndexcarouselIndex];//轮播图

        if (self.mytag == 500) {
            //新闻时事
            [self requestmobileIndexinformationfiv];
            
        }else if (self.mytag == 501) {
            //民俗知识
            [self requestmobileIndexinformationtwo];
        }else if (self.mytag == 502) {
            //国学知识
            [self requestmobileIndexinformationthr];
        }else if (self.mytag == 503) {
            //农业科技
            [self requestmobileIndexinformationfou];
        }else if (self.mytag == 504) {
            //劳动知识
            [self requestmobileIndexinformationone];
        }
        
        }];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        self.tags++;
//        [self requestmobileIndexcarouselIndex];//轮播图

        if (self.mytag == 500) {
            //新闻时事
            [self requestmobileIndexinformationfiv];
            
        }else if (self.mytag == 501) {
            //民俗知识
            [self requestmobileIndexinformationtwo];
        }else if (self.mytag == 502) {
            //国学知识
            [self requestmobileIndexinformationthr];
        }else if (self.mytag == 503) {
            //农业科技
            [self requestmobileIndexinformationfou];
        }else if (self.mytag == 504) {
            //劳动知识
            [self requestmobileIndexinformationone];
        }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;

}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//    if (_dataArray.count>0) {
//        if (indexPath.section==0) {
//            return 160*SCR_W/345;
//        }else{
//            LearningCenterHomeModel *model = _dataArray[indexPath.section-1];
//
//            if ([model.body containsString:@"http"]&&[model.body containsString:@"mp4"]) {
//                //视频格式
//                 return 280;
//            }else if ([model.body containsString:@"http"]){
//                //图片格式
//                return 100;
//            }else{
//               //文字格式
//                return 100;
//            }
//        }
//    }else{
//        return 150;
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.dataArray.count;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        FirstLearningCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstLearningCenterHomeTableViewCellID"];
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
    }else{
        LearningCenterHomeModel *model = self.dataArray[indexPath.row];
        if ([model.body containsString:@"http"]&&[model.body containsString:@"mp4"]) {
         //视频格式
            FivethLearningCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FivethLearningCenterHomeTableViewCellID"];
            [cell reloadData:model];
             return cell;
        }else if ([model.body containsString:@"http"]){
          //图片格式
            SecondLearningCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondLearningCenterHomeTableViewCellID"];
            [cell reloadData:model];
            return cell;
        }else{
          //文字格式
            ThirdLearningCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ThirdLearningCenterHomeTableViewCellID"];
            [cell reloadData:model];
             return cell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        LearningCenterDetails1NewsViewController *LCvc1 = [[LearningCenterDetails1NewsViewController alloc]init];
        LearningCenterHomeModel *model = self.dataArray[indexPath.row];
        LCvc1.informationId = model.idx;
        [LCvc1 setHidesBottomBarWhenPushed:YES];

        [self.navigationController pushViewController:LCvc1 animated:YES];
        
//        LearningCenterDetails1ViewController *LCvc1 = [[LearningCenterDetails1ViewController alloc]init];
//        LearningCenterHomeModel *model = self.dataArray[indexPath.row];
//        LCvc1.informationId = model.idx;
//        [LCvc1 setHidesBottomBarWhenPushed:YES];
//
//        [self.navigationController pushViewController:LCvc1 animated:YES];
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
- (void)titleButtonAction:(UIButton*)sender{
    if (self.lastbutton == sender) {
        return;
    }
    self.tags = 1;
    if (sender.tag == 500) {
        //新闻时事
        self.mytag = 500;
        [self requestmobileIndexinformationfiv];
    }else if (sender.tag == 501){
        //民俗知识
        self.mytag = 501;
        [self requestmobileIndexinformationtwo];
    }else if (sender.tag == 502) {
        //国学知识
        self.mytag = 502;
        [self requestmobileIndexinformationthr];
    }else if (sender.tag == 503){
        //农业科技
        self.mytag = 503;
        [self requestmobileIndexinformationfou];
    }else if (sender.tag == 504){
        //劳动知识
        self.mytag = 504;
        [self requestmobileIndexinformationone];
    }
    sender.selected = YES;
    self.lastbutton.selected = NO;
    self.lastbutton = sender;
    
}
//MARK: - Utility - 多用途(功能)方法
//MARK: - Network request - 网络请求
/**劳动知识*/
- (void)requestmobileIndexinformationone{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

     para[@"type"] = @"1";
     para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];

    [LearningCenterRequest mobileIndexinformationonerequestDataWithparameters:para success:^(id  _Nonnull result) {
        if (self.tags == 1) {
            self.dataArray = result;
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
//        self.dataArray = result;
//        [self.myTableView reloadData];
//        //手动结束刷新状态
//        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}
/**民俗知识*/
- (void)requestmobileIndexinformationtwo{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

     para[@"type"] = @"2";
    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];

    [LearningCenterRequest mobileIndexinformationtworequestDataWithparameters:para success:^(id  _Nonnull result) {
        if (self.tags == 1) {
            self.dataArray = result;
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
//        self.dataArray = result;
//        [self.myTableView reloadData];
//        //手动结束刷新状态
//        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}
/**国学知识*/
- (void)requestmobileIndexinformationthr{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

     para[@"type"] = @"3";
    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];

    [LearningCenterRequest mobileIndexinformationthrrequestDataWithparameters:para success:^(id  _Nonnull result) {
        if (self.tags == 1) {
            self.dataArray = result;
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
//        self.dataArray = result;
//        [self.myTableView reloadData];
//        //手动结束刷新状态
//        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}

/**农业科技*/
- (void)requestmobileIndexinformationfou{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

     para[@"type"] = @"4";
    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];

    [LearningCenterRequest mobileIndexinformationfourequestDataWithparameters:para success:^(id  _Nonnull result) {
        if (self.tags == 1) {
            self.dataArray = result;
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
//        self.dataArray = result;
//        [self.myTableView reloadData];
//        //手动结束刷新状态
//        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}

/**新闻时事*/
- (void)requestmobileIndexinformationfiv{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

     para[@"type"] = @"5";
    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];

    [LearningCenterRequest mobileIndexinformationfivrequestDataWithparameters:para success:^(id  _Nonnull result) {
        if (self.tags == 1) {
            self.dataArray = result;
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
//        self.dataArray = result;
//        [self.myTableView reloadData];
//        //手动结束刷新状态
//        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}

/**首页轮播*/
- (void)requestmobileIndexcarouselIndex{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"type"] = @"10";
    [LaborCenterRequestDatas mobileIndexcarouselIndexrequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.lunboarray = result;
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
