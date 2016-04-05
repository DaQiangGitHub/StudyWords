//
//  MediumViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "MediumViewController.h"
#import "MidiumView.h"
#import "Networking.h"
@interface MediumViewController ()

@property (nonatomic, strong)MidiumView * midiumView;
@property (nonatomic, strong)UIButton * backButton;


@end

@implementation MediumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
    
    
}

- (void)initializeUserInterface
{
    
    [self.view addSubview:self.midiumView];
    [self.midiumView addSubview:self.backButton];
    [self.midiumView.completeView addSubview:self.backButton];
}

#pragma mark -- clickOnTheEvents
- (void)returnToTheFontController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- getter

- (UIView *)midiumView
{
    if (!_midiumView) {
        _midiumView = [[MidiumView alloc] initWithFrame:self.view.frame nameType:self.nameType imageType:self.imageType];
    }
    return _midiumView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(30 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 80 * MAINSCREEN_RATE, 80 * MAINSCREEN_RATE);
        [_backButton setImage:[UIImage imageNamed:@"返回1.png"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(returnToTheFontController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


@end
