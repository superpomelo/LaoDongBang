//
//  PersonalinformationViewController.m
//  labor
//
//  Created by 狍子 on 2020/8/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "PersonalinformationViewController.h"
#import "FirstPersonalinformationTableViewCell.h"
#import "SecondPersonalinformationTableViewCell.h"
#import "FillInPersonalInformationViewController.h"
#import "SexViewController.h"
#import "DateOfBirthViewController.h"
#import "PersonalCenterHomeModel.h"
#import "MyFileRequestDatas.h"
#import "PersonalCenterRequestDatas.h"
#import "SchoolNameViewController.h"
#import "StudentIdViewController.h"
#import "MobnumberViewController.h"
#import "SchoolNameModel.h"
#import "MyTimeInterval.h"

@interface PersonalinformationViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
   NSArray *_leftInformationArray;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,strong)NSString *avatarStr;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,assign)int deptId;
@property(nonatomic,strong)NSString *realName;

@property(nonatomic,strong)NSArray *schoolArray;
@end

@implementation PersonalinformationViewController

//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   _leftInformationArray = @[@"姓名",@"性别",@"出生日期",@"学校",@"院系",@"班级",@"学号",@"手机号"];
    self.avatarStr = self.model.avatar;
    self.sex = self.model.sex;
    self.birthday = self.model.birthday;
    self.realName = self.model.realName;
    self.deptId = self.model.deptId;
    
    [self initmyTableView];
    self.fd_prefersNavigationBarHidden = YES;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self requestadmindeptgetDeptVoList];
    [self requestmobileUsergetPersonalCenterVo];
}


//MARK: - Initalization - 初始化
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstPersonalinformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstPersonalinformationTableViewCellID"];
     [self.myTableView registerNib:[UINib nibWithNibName:@"SecondPersonalinformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondPersonalinformationTableViewCellID"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return 50;
            break;
            
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _leftInformationArray.count;
            break;

        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstPersonalinformationTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstPersonalinformationTableViewCellID"];
        cell.avatarImageView.hidden = NO;
//        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar]];
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@"touxiangpleasehold"]];
         return cell;
    }else{
        SecondPersonalinformationTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondPersonalinformationTableViewCellID"];
        if (indexPath.row==0) {
            cell.rightLabel.text = self.model.realName;
        }else if (indexPath.row == 1){
            cell.rightLabel.text = self.model.sex;

        }else if (indexPath.row == 2){
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[MyTimeInterval IntervalStringToIneedDateString:self.model.birthday type:@"YYYY-MM-dd"]];

        }else if (indexPath.row == 3){
            if (self.schoolArray.count>0) {
                for (int i=0; i<self.schoolArray.count; i++) {
                    SchoolNameModel *models = self.schoolArray[i];
                    if (models.deptId == self.model.deptId) {
                        cell.rightLabel.text = models.name;

                    }
                }
                
            }

        }else if (indexPath.row == 4){
            if (self.model.departmentName == nil) {
                cell.rightLabel.text = @"*";

            }else{
                cell.rightLabel.text = self.model.departmentName;

            }

        }else if (indexPath.row == 5){
            if (self.model.className == nil) {
                cell.rightLabel.text = @"*";

            }else{
                cell.rightLabel.text = self.model.className;
            }

        }else if (indexPath.row == 6){
            cell.rightLabel.text = [NSString stringWithFormat:@"%d",self.model.partyNumber];

        }else if (indexPath.row == 7){
//            cell.rightLabel.text = [NSString stringWithFormat:@"%d",self.model.phone];
            cell.rightLabel.text = self.model.phone;

        }
        cell.leftLabel.text = _leftInformationArray[indexPath.row];
         return cell;
    }

    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self chooseImageAction];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FillInPersonalInformationViewController *FPvc = [[FillInPersonalInformationViewController alloc]init];
            FPvc.model = self.model;
            FPvc.resultBlock = ^(NSString * _Nonnull realname) {
                self.realName = realname;
                [self.myTableView reloadData];
            };
            [self.navigationController pushViewController:FPvc animated:YES];
        }else if (indexPath.row == 1){
            SexViewController *SXvc = [[SexViewController alloc]init];
            SXvc.resultBlock = ^(NSString * _Nonnull result) {
                NSLog(@"%@",result);
//                self.sex = result;
//                [self.myTableView reloadData];
            };
            SXvc.model = self.model;
            [self.navigationController pushViewController:SXvc animated:YES];

        }else if (indexPath.row == 2){
            
            DateOfBirthViewController *DOvc = [[DateOfBirthViewController alloc]init];
            DOvc.resultBlock = ^(NSString * _Nonnull result) {
                NSLog(@"%@",result);
//                self.birthday = result;
//                [self.myTableView reloadData];
            };
            DOvc.model = self.model;
            [self.navigationController pushViewController:DOvc animated:YES];
        }else if (indexPath.row == 3){
            
//            SchoolNameViewController *SNvc = [[SchoolNameViewController alloc]init];
//            SNvc.model = self.model;
//            SNvc.resultBlock = ^(NSString * _Nonnull school) {
//
//
//            };
//            [self.navigationController pushViewController:SNvc animated:YES];
        }else if (indexPath.row == 6){
            StudentIdViewController *SIvc = [[StudentIdViewController alloc]init];
            SIvc.model = self.model;
            [self.navigationController pushViewController:SIvc animated:YES];
        }else if (indexPath.row == 7){
            MobnumberViewController *MBvc = [[MobnumberViewController alloc]init];
            MBvc.resultBlock = ^(NSString * _Nonnull mob) {
//                self.phone = mob;
//                [self.myTableView reloadData];
            };
            MBvc.model = self.model;
            [self.navigationController pushViewController:MBvc animated:YES];
        }else if (indexPath.row == 6){
            

        }
    }

}


//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//MARK: - Utility - 多用途(功能)方法
//选择图片
- (void)chooseImageAction {
    //底部弹出来个actionSheet来选择拍照或者相册选择
    UIAlertController *userIconActionSheet = [UIAlertController alertControllerWithTitle:@"请选择上传类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相册选择
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里加一个判断，是否是来自图片库
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;            //协议
            imagePicker.allowsEditing = NO;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePicker.modalPresentationStyle = 0;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    //系统相机拍照
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = NO;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.modalPresentationStyle = 0;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [userIconActionSheet addAction:albumAction];
    [userIconActionSheet addAction:photoAction];
    [userIconActionSheet addAction:cancelAction];
    userIconActionSheet.modalPresentationStyle = 0;
    [self presentViewController:userIconActionSheet animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
     UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //图片在这里压缩一下
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"file"] = imageData;
    [self requestinformationuploadImg:dict];

    FirstPersonalinformationTableViewCell *cell  = [self.myTableView   cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.avatarImageView.image = image;
//        NSString *imageBase64 = [imageData base64EncodedString];
//    FirstTKDOrderCenterCompleteDischargeTableViewCell *cell  = [self.myTableView   cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.myTableView.numberOfSections-1]];
//    if (_TAG == 0) {
//        //第一张图片
//        cell.firstImageView.image = image;
////        self.firstImageStr = imageData.base64EncodedString;
//        cell.secondView.hidden = NO;
//
//    }
//    [self requestuploadimage:imageData.base64EncodedString];
    
   //     NSLog(@"%@",imageBase64);
        if (imageData.length/1024 > 1024*20)
        {
    //        mAlertView(@"温馨提示", @"请重新选择一张不超过20M的图片");
        }
        else
        {
    //        _imageType = [NSData typeForImageData:imageData];
    //        _imageBase64 = [imageData base64EncodedString];
        }
      [self dismissViewControllerAnimated:YES completion:nil];
}



//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//MARK: - Network request - 网络请求
/**图片/视频上传*/
- (void)requestinformationuploadImg:(NSMutableDictionary*)dict{
    
//      NSMutableDictionary *para = [NSMutableDictionary dictionary];
//
//    //图片
//      para[@"file"] = str;
  
    [MyFileRequestDatas informationuploadImgrequestDataWithparameters:dict imageDatas:dict success:^(id  _Nonnull result) {
       
        NSLog(@"我是url=    %@",result);
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        para[@"avatar"] = result;
//        para[@"birthday"] = self.model.birthday;
//        para[@"deptId"] = [NSString stringWithFormat:@"%d",self.model.deptId];
//
//        para[@"partyNumber"] = [NSString stringWithFormat:@"%d",self.model.partyNumber];
//        para[@"phone"] = [NSString stringWithFormat:@"%d",self.model.phone];
//        para[@"realName"] = self.model.realName;
//        para[@"sex"] = self.model.sex;
//        para[@"username"] = self.model.username;
        [self requestmobileUseravatar:para];

    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**个人信息修改*/
- (void)requestmobileUsermyInfo:(NSMutableDictionary*)para{

    [PersonalCenterRequestDatas mobileUsermyInforequestDataWithparameters:para success:^(id  _Nonnull result) {
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
}

/**学校列表*/
- (void)requestadmindeptgetDeptVoList{
    [PersonalCenterRequestDatas admindeptgetDeptVoListrequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.schoolArray = result;
        [self.myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**更改头像*/
- (void)requestmobileUseravatar:(NSMutableDictionary*)para{
    [PersonalCenterRequestDatas mobileUseravatarrequestDataWithparameters:para success:^(id  _Nonnull result) {
        [self requestmobileUsergetPersonalCenterVo];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**个人资料*/
- (void)requestmobileUsergetPersonalCenterVo{
    [PersonalCenterRequestDatas mobileUsergetPersonalCenterVorequestDataWithparameters:nil success:^(id  _Nonnull result) {
        self.model = result;
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
