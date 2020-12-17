//
//  LearningCenterDetails1NewsViewController.m
//  labor
//
//  Created by 狍子 on 2020/11/4.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "LearningCenterDetails1NewsViewController.h"
#import "FirstLearningCenterDetails1NewsTableViewCell.h"
#import "ThirdLearningCenterDetails1TableViewCell.h"
#import "ZeropinlunTableViewCell.h"
#import "LaborCenterRequestDatas.h"
#import "LearningCenterRequest.h"
#import "JLTextView.h"
#import <IQKeyboardManager.h>
#import "NoNetWorkView.h"
#import "LearningCenterDetailsModel.h"
#import "MyTimeInterval.h"
#import "UserInfoManager.h"
#import <WebKit/WebKit.h>
#import "FivethLearningCenterDetails1TableViewCell.h"
#import "SixLearningCenterDetails1TableViewCell.h"
#import "LearningCenterDetailsModel.h"
#import "Rottie1View.h"

@interface LearningCenterDetails1NewsViewController ()<UITableViewDelegate,UITableViewDataSource,NoNetWorkViewDelegate,WKNavigationDelegate,WKUIDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
/**收藏button*/
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIView *TextViewBottomView;
@property (nonatomic, strong) WKWebView *wk;

@property (weak, nonatomic) JLTextView *textView;
@property (weak, nonatomic) UIView *commentContentView;
/**评论列表*/
@property (nonatomic,strong)NSArray *CommentVoListArray;
/**无网络*/
@property(nonatomic, strong)NoNetWorkView *nonetView;
/**新闻标题*/
@property (nonatomic, strong) NSString *titles;
@property (nonatomic,strong)LOTAnimationView *lotanimation;
/**来源*/
@property (nonatomic, strong) NSString *laiyuanstr;
/**时间*/
@property (nonatomic, strong) NSString *timestr;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, assign) CGFloat wkheight;
@property (nonatomic, assign) int temp;
@property (nonatomic, strong) LearningCenterDetailsModel *model;
@property (nonatomic,strong)Rottie1View *rottieView;
@property (nonatomic,strong)LOTAnimationView *animatedView;
@end

@implementation LearningCenterDetails1NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initmyTableView];
    self.temp = 0;
    //加入代码
//    self.navigationController.navigationBar.translucent = NO;
    self.wkheight = 1;
//    [self setShowAnimation:YES];
    self.myTableView.hidden = YES;

    [self addKeyBoardObservers];
    [self requestmobileIndexinformationDetails];
    [self requestmobileIndexgetCommentVoList];
    [self requestsyscollectmycollectstatus];
    [self requestsysupmycollectstatusrequestDataWithparameters];
    [self requestsysintegralsaveIntegralFORMOV];
    
    self.fd_prefersNavigationBarHidden = YES;
    if ([[UserInfoManager getAFNetworkReachabilityStatus] isEqualToString:@"viaWWAN"]||[[UserInfoManager getAFNetworkReachabilityStatus] isEqualToString:@"viaWiFi"]) {
     //有网络
    }else{
       //无网络
        [self.view addSubview:self.nonetView];
        self.nonetView.hidden = NO;
    }
}

- (IBAction)BaButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//MARK: - Life Cycle - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
}


- (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
// [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES; // 控制是否显示键盘上的工具条

 }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_textView resignFirstResponder];
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
//        _rottieView.delegate = self;
////        [_carImmediatelyView settingUI];
        [self.view addSubview:_rottieView];
    }
    return _rottieView;
}
-(void)addKeyBoardObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

}
-(void)keyboardWillShow:(NSNotification *)sender
{
    CGRect rect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    

        CGRect frame = self.commentContentView.frame;
        frame.origin.y = SCR_H-rect.size.height-104;
        
        [UIView animateWithDuration:duration animations:^{
            self.commentContentView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
}
-(void)keyboardWillHide:(NSNotification *)sender
{
    NSTimeInterval duration = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    CGRect frame = self.commentContentView.frame;
    frame.origin.y = SCR_H;
    
    [UIView animateWithDuration:duration animations:^{
        self.commentContentView.frame = frame;
    } completion:^(BOOL finished) {
        [self.commentContentView removeFromSuperview];
    }];
    
}


-(void)showTextView
{
    JLTextView *textView = [[JLTextView alloc] initWithFrame:CGRectMake(15, 12, SCR_W-15-90, 80)];
    
    textView.font = [UIFont systemFontOfSize:15.f];
//    textView.textColor = [UIColor colorWithHexString:@"2f2f2f"];
    textView.jlLineHeight = 20.f;
    textView.middleWhenMoreLineHeight = YES;

    textView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    textView.layer.cornerRadius = 4.f;
    textView.placeholder = NSLocalizedString(@"发布评论", nil);
    textView.maxTextLength = 100;
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeySend;
    self.textView = textView;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_W-80, 35, 70, 30)];
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    btn.backgroundColor = [UIColor colorWithRed:80/255.0 green:220/255.0 blue:142/255.0 alpha:1];
    [btn setTitle:NSLocalizedString(@"发布", nil) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//    [btn setTitleColor:[UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1] forState:UIControlStateDisabled];
    btn.enabled = NO;
    [btn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, 1)];
    line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCR_H, SCR_W, 80+24)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    [contentView addSubview:line];
    [contentView addSubview:btn];
    [contentView addSubview:textView];
    [self.view addSubview:contentView];
    _commentContentView = contentView;
    
    self.textView.textLengthHandler = ^(JLTextView * _Nonnull view, NSUInteger curryLength) {
        if (curryLength>0) {
            btn.enabled = YES;
        }else{
            btn.enabled = NO;
        }
    };
    [textView becomeFirstResponder];
}
-(void)commentBtnClick:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.userInteractionEnabled = YES;
    });
    
    [_textView resignFirstResponder];
    
//    NSString *comment = _textView.text;
    [self requestmobileIndexsubmitComment];
 
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self commentBtnClick:nil];
        return NO;
    }
    return YES;
}


- (WKWebView *)wk{
    if (!_wk) {
   
            NSMutableString *jScript = [[NSMutableString alloc]initWithString:@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}"];
    
            //以下代码适配大小


            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:[NSString stringWithFormat:@"%@",jScript] injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
            [wkUController addUserScript:wkUScript];

            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.allowsInlineMediaPlayback = YES;

            wkWebConfig.userContentController = wkUController;
//        _wk = [[WKWebView alloc]init];
//        _wk.configuration = wkWebConfig;
        //    _wk = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, self.bottomView.bounds.size.height)];
        _wk = [[WKWebView alloc] initWithFrame:CGRectMake(10, 0, SCR_W-20, self.wkheight) configuration:wkWebConfig];
        //    [self.view addSubview:titles];
//            [cell.bottomView addSubview:self.wk];
        _wk.UIDelegate = self;
        _wk.navigationDelegate = self;
        _wk.scrollView.scrollEnabled = NO;//设置webview不可滚动，让tableview本身滚动即可
        
//        [_wk loadHTMLString:self.body baseURL:nil];
//        [_wk loadHTMLString:[NSString stringWithFormat:@"%@",self.body] baseURL:nil];

//        self.wk.hidden = YES;



    }
    return _wk;
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");

//    NSString *fileUrl = [[NSBundle mainBundle] pathForResource:@"SOURCEHANSERIFCN-MEDIUM" ofType:@"OTF"];
//    NSData *fileData = [NSData dataWithContentsOfFile:fileUrl];
//    NSString *boldFont = [fileData base64EncodedStringWithOptions:0];
//    NSMutableString *javascript = [NSMutableString string];
//    [javascript appendString:[NSString stringWithFormat:@"\
//                                  var boldcss = '@font-face { font-family: \"%@\"; src: url(data:font/ttf;base64,%@) format(\"truetype\");} *{font-family: \"%@\" !important;}'; \
//                                  var head = document.getElementsByTagName('head')[0], \
//                                  style = document.createElement('style'); \
//                                  style.type = 'text/css'; \
//                                  style.innerHTML = boldcss; \
//                                  head.appendChild(style);",@"SOURCEHANSERIFCN",boldFont,@"SOURCEHANSERIFCN"]];
//     [webView evaluateJavaScript:javascript completionHandler:nil];

    //这个方法也可以计算出webView滚动视图滚动的高度
    [webView evaluateJavaScript:@"document.body.scrollWidth"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        
        NSLog(@"scrollWidth高度：%.2f",[result floatValue]);
        CGFloat ratio =  CGRectGetWidth(webView.frame) /[result floatValue];
        
    [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
            NSLog(@"scrollHeight高度：%.2f",[result floatValue]);
            NSLog(@"scrollHeight计算高度：%.2f",[result floatValue]*ratio);
            CGFloat newHeight = [result floatValue]*ratio;
        self.wkheight = newHeight;
//        self.wk.frame = CGRectMake(0, 0, SCR_W, newHeight);
        if (self.temp ==0) {
    
         
                self.wk.hidden = NO;
        //        [self setShowAnimation:NO];
//                [self.wk loadHTMLString:self.body baseURL:nil];

                [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.myTableView.hidden = NO;

            });
        }
        self.temp = 1;
       


//            [self resetWebViewFrameWithHeight:newHeight];
//
//            //KVO监听网页内容高度变化
//            if (newHeight < CGRectGetHeight(self.view.frame)) {
//                //如果webView此时还不是满屏，就需要监听webView的变化  添加监听来动态监听内容视图的滚动区域大小
//                [self.wbScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//            }
        }];
        
    }];
}
/**无网络页面*/
- (NoNetWorkView *)nonetView{
    if (!_nonetView) {
    _nonetView = [[NSBundle mainBundle] loadNibNamed:@"NoNetWorkView" owner:self options:nil][0];
        _nonetView.frame = self.view.bounds;
        [_nonetView setUI];
        _nonetView.delegate = self;
//        [self.playBottomView addSubview:_playEndrView];
    }
    return _nonetView;
}
- (void)initmyTableView{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.bounces = NO;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
//    self.myTableView.estimatedRowHeight = 150.0;

    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstLearningCenterDetails1NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FirstLearningCenterDetails1NewsTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ThirdLearningCenterDetails1TableViewCell" bundle:nil] forCellReuseIdentifier:@"ThirdLearningCenterDetails1TableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"ZeropinlunTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZeropinlunTableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FivethLearningCenterDetails1TableViewCell" bundle:nil] forCellReuseIdentifier:@"FivethLearningCenterDetails1TableViewCellID"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SixLearningCenterDetails1TableViewCell" bundle:nil] forCellReuseIdentifier:@"SixLearningCenterDetails1TableViewCellID"];
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.000001)];
    self.myTableView.tableHeaderView = vi;
    
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        return 50;
//    }else if(indexPath.section == 1) {
//        return 25;
//    }else if(indexPath.section == 2) {
//        //
//        NSLog(@"%f",self.wkheight);
//        return self.wkheight;
//    }else{
//        return 95;
//    }
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return UITableViewAutomaticDimension;

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
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
            return 0;
            break;
        case 3:
            if (self.CommentVoListArray.count==0){
                return 1;
                break;

            }else{
                return  self.CommentVoListArray.count;
                break;

            }
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return self.wkheight;
    }
    if (section == 3) {
        return 45;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        if (self.body!= nil) {
            UIView *viwk = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCR_W-30, self.wkheight)];
            viwk.backgroundColor = [UIColor whiteColor];
           self.wk.frame = CGRectMake(10, 0, SCR_W-20, self.wkheight);
//           [self.wk loadHTMLString:self.body baseURL:nil];
            
            [_wk loadHTMLString:self.body baseURL:nil];

            [viwk addSubview:self.wk];

            return viwk;
        }
    }
    if (section == 3) {
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 35)];
        vi.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];

        [tableView addSubview:vi];
        UIView *vibg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_W, 10)];
        vibg.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];

        [vi addSubview:vibg];

        //线
        UIView *linevibg = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCR_W, 0.5)];
        linevibg.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];

        [vi addSubview:linevibg];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCR_W, 35)];
//        lb.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"评论" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        lb.attributedText = attributedString;
        [vi addSubview:lb];
        return vi;
    }else{
        return nil;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {

            FivethLearningCenterDetails1TableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FivethLearningCenterDetails1TableViewCellID"];
        if (self.titles != nil) {
            [cell reloadData:self.titles];

        }
            return cell;
  

    }else if(indexPath.section == 1){
        
        SixLearningCenterDetails1TableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"SixLearningCenterDetails1TableViewCellID"];
        if (self.laiyuanstr != nil) {
            cell.laiyuanLabel.text = self.laiyuanstr;

        }
        if (self.timestr != nil) {
            cell.timeLabel.text = [MyTimeInterval IntervalStringToIneedDateString:self.timestr type:@"YYYY-MM-dd"];

        }
        return cell;
    }else if (indexPath.section == 2) {

        FirstLearningCenterDetails1NewsTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"FirstLearningCenterDetails1NewsTableViewCellID"];

            return cell;
  

    }else{
        if (self.CommentVoListArray.count==0){
            //评论
            ZeropinlunTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ZeropinlunTableViewCellID"];
            return cell;

        }else{
            //评论
           ThirdLearningCenterDetails1TableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ThirdLearningCenterDetails1TableViewCellID"];
            [cell reloadData:self.CommentVoListArray[indexPath.row]];
            return cell;

        }

    }
}

//MARK: - SubViews - 子视图
//MARK: - Button Action - 点击事件
/**无网络下返回*/
- (void)NoNetWorkViewBackButtonActiondelegate:(NoNetWorkView*)view{
    [self.navigationController popViewControllerAnimated:YES];
}
/**再试一下*/
- (void)NoNetWorkViewAgainButtonActiondelegate:(NoNetWorkView*)view{
    [self requestmobileIndexinformationDetails];
    [self requestmobileIndexgetCommentVoList];
    [self requestsyscollectmycollectstatus];
    [self requestsysupmycollectstatusrequestDataWithparameters];
    [self requestsysintegralsaveIntegralFORMOV];
}


- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)showCommentViewBtnAction:(UIButton*)sender {
    //    AVUser *currentUser =[AVUser currentUser];
    //    if (!currentUser)
    //    {
    //        //登录
    //        RRBaseNavigationController *navi = [[UIStoryboard storyboardWithName:StoryBoard_Login bundle:nil] instantiateInitialViewController];
    //        [self presentViewController:navi animated:YES completion:nil];
    //
    //        return;
    //    }
    [self showTextView];

}
/**点赞*/
- (IBAction)giveaLikeButtonAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [self requestsysuprequest];
    }else{
        [self requestsysupmycollectdele];
    }
}
- (IBAction)shareButtonAction:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"开发中，敬请期待"];

}
/**收藏button*/
- (IBAction)collectButtonAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [self requestsyscollect];
    }else{
        [self requestsyscollectmycollectdele];
    }
}
    
//MARK: - Utility - 多用途(功能)方法

//MARK: - Network request - 网络请求
/**新闻详情*/
- (void)requestmobileIndexinformationDetails{
    NSLog(@"加载没有完成0");



     NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"informationId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];

    [LearningCenterRequest mobileIndexinformationDetailsrequestDataWithparameters:para success:^(id  _Nonnull result) {
        NSDictionary *dict = [NSDictionary dictionary];
        dict = result;

//        self.dataArray = [LearningCenterDetailsModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"list"]]; //数组;
        NSDictionary *dict1 = dict[@"data"];

        if ([dict1.allKeys containsObject:@"informationVo"]) {
            NSDictionary *dict2 = dict1[@"informationVo"];
            if ([dict2.allKeys containsObject:@"body"]) {
//                [self loadData:dict2[@"body"]];
                self.body = dict2[@"body"];
            }
            if ([dict2.allKeys containsObject:@"title"]) {
                self.titles = dict2[@"title"];
            }
            if ([dict2.allKeys containsObject:@"source"]) {
                self.laiyuanstr = dict2[@"source"];
            }
            if ([dict2.allKeys containsObject:@"createTime"]) {
                self.timestr = dict2[@"createTime"];
            }
        }
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**评论列表*/
- (void)requestmobileIndexgetCommentVoList{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"informationId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];

    [LearningCenterRequest mobileIndexgetCommentVoListrequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.CommentVoListArray = result;
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**提交评论*/
- (void)requestmobileIndexsubmitComment{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];

    para[@"body"] = _textView.text;
    para[@"informationId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];

    [LearningCenterRequest mobileIndexsubmitCommentrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.dataArray = result;
//        [self.myTableView reloadData];
        [self requestmobileIndexgetCommentVoList];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**新增收藏*/
- (void)requestsyscollect{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //收藏id，有课时id用课时id，没有用课程id
    para[@"collectId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];
    para[@"type"] = @"1"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    para[@"delFlag"] = @"1";
    para[@"userId"] = @"1";
    para[@"id"] = @"1";

    [LaborCenterRequestDatas syscollectrequestDataWithparameters:para success:^(id  _Nonnull result) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**删除收藏*/
- (void)requestsyscollectmycollectdele{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //收藏id，有课时id用课时id，没有用课程id
    para[@"collectId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];
    para[@"type"] = @"1"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LaborCenterRequestDatas syscollectmycollectdelerequestDataWithparameters:para success:^(id  _Nonnull result) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**收藏状态*/
- (void)requestsyscollectmycollectstatus{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //收藏id，有课时id用课时id，没有用课程id
    para[@"collectId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];
    para[@"type"] = @"1"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈

    [LaborCenterRequestDatas syscollectmycollectstatusrequestDataWithparameters:para success:^(id  _Nonnull result) {
        self.collectionButton.userInteractionEnabled = YES;

        if ([result[@"data"] boolValue] == YES) {
            self.collectionButton.selected = YES;
        }else{
            self.collectionButton.selected = NO;
        }
    } failure:^(NSError * _Nonnull error) {
        self.collectionButton.userInteractionEnabled = YES;

    }];
}

/**新增点赞表*/
- (void)requestsysuprequest{
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
      //收藏id，有课时id用课时id，没有用课程id
    para[@"upId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];
      para[@"type"] = @"1"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LearningCenterRequest sysuprequestDataWithparameters:para success:^(id  _Nonnull result) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];


}

/**取消点赞*/
- (void)requestsysupmycollectdele{
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
      //收藏id，有课时id用课时id，没有用课程id
    para[@"upId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];
      para[@"type"] = @"1"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LearningCenterRequest sysupmycollectdelerequestDataWithparameters:para success:^(id  _Nonnull result) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];


}
/**点赞状态*/
- (void)requestsysupmycollectstatusrequestDataWithparameters{
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
      //收藏id，有课时id用课时id，没有用课程id
    para[@"upId"] = [NSString stringWithFormat:@"%ld",(long)self.informationId];
      para[@"type"] = @"1"; //收藏类型1：新闻 2：课时 3：活动 4：劳动圈
    [LearningCenterRequest sysupmycollectstatusrequestDataWithparameters:para success:^(id  _Nonnull result) {
//        self.giveaLikeButton.userInteractionEnabled = YES;
//
//        if ([result[@"data"] boolValue] == YES) {
//            self.giveaLikeButton.selected = YES;
//        }else{
//            self.giveaLikeButton.selected = NO;
//        }
    } failure:^(NSError * _Nonnull error) {
        self.collectionButton.userInteractionEnabled = YES;

    }];


}

/**加积分*/
- (void)requestsysintegralsaveIntegralFORMOV{
    //type：0-课时 1-签到 2-新闻 3-活动-4-劳动圈
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"type"] = @"2";
    para[@"forId"] = [NSString stringWithFormat:@"%ld",self.informationId];
    [LearningCenterRequest sysintegralsaveIntegralFORMOVrequestDataWithparameters:para success:^(id  _Nonnull result) {
        
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
