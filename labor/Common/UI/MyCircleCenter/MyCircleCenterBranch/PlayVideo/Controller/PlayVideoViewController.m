//
//  PlayVideoViewController.m
//  labor
//
//  Created by 狍子 on 2020/9/22.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <SJUIKit/NSAttributedString+SJMake.h>

//#import "SJCustomControlLayerViewController.h"
//static SJEdgeControlButtonItemTag SJTestEdgeControlButtonItemTag = 101;
//static SJControlLayerIdentifier SJTestControlLayerIdentifier = 101;
@interface PlayVideoViewController ()
//@property (nonatomic, strong) UIImageView *preview1;
@property (weak, nonatomic) IBOutlet UIView *navBottomView;
@property (weak, nonatomic) IBOutlet UIView *topBottomView;

@property (nonatomic, strong) SJVideoPlayer *player;

@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    self.navBottomView.hidden = YES;
    self.topBottomView.hidden = YES;
    self.fd_prefersNavigationBarHidden = YES;

}

///
/// 添加控制层到切换器中
///     只需添加一次, 之后直接切换即可.
///
//- (void)_addCustomControlLayerToSwitcher {
//    __weak typeof(self) _self = self;
//    [_player.switcher addControlLayerForIdentifier:SJTestControlLayerIdentifier lazyLoading:^id<SJControlLayer> _Nonnull(SJControlLayerIdentifier identifier) {
//        __strong typeof(_self) self = _self;
//        if ( !self ) return nil;
//        SJCustomControlLayerViewController *vc = SJCustomControlLayerViewController.new;
//        vc.delegate = self;
//        return vc;
//    }];
//}
//
/////
///// 切换控制层
/////
//- (void)switchControlLayer {
//    if ( _player.isFullScreen == NO ) {
//        [_player rotate:SJOrientation_LandscapeLeft animated:YES completion:^(SJBaseVideoPlayer * _Nonnull player) {
//           [player.switcher switchControlLayerForIdentitfier:SJTestControlLayerIdentifier];
//        }];
//    }
//    else {
//        [self.player.switcher switchControlLayerForIdentitfier:SJTestControlLayerIdentifier];
//    }
//}
//
/////
///// 点击空白区域, 切换回旧控制层
/////
//- (void)tappedBlankAreaOnTheControlLayer:(id<SJControlLayer>)controlLayer {
//    [self.player.switcher switchControlLayerForIdentitfier:SJControlLayer_Edge];
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    


}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:false completion:^{
            
    }];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    _player = [SJVideoPlayer player];
//    [self _removeExtraItems];
//    [self _addSwitchItem];
//    [self _addCustomControlLayerToSwitcher];
    
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:self.videoPath];
//    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:[NSURL URLWithString:@"http://47.111.139.74:8089/group1/M00/00/0E/L2-LSl-_XsqARpc2ABRa4ftjSk0527.mp4"]];

    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
//    [self.view addSubview:self.preview];
//    
//    self.avPlayer.url = self.videoPath;
//    self.avPlayer.delegate = self;
//    if (self.avPlayer.naturalSize.width != CGSizeZero.width) {
//         self.preview.sl_h = self.preview.sl_w *  self.avPlayer.naturalSize.height/ self.avPlayer.naturalSize.width;
//    }
//    self.avPlayer.monitor = self.preview;
//    self.preview.center = CGPointMake(self.view.sl_w/2.0, self.view.sl_h/2.0);
//    [self.avPlayer play];
    
    
}
- (IBAction)touchButtonAction:(id)sender {
    [self.view bringSubviewToFront:self.topBottomView];
    [self.view bringSubviewToFront:self.navBottomView];

    self.navBottomView.hidden = !self.navBottomView.hidden;
    self.topBottomView.hidden = !self.topBottomView.hidden;
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
