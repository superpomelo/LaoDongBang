//
//  LaoShiXiangQingViewController.m
//  labor
//
//  Created by 狍子 on 2021/1/6.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "LaoShiXiangQingViewController.h"
#import "FirstLaoShiXiangQingTableViewCell.h"

@interface LaoShiXiangQingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation LaoShiXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
  
    [self initUI];
    [self initmyTableView];
  
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
    self.myTableView.estimatedRowHeight = 100;

//    self.myTableView.bounces = NO;
//    self.myTableView.rowHeight = UITableViewAutomaticDimension;
//    self.myTableView.estimatedRowHeight = 70.0;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstLaoShiXiangQingTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstLaoShiXiangQingTableViewCellID"];
  
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstLaoShiXiangQingTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstLaoShiXiangQingTableViewCellID"];
        if (self.name != nil&&self.body!= nil) {
            [cell reloadData:self.name body:self.body];
        }
    return cell;

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
