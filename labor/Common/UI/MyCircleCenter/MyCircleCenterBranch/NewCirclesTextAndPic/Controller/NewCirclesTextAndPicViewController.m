//
//  NewCirclesTextAndPicViewController.m
//  labor
//
//  Created by 狍子 on 2020/8/25.
//  Copyright © 2020 ZKWQY. All rights reserved.
//  新增文字图片圈子

#import "NewCirclesTextAndPicViewController.h"
#import "FirstNewCirclesTextAndPicTableViewCell.h"
#import "SecondNewCirclesTextAndPicTableViewCell.h"
#import "MyFileRequestDatas.h"
#import "MyCircleCenterRequestDatas.h"
#import "LaborCenterRequestDatas.h"
#import "LearningCenterRequest.h"
#import "FirstFrameOfTheVideo.h"
#import "Rottie1View.h"
#import <Photos/Photos.h>

#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface NewCirclesTextAndPicViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SecondNewCirclesTextAndPicTableViewCellDelegate,FirstNewCirclesTextAndPicTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
/**发布*/
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (nonatomic,strong)NSMutableArray *coverArrayM;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,assign)int picTAG;
/**img/vid*/
@property (nonatomic,strong)NSString *imgorvid;
@property (nonatomic, strong) NSURL *videoPath; //当前拍摄的视频路径
@property (nonatomic,strong)Rottie1View *rottieView;
@property (nonatomic,strong)LOTAnimationView *animatedView;
@end

@implementation NewCirclesTextAndPicViewController

//MARK: - Life Cycle - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.coverArrayM = [NSMutableArray array];
    _picTAG = 1;
    [self initUI];
    [self initmyTableView];
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
        _rottieView.center = self.view.center;
//        _rottieView.delegate = self;
////        [_carImmediatelyView settingUI];
        [self.view addSubview:_rottieView];
    }
    return _rottieView;
}

- (void)initUI{
    self.publishButton.layer.cornerRadius = 30/2;
}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.bounces = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstNewCirclesTextAndPicTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstNewCirclesTextAndPicTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SecondNewCirclesTextAndPicTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondNewCirclesTextAndPicTableViewCellID"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 120;
            break;
        case 1:
                return 300;
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
                return 1;
                break;

        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FirstNewCirclesTextAndPicTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstNewCirclesTextAndPicTableViewCellID"];
        cell.delegate = self;
         return cell;
    }else{
        SecondNewCirclesTextAndPicTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SecondNewCirclesTextAndPicTableViewCellID"];
        cell.delegate = self;
         return cell;
    }

    

}

//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/**发布*/
- (IBAction)publishButtonAction:(id)sender {
    if ([self.imgorvid isEqualToString:@"vid"]) {
        NSData *data = [NSData dataWithContentsOfURL:self.videoPath];
    //    NSString *stringBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"file"] = data;
        [self requestlessonupload:dict];

    }else{
        [self requestmyzone:nil titlepage:nil];

    }

}


//MARK: - Utility - 多用途(功能)方法
/**文本框代理*/
- (void)FirstNewCirclesTextAndPicTableViewCellActiondelegate:(FirstNewCirclesTextAndPicTableViewCell*)cell textview:(UITextView*)textView{
    self.content = textView.text;
}
//选择图片
- (void)chooseImageAction {
    //底部弹出来个actionSheet来选择拍照或者相册选择
    UIAlertController *userIconActionSheet = [UIAlertController alertControllerWithTitle:@"请选择上传类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相册选择
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里加一个判断，是否是来自图片库
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate=self;
            imagePicker.allowsEditing=NO;
//            imagePicker.videoMaximumDuration = 1.0;//视频最长长度
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;//视频质量
          
             //媒体类型：@"public.movie" 为视频  @"public.image" 为图片
             //这里只选择展示视频
            imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.movie",@"public.image", nil];
            imagePicker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;



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
     
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
       
       if ([mediaType isEqualToString:@"public.movie"]){
           //如果是视频
           NSURL *url = info[UIImagePickerControllerMediaURL];//获得视频的URL
           NSLog(@"url %@",url);
//           self.videoUrl = url;
           SecondNewCirclesTextAndPicTableViewCell *cell  = [self.myTableView   cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.myTableView.numberOfSections-1]];
           if (self.picTAG == 1) {
//               NSMutableDictionary *dict = [NSMutableDictionary dictionary];

//               NSData *data = [NSData dataWithContentsOfURL:url];
//               dict[@"file"] = data;
//               [self requestlessonupload:dict];
               if (self.coverArrayM.count>1) {
                   [SVProgressHUD showInfoWithStatus:@"一个圈子中不能同时发布视频和图片，只能选择其中一种"];
               }else{
                   self.videoPath = url;
                   
                   cell.addImageView1.hidden = YES;
                   cell.image1View.image = [FirstFrameOfTheVideo firstFrameWithVideoURL:url size:CGSizeMake(90, 90)];
           //        self.firstImageStr = imageData.base64EncodedString;
                   cell.bottomView2.hidden = YES;
                   cell.layerView.hidden = NO;
                   self.imgorvid = @"vid";
               }


           }else{
               [SVProgressHUD showInfoWithStatus:@"一个圈子中不能同时发布视频和图片，只能选择其中一种"];
           }
       }
    
    if ([mediaType isEqualToString:@"public.image"]){
        //如果是图片
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //   [self.senderBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        //图片在这里压缩一下
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
//    NSString *stringBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
       

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"file"] = imageData;
        
    [self requestinformationuploadImg:dict];
//        NSString *imageBase64 = [imageData base64EncodedString];
    SecondNewCirclesTextAndPicTableViewCell *cell  = [self.myTableView   cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.myTableView.numberOfSections-1]];
    if (self.picTAG == 1) {
        //第一张图片
        cell.addImageView1.hidden = YES;
        cell.image1View.image = image;
//        self.firstImageStr = imageData.base64EncodedString;
        cell.bottomView2.hidden = NO;
        cell.layerView.hidden = YES;

    }else if (self.picTAG == 2) {
               cell.addImageView2.hidden = YES;
                cell.image2View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView3.hidden = NO;
    }else if (self.picTAG == 3) {
               cell.addImageView3.hidden = YES;
                cell.image3View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView4.hidden = NO;
    }else if (self.picTAG == 4) {
               cell.addImageView4.hidden = YES;
                cell.image4View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView5.hidden = NO;
    }else if (self.picTAG == 5) {
               cell.addImageView5.hidden = YES;
                cell.image5View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView6.hidden = NO;
    }else if (self.picTAG == 6) {
               cell.addImageView6.hidden = YES;
                cell.image6View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView7.hidden = NO;
    }else if (self.picTAG == 7) {
               cell.addImageView7.hidden = YES;
                cell.image7View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView8.hidden = NO;
    }else if (self.picTAG == 8) {
               cell.addImageView8.hidden = YES;
                cell.image8View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
                cell.bottomView9.hidden = NO;
    }else if (self.picTAG == 9) {
               cell.addImageView9.hidden = YES;
                cell.image9View.image = image;
        //        self.firstImageStr = imageData.base64EncodedString;
//                cell.bottomView9.hidden = NO;
    }
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
    }

      [self dismissViewControllerAnimated:YES completion:nil];
}



//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**点击图片*/
- (void)SecondNewCirclesTextAndPicTableViewCellButtonActiondelegate:(SecondNewCirclesTextAndPicTableViewCell*)cell button:(UIButton*)sender tag:(int)tag{
    if (tag == 1) {
        self.picTAG = 1;
    }else if (tag == 2) {
        self.picTAG = 2;

    }else if (tag == 3) {
        self.picTAG = 3;

    }else if (tag == 4) {
        self.picTAG = 4;

    }else if (tag == 5) {
        self.picTAG = 5;

    }else if (tag == 6) {
        self.picTAG = 6;

    }else if (tag == 7) {
        self.picTAG = 7;

    }else if (tag == 8) {
        self.picTAG = 8;

    }else if (tag == 9) {
        self.picTAG = 9;

    }
    [self chooseImageAction];
}
//MARK: - Network request - 网络请求

/**视频上传*/
- (void)requestlessonupload:(NSMutableDictionary*)dict{
    [self setShowAnimation:YES];

    self.publishButton.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
    self.publishButton.userInteractionEnabled = NO;
    [MyFileRequestDatas lessonuploadrequestDataWithparameters:dict imageDatas:dict success:^(id  _Nonnull result) {
        [self setShowAnimation:NO];

       self.publishButton.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
        self.publishButton.userInteractionEnabled = YES;
        NSLog(@"我是url=    %@",result);
        //视频

            NSString *http;
            if ([result containsString:@"http"]) {
                http = @"";
                
            }else{
                http = [NSString stringWithFormat:@"%@",VideoHost];
        //        Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VideoHost,model.cover]];

            }
        if (self.picTAG > self.coverArrayM.count) {
           [self.coverArrayM addObject:result];
        }else{
            [self.coverArrayM replaceObjectAtIndex:self.picTAG-1 withObject:result];
        }
          
       

        //压缩系数
//        NSData *imageData = UIImageJPEGRepresentation([FirstFrameOfTheVideo firstFrameWithVideoURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http,result]] size:CGSizeMake(345, 183)], 0.5f);
        
        NSData *imageData = UIImagePNGRepresentation([FirstFrameOfTheVideo firstFrameWithVideoURL:self.videoPath size:CGSizeMake(345, 183)]);
        
//        NSData *imageData = UIImagePNGRepresentation([FirstFrameOfTheVideo firstFrameWithVideoURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http,result]] size:CGSizeMake(345, 183)]);
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];

       dict[@"file"] = imageData;
        if (imageData != nil) {
           
            [self requestlessonupload2:dict cover:nil];

        }else{
            [SVProgressHUD showInfoWithStatus:@"服务器开小差了"];

            NSLog(@"我要崩溃了让开");
        }

    
    } failure:^(NSError * _Nonnull error) {
        self.publishButton.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
        self.publishButton.userInteractionEnabled = NO;
        [self setShowAnimation:NO];

    }];
}
- (void)getVideoImageFromPHAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image))resultBack{
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        UIImage *iamge = result;
        resultBack(iamge);
    }];
}
/**图片上传*/
- (void)requestinformationuploadImg:(NSMutableDictionary*)dict{

    self.publishButton.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
    self.publishButton.userInteractionEnabled = NO;
    [MyFileRequestDatas informationuploadImgrequestDataWithparameters:dict imageDatas:dict success:^(id  _Nonnull result) {
       self.publishButton.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
        self.publishButton.userInteractionEnabled = YES;
        NSLog(@"我是url=    %@",result);
        
        if (self.picTAG > self.coverArrayM.count) {
           [self.coverArrayM addObject:result];
        }else{
            [self.coverArrayM replaceObjectAtIndex:self.picTAG-1 withObject:result];
        }
    } failure:^(NSError * _Nonnull error) {
        self.publishButton.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
        self.publishButton.userInteractionEnabled = NO;
    }];
}

/**封面图上传*/
- (void)requestlessonupload2:(NSMutableDictionary*)dict cover:(NSString*)cover{
    
    self.publishButton.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
    self.publishButton.userInteractionEnabled = NO;
    [MyFileRequestDatas informationuploadImgrequestDataWithparameters:dict imageDatas:dict success:^(id  _Nonnull result) {
       self.publishButton.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
        self.publishButton.userInteractionEnabled = YES;
        NSLog(@"我是url=    %@",result);

        [self requestmyzone:cover titlepage:result];

    } failure:^(NSError * _Nonnull error) {
        self.publishButton.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
        self.publishButton.userInteractionEnabled = NO;

    }];
}
/**新增我的劳动圈*/
- (void)requestmyzone:(NSString*)cover titlepage:(NSString*)titlepage{
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //内容
    para[@"content"] = self.content;
    NSMutableString *strM = [NSMutableString string];
    for (int i=0; i<self.coverArrayM.count; i++) {
        if (i==0) {
            [strM appendString:self.coverArrayM[i]];
        }else{
            [strM appendString:@","];
            [strM appendString:self.coverArrayM[i]];
        }
    }
    //图片
    para[@"cover"] = strM;
    para[@"id"] = @"0";
    para[@"title"] = @"0";
    para[@"createTime"] = nil;
    para[@"updateTime"] = nil;
    para[@"delFlag"] = @"0";
    para[@"tenantId"] = @"0";
    para[@"count"] = @"0";
    para[@"type"] = @"0";
    para[@"userId"] = @"0";
    /**0视频 1-图片 2文本*/
    if (self.coverArrayM.count>0) {
        if ([self.imgorvid isEqualToString:@"vid"]) {
            para[@"imgorvid"] = @"0";
            //视频封面图
            para[@"titlepage"] = titlepage;
        }else{
            para[@"imgorvid"] = @"1";

        }

    }else{
       para[@"imgorvid"] = @"2";

    }
    [MyCircleCenterRequestDatas myzonerequestDataWithparameters:para success:^(id  _Nonnull result) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
//        [self requestsysintegralsaveIntegralFORMOV];
        [self.navigationController popToRootViewControllerAnimated:YES];

    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**加积分*/
- (void)requestsysintegralsaveIntegralFORMOV{
    //type：0-课时 1-签到 2-新闻 3-活动-4-劳动圈
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"type"] = @"4";
//    para[@"forId"] = [NSString stringWithFormat:@"%d",self.model.idx];
    [LearningCenterRequest sysintegralsaveIntegralFORMOVrequestDataWithparameters:para success:^(id  _Nonnull result) {
        [self.navigationController popToRootViewControllerAnimated:YES];

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
