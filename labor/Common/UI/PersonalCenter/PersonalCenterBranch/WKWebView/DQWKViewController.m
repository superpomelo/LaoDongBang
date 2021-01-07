//
//  DQWKViewController.m
//  labor
//
//  Created by 狍子 on 2020/9/21.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "DQWKViewController.h"
#import <WebKit/WebKit.h>
#import "LoginRequestDatas.h"

@interface DQWKViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *_wk;
}

@property (weak, nonatomic) IBOutlet UIView *topBottomView;
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *BOTTOMview;
@property (strong,nonatomic) UIProgressView *progressView;
@end

@implementation DQWKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.titleStr != nil) {
        self.myTitleLabel.text = self.titleStr;
    }
    [self requestxieyi];
    //加入代码
    self.navigationController.navigationBar.translucent = NO;
    //初始化


//    meta.setAttribute('content', 'width=device-width');
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";


    //以下代码适配大小
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
//    _wk = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, self.bottomView.bounds.size.height)];
    _wk = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-64) configuration:wkWebConfig];
//    [self.view addSubview:titles];
    [self.bottomView addSubview:_wk];
    
     //进度条
    self.progressView = [[UIProgressView  alloc]initWithFrame:CGRectMake(0, 43.5, SCR_W, 0.5)];
      self.progressView.progressTintColor = [UIColor greenColor];
      [self.topBottomView addSubview:self.progressView];

      // 给webview添加监听
      [_wk addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
//    [titles loadHTMLString:@"HTML" baseURL:[NSURL URLWithString:self.urlstring]];
    
//    _wk = [[WKWebView alloc]initWithFrame:self.BOTTOMview.bounds];
//    _wk.UIDelegate = self;
//    _wk.navigationDelegate = self;
//    [self.bottomView addSubview:_wk];
    [self loadData];
//    self.backButton.hidden = YES;
    self.fd_prefersNavigationBarHidden = YES;

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == _wk) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_wk.estimatedProgress animated:YES];
        if (_wk.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.backButton.hidden = !self.backButton.hidden;
}
- (void)loadData{
    NSURL *url = [NSURL URLWithString:self.urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wk loadRequest:request];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/**用户协议*/
- (void)requestxieyi{
    [LoginRequestDatas yonghuxieyirequestDataWithparameters:nil success:^(id  _Nonnull result) {
        
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
