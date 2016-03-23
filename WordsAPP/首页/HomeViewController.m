//
//  HomeViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "HomeViewController.h"
#import "LevelViewController.h"

@interface HomeViewController ()

@property (nonatomic, retain) UIButton * fruit;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.barLable.text = @"题目类型";
    NSLog(@"");
    
    
    
}
- (void)initInterface{
    [self.view addSubview:self.fruit];
}

#pragma mark - 点击跳转
- (void)typeButtonPressed:(UIButton *)sender{
    LevelViewController * level = [[LevelViewController alloc] init];
    [self.navigationController pushViewController:level animated:YES];
}

#pragma mark - getter
- (UIButton *)fruit{
    if (!_fruit) {
        _fruit = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 200, 40);
            button.center = CGPointMake(self.view.center.x, 200);
            button.backgroundColor = [UIColor purpleColor];
            [button addTarget:self action:@selector(typeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _fruit;
}

@end
