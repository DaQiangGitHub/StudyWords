//
//  SimpleViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "SimpleViewController.h"
#import "ModelView.h"
#import "Networking.h"
#import "CompleteView.h"
@interface SimpleViewController ()

@property (nonatomic, strong)ModelView * ModelView;
@property (nonatomic, strong)UIButton * backButton;




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
    [self.ModelView.completeView addSubview:self.backButton];
}

#pragma mark -- clickOnTheEvents
- (void)returnToTheFontController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- getter

- (UIView *)ModelView
{
    if (!_ModelView) {
        _ModelView = [[ModelView alloc] initWithFrame:self.view.frame imageType: self.imageType nameType:self.nameType];
    }
    return _ModelView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(30 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
        [_backButton setImage:[UIImage imageNamed:@"返回1.png"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(returnToTheFontController:) forControlEvents:UIControlEventTouchUpInside];
       

    }
    return _backButton;
}



@end
