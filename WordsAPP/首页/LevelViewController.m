//
//  LevelViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "LevelViewController.h"
#import "SimpleViewController.h"
#import "MediumViewController.h"
#import "DifficultViewController.h"

@interface LevelViewController ()

@property (nonatomic, strong) UIButton * buttonSimple;
@property (nonatomic, strong) UIButton * buttonMedium;
@property (nonatomic, strong) UIButton * buttonDifficult;


@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.barLable.text = @"难度等级";
    [self initializeUserInterface];
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.buttonSimple];
    //    [self.view addSubview:self.buttonMedium];
    //    [self.view addSubview:self.buttonDifficult];
}

#pragma  mark -- Animation
//位移动画
- (CABasicAnimation *)positionAnimation:(CGPoint)CGPoint
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSValue valueWithCGPoint:CGPoint];
    return animation;
}
//动画代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAAnimation * animation = [self.buttonSimple.layer animationForKey:@"simple"];
    if (animation == anim) {
        [self.view addSubview:self.buttonMedium];
        [self.buttonMedium.layer addAnimation:[self positionAnimation:CGPointMake(500, -100)] forKey:@"medium"];
    }
    animation = [self.buttonMedium.layer animationForKey:@"medium"];
    if (animation == anim) {
        [self.view addSubview:self.buttonDifficult];
        [self.buttonDifficult.layer addAnimation:[self positionAnimation:CGPointMake(500, 800)] forKey:nil];
    }
    
}

#pragma mark -- clickOnTheEvents

- (void)simpleClickOnTheEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    SimpleViewController * simpleViewController = [[SimpleViewController alloc] init];
    [self.navigationController pushViewController:simpleViewController animated:YES];
}

- (void)mediumClickOnTheEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    MediumViewController * mediumViewController = [[MediumViewController alloc] init];
    [self.navigationController pushViewController:mediumViewController animated:YES];
}

- (void)difficultClickOnTheEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    DifficultViewController * diffficultViewController = [[DifficultViewController alloc] init];
    [self.navigationController pushViewController:diffficultViewController animated:YES];
}

#pragma  mark -- getter

- (UIButton *)buttonSimple
{
    if (!_buttonSimple) {
        _buttonSimple = [UIButton buttonWithType:0];
        _buttonSimple.frame = CGRectMake(120, 160, 200, 50);
        [_buttonSimple setImage:[UIImage imageNamed:@"简单模式"] forState:0];
        //        [_buttonSimple setImage:[UIImage imageNamed:@"简单模式点击后"] forState:UIControlStateSelected];
        
        [_buttonSimple addTarget:self action:@selector(simpleClickOnTheEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [_buttonSimple.layer addAnimation:[self positionAnimation:CGPointMake(-100, -100)] forKey:@"simple"];
        
    }
    return _buttonSimple;
}

- (UIButton *)buttonMedium
{
    if (!_buttonMedium) {
        _buttonMedium = [UIButton buttonWithType:0];
        _buttonMedium.frame = CGRectMake(120, 300, 200, 50);
        
        [_buttonMedium addTarget:self action:@selector(mediumClickOnTheEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonMedium setBackgroundImage:[[UIImage imageNamed:@"中等模式"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:0];
        //        [_buttonMedium setImage:[UIImage imageNamed:@"中等模式点击后"] forState:UIControlStateSelected];
    }
    return _buttonMedium;
}

- (UIButton *)buttonDifficult
{
    if (!_buttonDifficult) {
        _buttonDifficult = [UIButton buttonWithType:0];
        _buttonDifficult.frame = CGRectMake(120, 440, 200, 50);
        [_buttonDifficult setBackgroundImage:[[UIImage imageNamed:@"复杂模式"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:0];
        //        [_buttonDifficult setImage:[UIImage imageNamed:@"复杂模式点击后"] forState:UIControlStateSelected];
        [_buttonDifficult addTarget:self action:@selector(difficultClickOnTheEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonDifficult;
}

@end
