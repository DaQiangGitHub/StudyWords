//
//  IntroduceViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "IntroduceViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface IntroduceViewController ()

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * password;

@property (nonatomic, retain) UIButton * loginButton;

@end

@implementation IntroduceViewController

- (instancetype)initWithBool:(BOOL)isFirst
{
    self = [super init];
    if (self) {
        self.isFirst = isFirst;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    if (_isFirst) {

    }
    
    [self initInterface];

}

- (void)initInterface{
    [self.view addSubview:self.loginButton];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
            [self dismissViewControllerAnimated:NO completion:nil];
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


#pragma mark - getter
- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(100, 200, 200, 60);
            button.backgroundColor = [UIColor orangeColor];
            [button addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _loginButton;
}


@end
