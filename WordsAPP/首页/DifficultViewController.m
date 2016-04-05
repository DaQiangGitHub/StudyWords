//
//  DifficultViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "DifficultViewController.h"
#import "DifficultView.h"

@interface DifficultViewController ()

@property (nonatomic,strong)DifficultView * difficultView;
@property (nonatomic, strong)UIButton * backButton;

@end

@implementation DifficultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeUserInterface];
}

- (void)initializeUserInterface
{
    [self.view addSubview:self.difficultView];
    [self.difficultView addSubview:self.backButton];
    [self.difficultView.completeView addSubview:self.backButton];
}
- (void)backToTheFontController
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- getter

- (DifficultView *)difficultView
{
    if (!_difficultView) {
        _difficultView = [[DifficultView alloc] initWithFrame:self.view.frame imageType:self.imageType nameType:self.nameType];
    }
    return _difficultView;
}
- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(30 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
        [_backButton setImage:[UIImage imageNamed:@"返回1.png"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backToTheFontController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


@end
