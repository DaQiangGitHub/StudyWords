//
//  ViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "ViewController.h"
#import "IntroduceViewController.h"
#import "HomeViewController.h"
#import "UserViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ViewController ()


@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * nameLable;
@property (nonatomic, strong) UIButton * buttonIn;


@end

@implementation ViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initDateSource) name:@"login" object:nil];
    
    [self initDateSource];
}
- (void)initDateSource{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 跳转到首页
        [self initalizeInterface];
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        [self performSelector:@selector(IntroduceVC) withObject:nil afterDelay:0.001];
    }
}
- (void)IntroduceVC{
    IntroduceViewController * introduce = [[IntroduceViewController alloc] initWithBool:YES];
    [self presentViewController:introduce animated:YES completion:nil];
}

- (void)initalizeInterface{
    
    [self.view addSubview:self.backImageView];
//    [self.view addSubview:self.nameLable];
    [self.view addSubview:self.buttonIn];
}

- (void)buttonInPressed{
    
    HomeViewController * home = [[HomeViewController alloc] init];
    UserViewController * user = [[UserViewController alloc] init];
    user.tabBarItem.title = @"arga";
    home.tabBarItem.title = @"rgae";
    
    UINavigationController * homeN = [[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController * userN = [[UINavigationController alloc] initWithRootViewController:user];
    homeN.navigationBarHidden = YES;
    userN.navigationBarHidden = YES;
    
    UITabBarController * tabbar = [[UITabBarController alloc] init];
    tabbar.viewControllers = @[homeN, userN];
    [self presentViewController:tabbar animated:YES completion:nil];
}


#pragma mark - getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imageView.image = [UIImage imageNamed:@"首页底.jpg"];
            imageView;
        });
    }
    return _backImageView;
}
- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = ({
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
            lable.center = CGPointMake(self.view.center.x, 100);
            lable.backgroundColor = [UIColor blueColor];
            
            lable;
        });
    }
    return _nameLable;
}
- (UIButton *)buttonIn{
    if (!_buttonIn) {
        _buttonIn = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 150, 50);
            button.center = CGPointMake(self.view.center.x, 500);
            button.backgroundColor = [UIColor orangeColor];
            [button addTarget:self action:@selector(buttonInPressed) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _buttonIn;
}

@end
