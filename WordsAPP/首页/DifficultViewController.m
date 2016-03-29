//
//  DifficultViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "DifficultViewController.h"

@interface DifficultViewController ()

@property (nonatomic, strong)UILabel * remindLable;
@property (nonatomic, strong)UIButton * backButton;
@property (nonatomic, strong)UILabel * textLable;
@property (nonatomic, strong)UIImageView * backGroundImage;

@end

@implementation DifficultViewController

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

#pragma mark -- Animation

- (CABasicAnimation *)positionOfTheAnimation:(CGPoint)CGPoint fromeValue:(CGPoint)CGPointFrom;
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointFrom];
    animation.toValue = [NSValue valueWithCGPoint:CGPoint];
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
    CAAnimation * animation = [self.remindLable.layer animationForKey:@"remindLable"];
    if (animation == anim) {
        [self performSelector:@selector(animationDisapper) withObject:nil afterDelay:2];
    }
    animation = [self.remindLable.layer animationForKey:@"finally"];
    if (animation == anim) {
        //        [UIView animateKeyframesWithDuration:0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        //            self.remindLable.hidden = YES;
        //        } completion:nil];
        self.remindLable.hidden = YES;
        [self.view addSubview:self.textLable];
    }
}

- (void)animationDisapper
{
    [self.remindLable.layer addAnimation:[self scaleAnimationDisapear] forKey:nil];
    [self.remindLable.layer addAnimation:[self positionOfTheAnimation:CGPointMake(300, -200) fromeValue:CGPointMake(100, 190)]forKey:@"finally"];
}
#pragma mark -- getter

- (UILabel *)remindLable
{
    if (!_remindLable) {
        _remindLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 280, 100)];
        _remindLable.numberOfLines = 0;
        _remindLable.backgroundColor = [UIColor redColor];
        _remindLable.text = @"困难模式，请根据给出的图片提示填写出正确的英文单词。";
        [_remindLable.layer addAnimation:[self scaleAnimation] forKey:nil];
        [_remindLable.layer addAnimation:[self positionOfTheAnimation:CGPointMake(100 , 190) fromeValue:CGPointMake(200, -200)] forKey:@"remindLable"];
        
        
    }
    return _remindLable;
}

- (UILabel *)textLable
{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
        _textLable.backgroundColor = [UIColor greenColor];
        _textLable.text = @"请输入正确的英文文单词";
        [_textLable.layer addAnimation:[self positionOfTheAnimation:CGPointMake(100, 220) fromeValue:CGPointMake(-200, 220)] forKey:nil];
    }
    return _textLable;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:0];
        _backButton.frame = CGRectMake(150, 50, 100, 50);
        _backButton.backgroundColor = [UIColor blueColor];
        [_backButton setTitle:@"返回" forState:0];
        [_backButton addTarget:self action:@selector(backToTheFontController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *)backGroundImage
{
    if (!_backGroundImage) {
        _backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        [_backGroundImage setImage:[UIImage imageNamed:@"复杂模式背景"]];
    }
    return _backGroundImage;
}

@end
