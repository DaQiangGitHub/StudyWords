//
//  MediumViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "MediumViewController.h"

@interface MediumViewController ()

@property (nonatomic, strong)UILabel * remindLable;
@property (nonatomic, strong)UILabel * textLable;
@property (nonatomic, strong)UIButton * backButton;

@property (nonatomic, strong)UIImageView * backGroundImage;

@end

@implementation MediumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeUserInterface];
}

- (void)initializeUserInterface
{
    [self.view addSubview:self.backGroundImage];
    [self.view addSubview:self.remindLable];
    
    [self.view addSubview:self.backButton];
}

#pragma mark -- clickOnTheEvents

- (void)backToTheFontController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- animation

- (CABasicAnimation *)positionAnimation:(CGPoint)CGPoint
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:CGPoint];
    animation.duration = 1;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CABasicAnimation *)positionOfAnimation:(CGPoint)CGPoint
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPoint];
    animation.duration = 1;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CABasicAnimation *)scaleAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.8;
    animation.fromValue = @(0.1);
    animation.toValue = @(0.5);
    return animation;
}

- (CABasicAnimation *)scaleAnimationDisapear
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.8;
    animation.fromValue = @(1);
    animation.toValue = @(0.1);
    return animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAAnimation * animation = [self.remindLable.layer animationForKey:@"position"];
    if (animation == anim) {
        [self performSelector:@selector(animationDisapear) withObject:nil afterDelay:2];
    }
    animation = [self.remindLable.layer animationForKey:@"finally"];
    if (animation == anim) {
        self.remindLable.hidden = YES;
        [self.view addSubview:self.textLable];
    }
}

- (void)animationDisapear
{
    [self.remindLable.layer addAnimation:[self scaleAnimationDisapear] forKey:nil];
    [self.remindLable.layer addAnimation:[self positionAnimation:CGPointMake(CGRectGetWidth(self.view.frame), - 200)] forKey:@"finally"];
    
}

#pragma mark -- getter

- (UILabel *)remindLable
{
    if (!_remindLable) {
        _remindLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
        _remindLable.text = @"请根据图片补充英文单词缺失的字母，加油！";
        _remindLable.numberOfLines = 0;
        _remindLable.backgroundColor = [UIColor blueColor];
        [_remindLable.layer addAnimation:[self positionOfAnimation:CGPointMake(self.view.center.x, - 200)] forKey:@"position"];
        [_remindLable.layer addAnimation:[self scaleAnimation] forKey:@"scale"];
    }
    return _remindLable;
}

- (UILabel *)textLable
{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 200, 100)];
        _textLable.text = @"请根据图片补充英文单词缺失的字母，加油！";
        _textLable.numberOfLines = 0;
        _textLable.backgroundColor = [UIColor redColor];
        [_textLable.layer addAnimation:[self positionOfAnimation:CGPointMake(-200, 270)] forKey:nil];
    }
    return _textLable;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:0];
        _backButton.frame = CGRectMake(self.view.center.x - 100, 50, 100, 40);
        _backButton.backgroundColor = [UIColor greenColor];
        [_backButton setTitle:@"返回" forState:0];
        [_backButton addTarget:self action:@selector(backToTheFontController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *)backGroundImage
{
    if (!_backGroundImage) {
        _backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        [_backGroundImage setImage:[UIImage imageNamed:@"中等模式背景"]];
    }
    return _backGroundImage;
}

@end
