//
//  TeacherLectureHallListViewController.m
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "TeacherLectureHallListViewController.h"
#import "FirstTeacherLectureHallListCollectionViewCell.h"
#import "LaborCenterRequestDatas.h"
#import "FirstFrameOfTheVideo.h"
#import "TeacherLectureHallModel.h"
#import "LearningCenterDetails2ViewController.h"
#import "LaborCenterLessonDetailsViewController.h"
#import "TeacherLectureHallListSModel.h"

@interface TeacherLectureHallListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;
/**页码*/
@property(nonatomic,assign)NSInteger tags;
@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation TeacherLectureHallListViewController


//MARK: - Life Cycle - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.titieTemp != nil) {
        self.myTitleLabel.text = self.titieTemp;
    }
    self.array = [NSMutableArray array];
    self.tags = 1;
    [self initCollectionView];
    [self requestTeacherLectureHall];
    self.fd_prefersNavigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//MARK: - Initalization - 初始化
- (void)initCollectionView{
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 最小行间距，默认是0
    //    layout.minimumLineSpacing = 15.0;
        // 最小左右间距，默认是10
    //    layout.minimumInteritemSpacing = 15.0;
        // 区域内间距，默认是 UIEdgeInsetsMake(0, 0, 0, 0)
    //    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        layout.sectionInset = UIEdgeInsetsMake(0.0, 15, 0.0,15);
        layout.itemSize = CGSizeMake((SCR_W-40)/2, (SCR_W-40)/2+5);
        self.myCollectionView.delegate = self;
        self.myCollectionView.dataSource = self;
//        self.myCollectionView.bounces = NO;
        self.myCollectionView.collectionViewLayout = layout;
        [self.myCollectionView registerNib:[UINib nibWithNibName:@"FirstTeacherLectureHallListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FirstTeacherLectureHallListCollectionViewCellID"];
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tags = 1;
        [self requestTeacherLectureHall];

        }];
    self.myCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        self.tags++;
        [self requestTeacherLectureHall];

    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.array.count;
    }else {
       return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstTeacherLectureHallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstTeacherLectureHallListCollectionViewCellID" forIndexPath:indexPath];
    [cell reloadData:self.array[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TeacherLectureHallListSModel *modelss = self.array[indexPath.row];
    LaborCenterLessonDetailsViewController *LCvc = [[LaborCenterLessonDetailsViewController alloc]init];
//    LCvc.model = self.array[indexPath.row];
//    LCvc.array = self.array;
    LCvc.idx = [NSString stringWithFormat:@"%d",modelss.idx];
    LCvc.courseId = [NSString stringWithFormat:@"%d",modelss.courseId];

    [self.navigationController pushViewController:LCvc animated:YES];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = ((SCR_W-20)/3);
//    CGSize size = CGSizeMake(width, width);
//    return size;
//}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader) {
//        CT_MyCollectionReusableView *aView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CT_MyCollectionReusableView" forIndexPath:indexPath];
//        if (indexPath.section == 0) {
//            aView.titleLbl.text = @"生活类贴纸展示";
//        } else {
//            aView.titleLbl.text = @"美食类贴纸展示";
//        }
//        aView.titleLbl.textColor = [UIColor whiteColor];
//        return aView;
//    }
//    return nil;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return CGSizeMake(SCR_W, 40);
//    }else{
//        return CGSizeMake(SCR_W, 40);
//    }
//}
//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: - Utility - 多用途(功能)方法
//MARK: - Network request - 网络请求
/**名师讲堂-<课时列表>*/

- (void)requestTeacherLectureHall{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"courseId"] = [NSString stringWithFormat:@"%ld",self.courseId];
    para[@"current"] = [NSString stringWithFormat:@"%ld",self.tags];
    
    [LaborCenterRequestDatas TeacherLectureHallrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.array = [NSArray array];
//        self.array = result;
//        [self.myCollectionView reloadData];
        
        if (self.tags == 1) {
            self.array = result;
        }else{
            [self.array addObjectsFromArray:result];
        }
        [self.myCollectionView reloadData];
        //手动结束刷新状态
        [self.myCollectionView.mj_header endRefreshing];
        [self.myCollectionView.mj_footer endRefreshing];
        NSArray *arrayTemp = result;
        if (arrayTemp.count<10) {
            [self.myCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError * _Nonnull error) {
        //手动结束刷新状态
        [self.myCollectionView.mj_header endRefreshing];
        [self.myCollectionView.mj_footer endRefreshing];
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
