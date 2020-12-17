//
//  DateOfBirthViewController.m
//  labor
//
//  Created by 狍子 on 2020/9/17.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "DateOfBirthViewController.h"
#import "PersonalCenterRequestDatas.h"

@interface DateOfBirthViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *mydataPicker;
@property (nonatomic,strong)NSString *dateStr;
@end

@implementation DateOfBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mydataPicker addTarget:self action:@selector(dataValueChange:) forControlEvents:UIControlEventValueChanged];
    NSDate* dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    // 格式化时间
       NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
       formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
       [formatter setDateStyle:NSDateFormatterMediumStyle];
       [formatter setTimeStyle:NSDateFormatterShortStyle];
       [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
       
       NSString* dateString = [formatter stringFromDate:dateNow];
    self.dateStr = dateString;
    self.fd_prefersNavigationBarHidden = YES;

}
- (void)dataValueChange:(UIDatePicker*)sender{
    NSDate *date = sender.date;
    // 格式化时间
       NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
       formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
       [formatter setDateStyle:NSDateFormatterMediumStyle];
       [formatter setTimeStyle:NSDateFormatterShortStyle];
       [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
       
       NSString* dateString = [formatter stringFromDate:date];
    self.dateStr = dateString;
    NSLog(@"%@",dateString);
}
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/**确定*/
- (IBAction)submitButtonAction:(id)sender {

    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    para[@"avatar"] = self.model.avatar;
    para[@"birthday"] = self.dateStr;
    para[@"deptId"] = [NSString stringWithFormat:@"%d",self.model.deptId];

    para[@"partyNumber"] = [NSString stringWithFormat:@"%d",self.model.partyNumber];
    para[@"phone"] = [NSString stringWithFormat:@"%d",self.model.phone];
    para[@"realName"] = self.model.realName;
    para[@"sex"] = self.model.sex;
    para[@"username"] = self.model.username;
    [self requestmobileUsermyInfo:para];

}

/**个人信息修改*/
- (void)requestmobileUsermyInfo:(NSMutableDictionary*)para{

    [PersonalCenterRequestDatas mobileUsermyInforequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.resultBlock(self.dateStr);
        [self.navigationController popViewControllerAnimated:YES];
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
