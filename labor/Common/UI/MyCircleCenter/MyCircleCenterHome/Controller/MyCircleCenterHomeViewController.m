//
//  MyCircleCenterHomeViewController.m
//  labor
//
//  Created by 狍子 on 2020/8/24.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "MyCircleCenterHomeViewController.h"
#import "FirstMyCircleCenterHomeTableViewCell.h"
#import "SecondMyCircleCenterHomeTableViewCell.h"
#import "ThirdMyCircleCenterHomeTableViewCell.h"
#import "MyCircleCenterDetails1ViewController.h"
#import "MyCircleCenterDetails2ViewController.h"
#import "NewCirclesViewController.h"
#import "TheIntegralsignInViewController.h"
#import "MyCircleCenterRequestDatas.h"
#import "MyCircleCenterHomeModel.h"
#import "FourthMyCircleCenterHomeTableViewCell.h"
#import "LaborCenterRequestDatas.h"
#import "LearningCenterRequest.h"
#import "LearningCenterDetailsModel.h"
#import "FiveMyCircleCenterHomeTableViewCell.h"
#import "SixMyCircleCenterHomeTableViewCell.h"
#import "SectionHeaderMyCircleCenterHomeView.h"
#import "ZeroTop150JieGuoTableViewCell.h"
#import "Rottie1View.h"

@interface MyCircleCenterHomeViewController ()<UITableViewDelegate,UITableViewDataSource,FirstMyCircleCenterHomeTableViewCellDelegate,ThirdMyCircleCenterHomeTableViewCellDelegate,FiveMyCircleCenterHomeTableViewCellDelegate,SixMyCircleCenterHomeTableViewCellDelegate,SectionHeaderMyCircleCenterHomeViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
/**新圈子底部view*/
@property (weak, nonatomic) IBOutlet UIView *addBottomView;
/**圈子内容数组*/
@property (nonatomic,strong)NSMutableArray *dataArrayM;
/**置顶的数组*/
@property (nonatomic,strong)NSMutableArray *zhiDingdataArrayM;
/**1全部，2校园圈，3视频*/
@property(nonatomic,assign)int mytag;
@property (nonatomic,strong)Rottie1View *rottieView;
@property (nonatomic,strong)LOTAnimationView *animatedView;
/**页码*/
@property(nonatomic,assign)NSInteger tags;

/**热度*/
@property(nonatomic,assign)int Fire;

/**全部/校园圈/视频 view*/
@property(nonatomic, strong)SectionHeaderMyCircleCenterHomeView *sectionHeaderView;
@end

@implementation MyCircleCenterHomeViewController


//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArrayM = [NSMutableArray array];
    self.zhiDingdataArrayM = [NSMutableArray array];
    self.Fire = 0;
    self.mytag = 1;
    self.tags = 1;
    [self initUI];
    [self initmyTableView];
    [self requestmyzonegetFire];
    [self requestmyzonegetupzone];
    //刷新代码
   if (self.mytag == 1) {
       //全部
        [self requestmyzonepage];
   }else if (self.mytag == 2){
    //校园圈
    [self requestmyzonepageimg];
   }else if (self.mytag == 3) {
    //视频圈
    [self requestmyzonepagevid];
   }else{
       //全部
        [self requestmyzonepage];
   }
    self.fd_prefersNavigationBarHidden = YES;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];

}


//MARK: - Initalization - 初始化

-(void)setShowAnimation:(BOOL)showAnimation{
    if (showAnimation) {
        self.rottieView.hidden = NO;

        if (!_animatedView) {
            LOTAnimationView *animatedView = [LOTAnimationView animationNamed:@"data" inBundle:[NSBundle mainBundle]];
            animatedView.loopAnimation = YES;
            animatedView.contentMode = UIViewContentModeScaleAspectFill;
            [self.rottieView addSubview:_animatedView = animatedView];
            [animatedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(90, 90));
                make.center.equalTo(self.rottieView);
            }];
        }

        [_animatedView play];
    }else{
        self.rottieView.hidden = YES;
        [_animatedView stop];
    }
}
/**Rottie1Viewview*/
- (Rottie1View *)rottieView{
    if (!_rottieView) {
        _rottieView = [[NSBundle mainBundle] loadNibNamed:@"Rottie1View" owner:self options:nil][0];
        _rottieView.frame = self.view.bounds;
        _rottieView.center = self.tabBarController.view.center;
//        _rottieView.delegate = self;
////        [_carImmediatelyView settingUI];
        [self.tabBarController.view addSubview:_rottieView];
    }
    return _rottieView;
}

//- (LOTAnimationView *)animation{
//    if (!_animation) {
//        _animation = [LOTAnimationView animationNamed:@"data" inBundle:[NSBundle mainBundle]];
//        _animation.frame = CGRectMake(0, 0, 90, 90);
//        _animation.animationProgress = 0;
//        _animation.loopAnimation = YES;
////        _rottieView.delegate = self;
//////        [_carImmediatelyView settingUI];
////        [self.view addSubview:_rottieView];
////        [_animation playWithCompletion:^(BOOL animationFinished) {
////          // Do Something
////            NSLog(@"1");
////        }];
//    }
//    return _animation;
//}

/**全部/校园圈/视频view*/
- (SectionHeaderMyCircleCenterHomeView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[NSBundle mainBundle] loadNibNamed:@"SectionHeaderMyCircleCenterHomeView" owner:self options:nil][0];
        _sectionHeaderView.frame = CGRectMake(0, 0, SCR_W, 55);
        _sectionHeaderView.delegate = self;
        
        _sectionHeaderView.allButton.selected = YES;
        _sectionHeaderView.schoolButton.selected = NO;
        _sectionHeaderView.videoButton.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _sectionHeaderView.lineLabel.center = CGPointMake(_sectionHeaderView.allButton.center.x, _sectionHeaderView.lineLabel.center.y);
        }];
//        [_carImmediatelyView settingUI];
//        [self.sendOrderBottomView addSubview:_sectionHeaderView];
    }
    return _sectionHeaderView;
}

- (void)initUI{
    self.myTableView.layer.cornerRadius = 8;
    self.addBottomView.layer.cornerRadius = self.addBottomView.bounds.size.height/2;
}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstMyCircleCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstMyCircleCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondMyCircleCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondMyCircleCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ThirdMyCircleCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThirdMyCircleCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FourthMyCircleCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FourthMyCircleCenterHomeTableViewCellID"];
   [self.myTableView registerNib:[UINib nibWithNibName:@"FiveMyCircleCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FiveMyCircleCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SixMyCircleCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SixMyCircleCenterHomeTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ZeroTop150JieGuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZeroTop150JieGuoTableViewCellID"];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tags = 1;
        [self requestmyzonegetupzone];
            //刷新代码
        if (self.mytag == 1) {
           //全部
            [self requestmyzonepage];
        }else if (self.mytag == 2){
            //校园圈
            [self requestmyzonepageimg];
        }else if (self.mytag == 3) {
            //视频圈
            [self requestmyzonepagevid];
        }
        
        }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        self.tags++;
//        [self requestmobileIndexcarouselIndex];//轮播图

        //刷新代码
    if (self.mytag == 1) {
       //全部
        [self requestmyzonepage];
    }else if (self.mytag == 2){
        //校园圈
        [self requestmyzonepageimg];
    }else if (self.mytag == 3) {
        //视频圈
        [self requestmyzonepagevid];
    }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;

}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section ==0) {
//        return 90;
//    }else if (indexPath.section ==1){
//        return 35;
//    }else if (indexPath.section ==2){
//        return 0;
//    }else if (indexPath.section ==3){
//        /**imgorvid   0视频 1-图片 2文本*/
//        MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
//        if (model.imgorvid == 0) {
//            return 350;
//        }else if (model.imgorvid == 1){
//            return 350;
//
//        }else{
//            return 350-162;
//
//        }
//    }else{
//        return 0;
//    }
//    
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if (self.zhiDingdataArrayM.count>2) {
                return 2;
            }else{
                return self.zhiDingdataArrayM.count;
            }
            break;
        case 2:
                return 0;
                break;
        case 3:
            if (self.dataArrayM.count == 0) {
                return 1;
            }else{
                return self.dataArrayM.count;
            }
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 55;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        
        [tableView addSubview:self.sectionHeaderView];
        return self.sectionHeaderView;
    }else{
        return nil;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstMyCircleCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstMyCircleCenterHomeTableViewCellID"];
        cell.delegate = self;
        [cell reloadData:self.Fire];
      
        return cell;
    }else if (indexPath.section == 1){
        SecondMyCircleCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondMyCircleCenterHomeTableViewCellID"];
        [cell reloadData:self.zhiDingdataArrayM[indexPath.row]];
        if (indexPath.row==0) {
            cell.zhidingBottomView.backgroundColor = [UIColor colorWithRed:85/255.0 green:110/255.0 blue:234/255.0 alpha:1.0];
        }else{
            cell.zhidingBottomView.backgroundColor = [UIColor colorWithRed:255/255.0 green:101/255.0 blue:60/255.0 alpha:1.0];
        }
        return cell;
    }else if (indexPath.section == 2){
  
        FourthMyCircleCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FourthMyCircleCenterHomeTableViewCellID"];
//        cell.delegate = self;
//        if (self.mytag == 1) {
//            cell.allButton.selected = YES;
//            cell.schoolButton.selected = NO;
//            cell.videoButton.selected = NO;
//            [UIView animateWithDuration:0.3 animations:^{
//                cell.lineLabel.center = CGPointMake(cell.allButton.center.x, cell.lineLabel.center.y);
//            }];
//
//        }else if (self.mytag == 2) {
//            cell.schoolButton.selected = YES;
//            cell.allButton.selected = NO;
//            cell.videoButton.selected = NO;
//            [UIView animateWithDuration:0.3 animations:^{
//                cell.lineLabel.center = CGPointMake(cell.schoolButton.center.x, cell.lineLabel.center.y);
//            }];
//        }else if (self.mytag == 3) {
//            cell.videoButton.selected = YES;
//            cell.allButton.selected = NO;
//            cell.schoolButton.selected = NO;
//            [UIView animateWithDuration:0.3 animations:^{
//                cell.lineLabel.center = CGPointMake(cell.videoButton.center.x, cell.lineLabel.center.y);
//            }];
//        }
        return cell;
    }else{
        
        if (self.dataArrayM.count == 0) {
            ZeroTop150JieGuoTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ZeroTop150JieGuoTableViewCellID"];
         
            return cell;
        }else{
            /**imgorvid   0视频 1-图片 2文本*/
            MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
            if (model.imgorvid == 0) {
                 FiveMyCircleCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FiveMyCircleCenterHomeTableViewCellID"];
                 [cell reloadData:self.dataArrayM[indexPath.row]];
                 cell.indexPath = indexPath;
                 cell.delegate = self;
                 return cell;
            }else if (model.imgorvid == 1){
                ThirdMyCircleCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ThirdMyCircleCenterHomeTableViewCellID"];
                 [cell reloadData:self.dataArrayM[indexPath.row]];
                 cell.indexPath = indexPath;
                 cell.delegate = self;
                 return cell;

            }else{
                SixMyCircleCenterHomeTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SixMyCircleCenterHomeTableViewCellID"];
                 [cell reloadData:self.dataArrayM[indexPath.row]];
                 cell.indexPath = indexPath;
                 cell.delegate = self;
                 return cell;

            }
        }
      

    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
        MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
        [CDvc1 setHidesBottomBarWhenPushed:YES];
        CDvc1.idx = [NSString stringWithFormat:@"%d",model.idx];
        [self.navigationController pushViewController:CDvc1 animated:YES];
    }else if (indexPath.section == 3) {
//        if (indexPath.row == 0) {
        if (self.dataArrayM.count == 0) {
           
        }else{
            MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
            MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
            [CDvc1 setHidesBottomBarWhenPushed:YES];
//        CDvc1.model = self.dataArrayM[indexPath.row];
            CDvc1.idx = [NSString stringWithFormat:@"%d",model.idx];
            [self.navigationController pushViewController:CDvc1 animated:YES];
        }

//        }else{
//            MyCircleCenterDetails2ViewController *CDvc2 = [[MyCircleCenterDetails2ViewController alloc]init];
//            [CDvc2 setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:CDvc2 animated:YES];
//        }
    }
}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)newCirclesButtonAction:(id)sender {
    NewCirclesViewController *NCvc1 = [[NewCirclesViewController alloc]initWithNibName:@"NewCirclesViewController" bundle:nil];
    [NCvc1 setHidesBottomBarWhenPushed:YES];
//    [self presentViewController:NCvc1 animated:YES completion:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:NCvc1 animated:YES];
//    });
  
}
/**签到*/
- (void)FirstMyCircleCenterHomeTableViewCelltheIntegralsignInButtonActiondelegate:(FirstMyCircleCenterHomeTableViewCell*)cell{
    TheIntegralsignInViewController *TIvc = [[TheIntegralsignInViewController alloc]init];
    [TIvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:TIvc animated:YES];
}
//MARK: - Utility - 多用途(功能)方法
/**1收藏，2评论，3转发，4点赞*/
- (void)ThirdMyCircleCenterHomeTableViewCellButtonActiondelegate:(ThirdMyCircleCenterHomeTableViewCell*)cell indexpath:(NSIndexPath*)indexPath Tag:(int)tag{
    MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];

    if (tag==1) {
            //收藏状态
        if ([model.collectstatus boolValue]== NO) {
            [self requestsyscollect:indexPath];
        }else if ([model.collectstatus boolValue] == YES){
            [self requestsyscollectmycollectdele:indexPath];

        }
    }else if (tag==2) {
//            MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
//            [CDvc1 setHidesBottomBarWhenPushed:YES];
//        CDvc1.model = self.dataArrayM[indexPath.row];
//            [self.navigationController pushViewController:CDvc1 animated:YES];
        
        MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
        MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
        [CDvc1 setHidesBottomBarWhenPushed:YES];
//        CDvc1.model = self.dataArrayM[indexPath.row];
        CDvc1.idx = [NSString stringWithFormat:@"%d",model.idx];
        [self.navigationController pushViewController:CDvc1 animated:YES];
    }else if (tag==3) {
            [SVProgressHUD showInfoWithStatus:@"开发中，敬请期待"];

        
    }else if (tag==4) {
        //点赞状态
        if ([model.upstatus boolValue] == NO) {
            [self requestsysuprequest:indexPath];
        }else if ([model.upstatus boolValue] == YES) {
            [self requestsysupmycollectdele:indexPath];

        }
    }
}

/**1收藏，2评论，3转发，4点赞*/
- (void)FiveMyCircleCenterHomeTableViewCellButtonActiondelegate:(FiveMyCircleCenterHomeTableViewCell*)cell indexpath:(NSIndexPath*)indexPath Tag:(int)tag{
    MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];

    if (tag==1) {
            //收藏状态
        if ([model.collectstatus boolValue]== NO) {
            [self requestsyscollect:indexPath];
        }else if ([model.collectstatus boolValue] == YES){
            [self requestsyscollectmycollectdele:indexPath];

        }
    }else if (tag==2) {
//            MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
//            [CDvc1 setHidesBottomBarWhenPushed:YES];
//            CDvc1.model = self.dataArrayM[indexPath.row];
//            [self.navigationController pushViewController:CDvc1 animated:YES];
        
        MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
        MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
        [CDvc1 setHidesBottomBarWhenPushed:YES];
//        CDvc1.model = self.dataArrayM[indexPath.row];
        CDvc1.idx = [NSString stringWithFormat:@"%d",model.idx];
        [self.navigationController pushViewController:CDvc1 animated:YES];
    }else if (tag==3) {
        [SVProgressHUD showInfoWithStatus:@"开发中，敬请期待"];

    }else if (tag==4) {
        //点赞状态
        if ([model.upstatus boolValue] == NO) {
            [self requestsysuprequest:indexPath];
        }else if ([model.upstatus boolValue] == YES) {
            [self requestsysupmycollectdele:indexPath];

        }
    }
}
/**1收藏，2评论，3转发，4点赞*/
- (void)SixMyCircleCenterHomeTableViewCellButtonActiondelegate:(SixMyCircleCenterHomeTableViewCell*)cell indexpath:(NSIndexPath*)indexPath Tag:(int)tag{
    MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];

    if (tag==1) {
            //收藏状态
        if ([model.collectstatus boolValue]== NO) {
            [self requestsyscollect:indexPath];
        }else if ([model.collectstatus boolValue] == YES){
            [self requestsyscollectmycollectdele:indexPath];

        }
    }else if (tag==2) {
//            MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
//            [CDvc1 setHidesBottomBarWhenPushed:YES];
//        CDvc1.model = self.dataArrayM[indexPath.row];
//            [self.navigationController pushViewController:CDvc1 animated:YES];
        
        MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
        MyCircleCenterDetails1ViewController *CDvc1 = [[MyCircleCenterDetails1ViewController alloc]init];
        [CDvc1 setHidesBottomBarWhenPushed:YES];
//        CDvc1.model = self.dataArrayM[indexPath.row];
        CDvc1.idx = [NSString stringWithFormat:@"%d",model.idx];
        [self.navigationController pushViewController:CDvc1 animated:YES];
    }else if (tag==3) {
        [SVProgressHUD showInfoWithStatus:@"开发中，敬请期待"];

    }else if (tag==4) {
        //点赞状态
        if ([model.upstatus boolValue] == NO) {
            [self requestsysuprequest:indexPath];
        }else if ([model.upstatus boolValue] == YES) {
            [self requestsysupmycollectdele:indexPath];

        }
    }
}
/**全部/校园圈/视频*/
//tag 1全部 2校园圈 3视频
//- (void)FourthMyCircleCenterHomeTableViewCellButtonActiondelegate:(FourthMyCircleCenterHomeTableViewCell*)cell tag:(int)tag{
//    if (tag==1) {
//        self.mytag = 1;
//        [self requestmyzonepage];
//    }else if (tag ==2){
//        self.mytag = 2;
//        [self requestmyzonepageimg];
//    }else if (tag==3){
//        self.mytag = 3;
//        [self requestmyzonepagevid];
//    }
//    [self.myTableView reloadData];
//}
/**全部/校园圈/视频*/
- (void)SectionHeaderMyCircleCenterHomeViewButtonActiondelegate:(SectionHeaderMyCircleCenterHomeView*)cell tag:(int)tag{
    self.tags = 1;

    if (tag==1) {
        self.mytag = 1;
        cell.allButton.selected = YES;
        cell.schoolButton.selected = NO;
        cell.videoButton.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            cell.lineLabel.center = CGPointMake(cell.allButton.center.x, cell.lineLabel.center.y);
        }];
        [self requestmyzonepage];
    }else if (tag ==2){
        self.mytag = 2;
        cell.schoolButton.selected = YES;
        cell.allButton.selected = NO;
        cell.videoButton.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            cell.lineLabel.center = CGPointMake(cell.schoolButton.center.x, cell.lineLabel.center.y);
        }];
        [self requestmyzonepageimg];
    }else if (tag==3){
        self.mytag = 3;
        cell.videoButton.selected = YES;
        cell.allButton.selected = NO;
        cell.schoolButton.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            cell.lineLabel.center = CGPointMake(cell.videoButton.center.x, cell.lineLabel.center.y);
        }];
        [self requestmyzonepagevid];
    }
    [self.myTableView reloadData];
}
//MARK: - Network request - 网络请求
/**分页查询*/
- (void)requestmyzonepage{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];
    [self setShowAnimation:YES];
    [MyCircleCenterRequestDatas myzonepagerequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.dataArrayM = result;
//        [self.myTableView reloadData];
        if (self.tags == 1) {
            self.dataArrayM = result;
        }else{
            [self.dataArrayM addObjectsFromArray:result];
        }
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self setShowAnimation:NO];
    } failure:^(NSError * _Nonnull error) {
        [self setShowAnimation:NO];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}

/**学校圈<图片接口>*/
- (void)requestmyzonepageimg{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];
    [MyCircleCenterRequestDatas myzonepageimgrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.dataArrayM = result;
//        [self.myTableView reloadData];
        if (self.tags == 1) {
            self.dataArrayM = result;
        }else{
            [self.dataArrayM addObjectsFromArray:result];
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
/**视频圈*/
- (void)requestmyzonepagevid{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];

    [MyCircleCenterRequestDatas myzonepagevidrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.dataArrayM = result;
//        [self.myTableView reloadData];
        if (self.tags == 1) {
            self.dataArrayM = result;
        }else{
            [self.dataArrayM addObjectsFromArray:result];
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
/**查询到置顶的帖子*/
- (void)requestmyzonegetupzone{
    [MyCircleCenterRequestDatas myzonegetupzonerequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.zhiDingdataArrayM = result;
        [self.myTableView reloadData];
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myTableView.mj_header endRefreshing];
    }];
}


/**新增收藏*/
- (void)requestsyscollect:(NSIndexPath*)indexPath{
    MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];

    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //收藏id，有课时id用课时id，没有用课程id
    para[@"collectId"] = [NSString stringWithFormat:@"%d",model.idx];
    para[@"type"] = @"4"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    para[@"delFlag"] = @"1";
    para[@"userId"] = @"1";
    para[@"id"] = @"1";

    [LaborCenterRequestDatas syscollectrequestDataWithparameters:para success:^(id  _Nonnull result) {
       [self requestmyzonepage];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**删除收藏*/
- (void)requestsyscollectmycollectdele:(NSIndexPath*)indexPath{
    MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];

    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //收藏id，有课时id用课时id，没有用课程id
    para[@"collectId"] = [NSString stringWithFormat:@"%d",model.idx];
    para[@"type"] = @"4"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LaborCenterRequestDatas syscollectmycollectdelerequestDataWithparameters:para success:^(id  _Nonnull result) {
        [self requestmyzonepage];

    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**收藏状态*/
- (void)requestsyscollectmycollectstatus{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //收藏id，有课时id用课时id，没有用课程id
//    para[@"collectId"] = [NSString stringWithFormat:@"%d",self.model.idx];
//    para[@"type"] = @"4"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈

    [LaborCenterRequestDatas syscollectmycollectstatusrequestDataWithparameters:para success:^(id  _Nonnull result) {
        [self requestmyzonepage];
//        if ([result[@"data"] boolValue] == YES) {
//            self.collectionButton.selected = YES;
//        }else{
//            self.collectionButton.selected = NO;
//        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**新增点赞表*/
- (void)requestsysuprequest:(NSIndexPath*)indexPath{
     MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
      //收藏id，有课时id用课时id，没有用课程id
      para[@"upId"] = [NSString stringWithFormat:@"%d",model.idx];
      para[@"type"] = @"4"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LearningCenterRequest sysuprequestDataWithparameters:para success:^(id  _Nonnull result) {
        [self requestmyzonepage];
    } failure:^(NSError * _Nonnull error) {
        
    }];


}

/**取消点赞*/
- (void)requestsysupmycollectdele:(NSIndexPath*)indexPath{
     MyCircleCenterHomeModel *model = self.dataArrayM[indexPath.row];
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
      //收藏id，有课时id用课时id，没有用课程id
      para[@"upId"] = [NSString stringWithFormat:@"%d",model.idx];
      para[@"type"] = @"4"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LearningCenterRequest sysupmycollectdelerequestDataWithparameters:para success:^(id  _Nonnull result) {
        [self requestmyzonepage];
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
/**点赞状态*/
- (void)requestsysupmycollectstatusrequestDataWithparameters{
//      NSMutableDictionary *para = [NSMutableDictionary dictionary];
//      //收藏id，有课时id用课时id，没有用课程id
//      para[@"upId"] = [NSString stringWithFormat:@"%d",self.model.idx];
//      para[@"type"] = @"4"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
//    [LearningCenterRequest sysupmycollectstatusrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.giveaLikeButton.userInteractionEnabled = YES;
//
//        if ([result[@"data"] boolValue] == YES) {
//            self.giveaLikeButton.selected = YES;
//        }else{
//            self.giveaLikeButton.selected = NO;
//        }
//    } failure:^(NSError * _Nonnull error) {
//        self.collectionButton.userInteractionEnabled = YES;
//
//    }];


}

/**热度*/
- (void)requestmyzonegetFire{
    [MyCircleCenterRequestDatas myzonegetFirerequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.Fire = [result[@"data"] intValue];
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
