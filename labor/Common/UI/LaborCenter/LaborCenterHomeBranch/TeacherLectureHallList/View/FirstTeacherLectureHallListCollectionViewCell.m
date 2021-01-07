//
//  FirstTeacherLectureHallListCollectionViewCell.m
//  labor
//
//  Created by 狍子 on 2021/1/5.
//  Copyright © 2021 ZKWQY. All rights reserved.
//

#import "FirstTeacherLectureHallListCollectionViewCell.h"

@implementation FirstTeacherLectureHallListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bottomView.layer.cornerRadius = 4;
    self.bottomView.layer.masksToBounds = YES;
    self.playImageView.alpha = 0.8;
}
- (void)reloadData:(TeacherLectureHallListSModel*)model{
    self.nameLabel.text = model.auth;
    self.playNumLabel.text = [NSString stringWithFormat:@"播放量:%d",model.count];
    self.titleLabel.text = model.title;
    NSString *http;
    if ([model.faceUrl containsString:@"http"]) {
        http = @"";
        
    }else{
        http = [NSString stringWithFormat:@"%@",VideoHost];
//        Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VideoHost,model.cover]];

    }
    [self.firstVideoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http,model.faceUrl]]];
//    self.firstVideoImageView.image = [FirstFrameOfTheVideo firstFrameWithVideoURL:Url size:self.firstVideoImageView.bounds.size];

}
@end
