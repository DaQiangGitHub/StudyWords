//
//  ViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UserViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ViewController ()


@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * buttonIn;

//初始化用户：
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * password;


@end

@implementation ViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initalizeInterface];

}
- (void)viewDidAppear:(BOOL)animated{
    [self.buttonIn.layer addAnimation:[self shakeAnimation] forKey:nil];
}
- (void)initalizeInterface{
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.buttonIn];
}
- (void)buttonInPressed{
    
    [self islogin];
}
- (void)islogin{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sdudayWordsAppIsLogin"]) {
        // 跳转到首页
        [self letIn];
    } else {
        [self registered];
    }
}

- (void)letIn{
    HomeViewController * home = [[HomeViewController alloc] init];
    UserViewController * user = [[UserViewController alloc] init];

    
    UINavigationController * homeN = [[UINavigationController alloc] initWithRootViewController:home];
    home.tabBarItem.image = [UIImage imageNamed:@"主页tab"];
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"主页tab点击"];
    user.tabBarItem.image = [UIImage imageNamed:@"个人tab"];
    user.tabBarItem.selectedImage = [UIImage imageNamed:@"个人tab点击"];
    UINavigationController * userN = [[UINavigationController alloc] initWithRootViewController:user];
    homeN.navigationBarHidden = YES;
    userN.navigationBarHidden = YES;
    
    UITabBarController * tabbar = [[UITabBarController alloc] init];
    tabbar.tabBar.tintColor = [UIColor greenColor];
    tabbar.viewControllers = @[homeN, userN];
    [self presentViewController:tabbar animated:YES completion:nil];
}
//抖动动画
- (CAKeyframeAnimation *)shakeAnimation{
    
    CAKeyframeAnimation *frame=[CAKeyframeAnimation animation];
    CGFloat left = -M_PI_2 * 0.1;
    CGFloat right = M_PI_2 * 0.1;
    
    
    frame.keyPath = @"postion";
    frame.keyPath = @"transform.rotation";
    
    frame.values = @[@(left),@(right),@(left)];
    frame.duration = 0.8;
    frame.repeatCount = 500;
    return frame;
}

#pragma mark -- getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imageView.image = [UIImage imageNamed:@"首页底"];
            imageView;
        });
    }
    return _backImageView;
}
- (UIButton *)buttonIn{
    if (!_buttonIn) {
        _buttonIn = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 150 * MAINSCREEN_RATE, 80 * MAINSCREEN_RATE);
            button.center = CGPointMake(self.view.center.x, 430 * MAINSCREEN_RATE);
            [button setImage:[UIImage imageNamed:@"开始答题"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonInPressed) forControlEvents:UIControlEventTouchUpInside];
            [button.layer addAnimation:[self shakeAnimation] forKey:nil];
            button;
        });
    }
    return _buttonIn;
}

#pragma mark - 初始化新用户
- (void)registered{
    
    NSDictionary * mistakes = [NSDictionary dictionary];
    
    NSDictionary * records = [NSDictionary dictionary];
    
    AVUser *user = [AVUser user];           // 新建 AVUser 对象实例
    self.name = [self ret10bitString];
    self.password = [self ret10bitString];
    user.username = self.name;              // 设置用户名
    user.password = self.password;          // 设置密码
    [user setObject:mistakes forKey:@"mistakes"];
    [user setObject:records forKey:@"records"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
            [self login];
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            [self registered];
        }
    }];
}
- (void)login{
    
    [AVUser logInWithUsernameInBackground:self.name password:self.password block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"sdudayWordsAppIsLogin"];
            [self letIn];
        } else {
            [self registered];
        }
    }];
}
-(NSString *)ret10bitString
{
    char data[10];
    
    for (int x=0;x<10;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:10 encoding:NSUTF8StringEncoding];
}

@end
