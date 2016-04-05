//
//  HomeViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "HomeViewController.h"
#import "LevelViewController.h"
#import "LevelViewController.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface HomeViewController ()

{
    NSInteger integer;
}

@property (nonatomic,strong)UIButton *backButton;

@property (nonatomic, strong) NSArray * pictures;
@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic, strong)UIButton * fruitButton;
@property (nonatomic, strong)UIButton * vegetables;
@property (nonatomic, strong)UIButton * animals;
@property (nonatomic, strong)UIButton * lifeGoods;
@property (nonatomic, strong)UIButton * sport;

@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated{
    [self.fruitButton.layer addAnimation:[self shakeAnimation] forKey:nil];
    [self.vegetables.layer addAnimation:[self shakeAnimation] forKey:nil];
    [self.animals.layer addAnimation:[self shakeAnimation] forKey:nil];
    [self.lifeGoods.layer addAnimation:[self shakeAnimation] forKey:nil];
    [self.sport.layer addAnimation:[self shakeAnimation] forKey:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initInterface];
    [self shouldAutorotate];
    [self supportedInterfaceOrientations];
    [self preferredInterfaceOrientationForPresentation];
    
}
- (void)initInterface{
    _pictures = [NSArray arrayWithObjects:@"水果",@"蔬菜",@"动物",@"生活",@"运动", nil];
 
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.backgroundImageView];

//    [self.view addSubview:self.fruitButton];
    [self.view addSubview:self.backButton];
    
}


#pragma mark -- animation


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
    CAAnimation * animation = [self.fruitButton.layer animationForKey:@"simple"];
    if (animation == anim) {
        [self.view addSubview:self.fruitButton];
        [self.view addSubview:self.vegetables];
        [self.vegetables.layer addAnimation:[self positionAnimation:CGPointMake(100, -100)] forKey:@"medium"];
    }
    animation = [self.vegetables.layer animationForKey:@"simple"];
    if (animation == anim) {
        [self.view addSubview:self.animals];
        [self.animals.layer addAnimation:[self positionAnimation:CGPointMake(-300, 300)] forKey:@"medium"];
    }
    animation = [self.animals.layer animationForKey:@"simple"];
        if (animation == anim) {
        [self.view addSubview:self.lifeGoods];
        [self.lifeGoods.layer addAnimation:[self positionAnimation:CGPointMake(1000, 500)] forKey:@"medinm"];
    }
    animation = [self.lifeGoods.layer animationForKey:@"simple"];

    if (animation == anim) {
        [self.view addSubview:self.sport];
        [self.sport.layer addAnimation:[self positionAnimation:CGPointMake(300, 1000)] forKey:nil];
    }
    
}

- (void)starAnimation{
    static NSInteger index = 0;
    UIImageView *image = [self.view viewWithTag:300];
    [UIView transitionWithView:image duration:1.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            index ++;
            
            if (index) {
                index = 0;
            }
            [self starAnimation];
            
        }];
  
}

#pragma mark - ClickOnTheEvents

- (void)buttonPressed_click:(UIButton *)sender

{
    
    
    NSInteger index = sender.tag - 100;
    LevelViewController * leverViewController = [[LevelViewController alloc] initWithFlag:index];
    [self.navigationController pushViewController:leverViewController animated:YES];
    
}
- (void)returnButtonpressed:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (UIButton *)fruitButton
{
    if (!_fruitButton) {
        _fruitButton = [UIButton buttonWithType:0];
        _fruitButton.frame = CGRectMake(30 * MAINSCREEN_RATE, 100 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        [_fruitButton setImage:[UIImage imageNamed:@"水果"] forState:0];
        _fruitButton.tag = 101;
        [_fruitButton addTarget:self action:@selector(buttonPressed_click:) forControlEvents:UIControlEventTouchUpInside];
        [_fruitButton.layer addAnimation:[self positionAnimation:CGPointMake(-100 * MAINSCREEN_RATE, -100 * MAINSCREEN_RATE)] forKey:@"simple"];
        [_fruitButton.layer addAnimation:[self shakeAnimation] forKey:nil];
//        [self starAnimation];
        
        
    }
    return _fruitButton;
}

- (UIButton *)vegetables
{
    if (!_vegetables) {
        _vegetables = [UIButton buttonWithType:0];
        _vegetables.frame = CGRectMake(30 * MAINSCREEN_RATE, 390 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        [_vegetables setImage:[UIImage imageNamed:@"蔬菜"] forState:0];
        _vegetables.tag = 102;
        [_vegetables addTarget:self action:@selector(buttonPressed_click:) forControlEvents:UIControlEventTouchUpInside];
        [_vegetables.layer addAnimation:[self positionAnimation:CGPointMake(250 * MAINSCREEN_RATE, -100 * MAINSCREEN_RATE)] forKey:@"simple"];
        [self.vegetables.layer addAnimation:[self shakeAnimation] forKey:nil];
        
    }
    return _vegetables;
}

- (UIButton *)animals
{
    if (!_animals) {
        _animals = [UIButton buttonWithType:0];
        _animals.frame = CGRectMake(260 * MAINSCREEN_RATE, 100 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _animals.tag = 103;
        [_animals setImage:[UIImage imageNamed:@"动物"] forState:0];
        [_animals addTarget:self action:@selector(buttonPressed_click:) forControlEvents:UIControlEventTouchUpInside];
        [_animals.layer addAnimation:[self shakeAnimation] forKey:nil];
        [_animals.layer addAnimation:[self positionAnimation:CGPointMake(500 * MAINSCREEN_RATE, -100 * MAINSCREEN_RATE)] forKey:@"simple"];
        
    }
    return _animals;
}

- (UIButton *)lifeGoods
{
    if (!_lifeGoods) {
        _lifeGoods = [UIButton buttonWithType:0];
        _lifeGoods.frame = CGRectMake(260 * MAINSCREEN_RATE, 390 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _lifeGoods.tag = 104;
        [_lifeGoods setImage:[UIImage imageNamed:@"生活"] forState:0];
        [_lifeGoods addTarget:self action:@selector(buttonPressed_click:) forControlEvents:UIControlEventTouchUpInside];
        [_lifeGoods.layer addAnimation:[self positionAnimation:CGPointMake(250 * MAINSCREEN_RATE, -100 * MAINSCREEN_RATE)] forKey:@"simple"];
        
        [_lifeGoods.layer addAnimation:[self shakeAnimation] forKey:nil];
        
    }
    return _lifeGoods;
}

- (UIButton *)sport
{
    if (!_sport) {
        _sport = [UIButton buttonWithType:0];
        _sport.frame = CGRectMake(140 * MAINSCREEN_RATE, 260 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _sport.tag = 105;
        [_sport setImage:[UIImage imageNamed:@"运动"] forState:0];
        [_sport addTarget:self action:@selector(buttonPressed_click:) forControlEvents:UIControlEventTouchUpInside];
        [_sport.layer addAnimation:[self positionAnimation:CGPointMake(250 * MAINSCREEN_RATE, -100 * MAINSCREEN_RATE)] forKey:@"simple"];
        [_sport.layer addAnimation:[self shakeAnimation] forKey:nil];
        
    }
    return _sport;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W , SCREEN_H )];
        [_backgroundImageView setImage:[UIImage imageNamed:@"选择背景"]];
    }
    return _backgroundImageView;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(10 * MAINSCREEN_RATE, 30 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
        [_backButton setImage:[UIImage imageNamed:@"返回1"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(returnButtonpressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
