//
//  LevelViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "LevelViewController.h"

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

//

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

- (void)simpleClickOnTheEvent
{
    
}

- (void)mediumClickOnTheEvent
{
    
}

- (void)difficultClickOnTheEvent
{
    
}

#pragma  mark -- getter

- (UIButton *)buttonSimple
{
    if (!_buttonSimple) {
        _buttonSimple = [UIButton buttonWithType:0];
        _buttonSimple.frame = CGRectMake(120, 160, 200, 40);
        _buttonSimple.backgroundColor = [UIColor redColor];
        [_buttonSimple.layer addAnimation:[self positionAnimation:CGPointMake(-100, -100)] forKey:@"simple"];
        [_buttonSimple setTitle:@"简单模式" forState:0];
    }
    return _buttonSimple;
}

- (UIButton *)buttonMedium
{
    if (!_buttonMedium) {
        _buttonMedium = [UIButton buttonWithType:0];
        _buttonMedium.frame = CGRectMake(120, 300, 200, 40);
        _buttonMedium.backgroundColor = [UIColor orangeColor];
//        [_buttonMedium.layer addAnimation:[self positionAnimation:CGPointMake(500, -100)] forKey:nil];
        [_buttonMedium setTitle:@"中等模式" forState:0];
    }
    return _buttonMedium;
}

- (UIButton *)buttonDifficult
{
    if (!_buttonDifficult) {
        _buttonDifficult = [UIButton buttonWithType:0];
        _buttonDifficult.frame = CGRectMake(120, 440, 200, 40);
        _buttonDifficult.backgroundColor = [UIColor greenColor];
//        [_buttonDifficult.layer addAnimation:[self positionAnimation:CGPointMake(500, 800)] forKey:nil];
        [_buttonDifficult setTitle:@"困难模式" forState:0];;
    }
    return _buttonDifficult;
}

@end
