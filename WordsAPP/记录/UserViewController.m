//
//  UserViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "UserViewController.h"
#import "WrongQuestionViewController.h"
#import "recordViewController.h"
#import "Networking.h"

#import "UMSocial.h"

@interface UserViewController ()

@property (nonatomic, retain) UIImageView * backImage;
@property (nonatomic, retain) UIButton * recordToday;
@property (nonatomic, retain) UIButton * wrongQuestion;
@property (nonatomic, assign) AVUser * currentUser;

@property (nonatomic,retain)NSMutableArray *images;
@property (nonatomic,retain)UIImageView *imageview;



@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.barLable.text = @"个人";

    [self.view addSubview:self.backImage];
    [self.view addSubview:self.recordToday];
    [self.view addSubview:self.wrongQuestion];
    [self.view addSubview:self.imageview];
 
    _currentUser = [AVUser currentUser];
    
    [self initDateSourse];
    [self initLizeUserInterface];
    

}
 
#pragma mark - 点击事件
- (void)wrongButtonPressed{
    
//    __weak UIViewController * weakSelf = self;
//    [UMSocialSnsService presentSnsIconSheetView:weakSelf
//                                         appKey:@"56fcc34267e58ecf2c0005f1"
//                                      shareText:@"宝宝得了100分"
//                                     shareImage:[UIImage imageNamed:@"首页底.jpg"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToFacebook,nil]
//                                       delegate:nil];
    
    
    WrongQuestionViewController * wrong = [[WrongQuestionViewController alloc] init];
    [self.navigationController pushViewController:wrong animated:YES];
}
- (void)recordButtonPressed{
    recordViewController * record = [[recordViewController alloc] init];
    [self.navigationController pushViewController:record animated:YES];
}
//动画
-(void)initDateSourse{
    for (int i = 1; i < 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d",i];
        
        UIImage *image = [UIImage imageNamed:imageName];
        [self.images addObject:image];
        
    }
    self.imageview.animationImages = self.images;
    //图片播放速度
    self.imageview.animationDuration = 1;
    //0表示无限
    self.imageview.animationRepeatCount = 0;
    
    
}
- (void)initLizeUserInterface{
    [self.imageview startAnimating];
    [self.view addSubview:self.imageview];
    
    
}
#pragma mark -- setter
//重写setter && getter
- (NSMutableArray *)images{
    if (!_images) {
        //便利构造器方法
        _images = [NSMutableArray array];
        
    }
    return _images;
}
#pragma mark - getter

-(UIImageView *)imageview{
    if (!_imageview) {
        _imageview = ({
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(220, 460, 220, 220)];
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            
            //用户交互
            imageview.userInteractionEnabled = YES;
            imageview;
        });
    }
    
    return _imageview;
}
#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - BAR_H + 10)];
            imageView.image = [UIImage imageNamed:@"个人"];
            
            imageView;
        });
    }
    return _backImage;
}
- (UIButton *)recordToday{
    if (!_recordToday) {
        _recordToday = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 280, 70);
            button.center = CGPointMake(self.view.center.x, 240);
//            button.backgroundColor = [UIColor orangeColor];
            [button setImage:[UIImage imageNamed:@"重新答题"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(recordButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _recordToday;
}
- (UIButton *)wrongQuestion{
    if (!_wrongQuestion) {
        _wrongQuestion = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 280, 70);
            button.center = CGPointMake(self.view.center.x, 430);
//            button.backgroundColor = [UIColor orangeColor];
            [button setImage:[UIImage imageNamed:@"错题重做"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(wrongButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _wrongQuestion;
}

@end
