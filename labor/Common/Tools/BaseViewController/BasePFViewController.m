//
//  BasePFViewController.m
//  labor
//
//  Created by 狍子 on 2020/12/1.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "BasePFViewController.h"
#import "Rottie1View.h"

@interface BasePFViewController ()
@property (nonatomic,strong)Rottie1View *rottieView;
@property (nonatomic,strong)LOTAnimationView *animatedView;

@end

@implementation BasePFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
