//
//  TabBarViewController.m
//  com.tkhy.driver
//
//  Created by 狍子 on 2020/8/3.
//  Copyright © 2020 TK. All rights reserved.
//

#import "TabBarViewController.h"
#import "LaborCenterHomeViewController.h"
#import "LearningCenterHomeViewController.h"
#import "MyCircleCenterHomeViewController.h"
#import "PersonalCenterHomeViewController.h"

@interface TabBarViewController ()
@property (nonatomic, strong) LaborCenterHomeViewController *oneVC;
@property (nonatomic, strong) LearningCenterHomeViewController *twoVC;
@property (nonatomic, strong) MyCircleCenterHomeViewController *threeVC;
@property (nonatomic, strong) PersonalCenterHomeViewController *fourVC;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self InitView];
    
    self.tabBar.tintColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
}

- (void)InitView
{
//    [self setHidesBottomBarWhenPushed:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"首页", @"学习",@"圈子", @"我的"];
    NSArray *images = @[@"ic_index_home1", @"ic_index_study1",@"ic_index_quan1",  @"ic_index_my1"];
    NSArray *selectedImages = @[@"ic_index_home2", @"ic_index_study2",@"ic_index_quan2",@"ic_index_my2"];
    LaborCenterHomeViewController * oneVc = [[LaborCenterHomeViewController alloc] init];
    self.oneVC = oneVc;
    LearningCenterHomeViewController * twoVc = [[LearningCenterHomeViewController alloc] init];
    self.twoVC = twoVc;
    MyCircleCenterHomeViewController * threeVc = [[MyCircleCenterHomeViewController alloc] init];
    self.threeVC = threeVc;
    PersonalCenterHomeViewController * fourVC = [[PersonalCenterHomeViewController alloc] init];
    self.fourVC = fourVC;
    NSArray *viewControllers = @[oneVc, twoVc, threeVc, fourVC];
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *childVc = viewControllers[i];
        [self setVC:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)setVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:0/255.0 green:187/255.0 blue:145/255.0 alpha:1];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [VC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
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