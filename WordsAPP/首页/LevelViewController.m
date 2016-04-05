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
#import "Networking.h"

@interface LevelViewController ()

@property (nonatomic, strong) UIButton * buttonSimple;
@property (nonatomic, strong) UIButton * buttonMedium;
@property (nonatomic, strong) UIButton * buttonDifficult;
@property (nonatomic, strong) UIButton * LeftButton;

@property (nonatomic, strong) UIImageView * backGroundImageView;

@property (nonatomic, assign)NSInteger rowNum;
@property (nonatomic, strong)NSString * string;

@end

@implementation LevelViewController

- (instancetype)initWithFlag:(NSInteger)flag
{
    self = [super init];
    if (self) {
        _flag = flag;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [_buttonSimple.layer addAnimation:[self shakeAnimation] forKey:nil];
    [_buttonMedium.layer addAnimation:[self shakeAnimation] forKey:nil];
    [_buttonDifficult.layer addAnimation:[self shakeAnimation] forKey:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.barLable.text = @"难度等级";
    [self initializeUserInterface];
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.backGroundImageView];
    [self.view addSubview:self.buttonSimple];
    [self.view addSubview:self.LeftButton];
    //    [self.view addSubview:self.buttonMedium];
    //    [self.view addSubview:self.buttonDifficult];
}

- (NSInteger )typeOfImageTheNetworking
{
    if (self.flag == 1) {
        return fruit;
    }else if (self.flag == 2){
        return vegetables;
    }else if (self.flag == 3){
        return animals;
    }else if (self.flag == 4){
        return articles;
    }else{
        return sport;
    }
}

- (NSInteger)typeOfNameTheNetworking
{
    if (self.flag == 1) {
        return fruitWords;
    }else if (self.flag == 2){
        return vegetablesWords;
    }else if (self.flag == 3){
        return animalsWords;
    }else if (self.flag == 4){
        return articlesWords;
    }else{
        return sportWords;
    }
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
//抖动动画
- (CAKeyframeAnimation *)shakeAnimation{
    
    
    CAKeyframeAnimation *frame=[CAKeyframeAnimation animation];
    CGFloat left = -M_PI_2 * 0.125;
    CGFloat right = M_PI_2 * 0.125;
    
    
    frame.keyPath = @"postion";
    frame.keyPath = @"transform.rotation";
    
    frame.values = @[@(left),@(right),@(left)];
    frame.duration = 0.8;
    frame.repeatCount = 500;
    return frame;
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
    simpleViewController.imageType = [self typeOfImageTheNetworking];
    simpleViewController.nameType = [self typeOfNameTheNetworking];
    [self.navigationController pushViewController:simpleViewController animated:YES];
}

- (void)mediumClickOnTheEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    MediumViewController * mediumViewController = [[MediumViewController alloc] init];
    mediumViewController.imageType = [self typeOfImageTheNetworking];
    mediumViewController.nameType = [self typeOfNameTheNetworking];
    [self.navigationController pushViewController:mediumViewController animated:YES];
}

- (void)difficultClickOnTheEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    DifficultViewController * diffficultViewController = [[DifficultViewController alloc] init];
    diffficultViewController.imageType = [self typeOfImageTheNetworking];
    diffficultViewController.nameType = [self typeOfNameTheNetworking];
    [self.navigationController pushViewController:diffficultViewController animated:YES];
}

- (void)leftButtonPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark -- getter

- (UIButton *)buttonSimple
{
    if (!_buttonSimple) {
        _buttonSimple = [UIButton buttonWithType:0];
        _buttonSimple.frame = CGRectMake(70 * MAINSCREEN_RATE, 250 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE);
        [_buttonSimple setImage:[UIImage imageNamed:@"简单模式1"] forState:0];
        //        [_buttonSimple setImage:[UIImage imageNamed:@"简单模式点击后"] forState:UIControlStateSelected];
        
        [_buttonSimple addTarget:self action:@selector(simpleClickOnTheEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonSimple.layer addAnimation:[self positionAnimation:CGPointMake(-100 * MAINSCREEN_RATE, -100 * MAINSCREEN_RATE)] forKey:@"simple"];
        
    }
    return _buttonSimple;
}

- (UIButton *)buttonMedium
{
    if (!_buttonMedium) {
        _buttonMedium = [UIButton buttonWithType:0];
        _buttonMedium.frame = CGRectMake(200 * MAINSCREEN_RATE, 390 * MAINSCREEN_RATE, 150* MAINSCREEN_RATE, 150 * MAINSCREEN_RATE);
        
        [_buttonMedium addTarget:self action:@selector(mediumClickOnTheEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonMedium setBackgroundImage:[[UIImage imageNamed:@"中等模式1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:0];
        [_buttonMedium.layer addAnimation:[self shakeAnimation] forKey:nil];
    }
    return _buttonMedium;
}

- (UIButton *)buttonDifficult
{
    if (!_buttonDifficult) {
        _buttonDifficult = [UIButton buttonWithType:0];
        _buttonDifficult.frame = CGRectMake(100 * MAINSCREEN_RATE, 550 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE);
        [_buttonDifficult setBackgroundImage:[[UIImage imageNamed:@"复杂模式1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:0];
        //        [_buttonDifficult setImage:[UIImage imageNamed:@"复杂模式点击后"] forState:UIControlStateSelected];
        [_buttonDifficult addTarget:self action:@selector(difficultClickOnTheEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [_buttonDifficult.layer addAnimation:[self shakeAnimation] forKey:nil];
        
        
        
    }
    return _buttonDifficult;
}

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        [_backGroundImageView setImage:[UIImage imageNamed:@"背景.png"]];
    }
    return _backGroundImageView;
}

- (UIButton *)LeftButton{
    if (!_LeftButton) {
        _LeftButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
            [button setImage:[UIImage imageNamed:@"返回1.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _LeftButton;
}

@end
