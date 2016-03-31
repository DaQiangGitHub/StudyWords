//
//  BaseViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseViewController ()



@end



@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR(233, 233, 233);
    
    [self initBaseDataSource];

}
- (void)initBaseDataSource{
    _imagesType = [NSArray arrayWithObjects:[UIImage imageNamed:@"水果"],[UIImage imageNamed:@"蔬菜"],[UIImage imageNamed:@"动物"],[UIImage imageNamed:@"生活用品"],[UIImage imageNamed:@"运动"], nil];
    _imagesLevel = [NSArray arrayWithObjects:[UIImage imageNamed:@"简单模式"],[UIImage imageNamed:@"中等模式"],[UIImage imageNamed:@"复杂模式"], nil];
    
    [self initalizeBaseInterface];
}
- (void)initalizeBaseInterface{
    
    [self.view addSubview:self.barView];
    [self.view addSubview:self.barLable];
    [self.view addSubview:self.barLeftButton];
    [self.view addSubview:self.barRightButton];
}

#pragma mark - 点击事件
- (void)leftButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonPressed{
//    [AVUser logOut];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - getter
- (UIView *)barView{
    if (!_barView) {
        _barView = ({
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, BAR_H)];
//            view.backgroundColor = [UIColor whiteColor];
            
            view;
        });
    }
    return _barView;
}
- (UILabel *)barLable{
    if (!_barLable) {
        _barLable = ({
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150, 50)];
            lable.center = CGPointMake(self.view.center.x, 35);
            lable.font = [UIFont systemFontOfSize:25];
            lable.textAlignment = NSTextAlignmentCenter;
            lable;
        });
    }
    return _barLable;
}
- (UIButton *)barLeftButton{
    if (!_barLeftButton) {
        _barLeftButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 10, 70, 50);
            [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _barLeftButton;
}
- (UIButton *)barRightButton{
    if (!_barRightButton) {
        _barRightButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(SCREEN_W - 50, 15, 40, 40);
            button.backgroundColor = [UIColor orangeColor];
            [button addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _barRightButton;
}

@end
