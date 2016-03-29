//
//  SimpleViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "SimpleViewController.h"
#import "ModelView.h"
@interface SimpleViewController ()

@property (nonatomic, strong)ModelView * ModelView;
@property (nonatomic, strong)UIButton * backButton;
@property (nonatomic, strong)UIButton * nextButton;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
    
    
}

- (void)initializeUserInterface
{
    [self.view addSubview:self.ModelView];
    [self.ModelView addSubview:self.backButton];
    [self.ModelView addSubview:self.nextButton];
}

#pragma mark -- clickOnTheEvents
- (void)returnToTheFontController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonPressed_NextTopic:(UIButton *)sender
{
    
}

#pragma mark -- getter

- (UIView *)ModelView
{
    if (!_ModelView) {
        _ModelView = [[ModelView alloc] initWithFrame:self.view.frame];
    }
    return _ModelView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:0];
        _backButton.frame = CGRectMake(100, 50, 100, 40);
        _backButton.backgroundColor = [UIColor blueColor];
        [_backButton setTitle:@"返回上一页" forState:0];
        [_backButton addTarget:self action:@selector(returnToTheFontController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:0];
        _nextButton.frame = CGRectMake(100, 650, 100, 40);
        [_nextButton setTitle:@"下一题" forState:0];
        [_nextButton addTarget:self action:@selector(buttonPressed_NextTopic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

@end
