//
//  SimpleViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()

@property (nonatomic, strong)UILabel * remindLable;
@property (nonatomic, strong)UILabel * textLable;
@property (nonatomic, strong)UILabel * wordLable;
@property (nonatomic, strong)UIImageView * backGroundImageView;

@property (nonatomic, strong)NSArray * words;
@property (nonatomic, strong)NSArray * images;
@property (nonatomic, strong)NSArray * array;

@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)NSInteger index1;
@property (nonatomic, assign)NSInteger index2;
@property (nonatomic, assign)NSInteger index3;
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)UIImageView * imageView1;
@property (nonatomic, strong)UIImageView * imageView2;
@property (nonatomic, strong)UIImageView * imageView3;
@property (nonatomic, strong)UIImageView * imageView4;

@property (nonatomic, strong)UIButton * backButton;

@property (nonatomic, strong)UIButton * nextButton;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeUserInterface];
    
}

- (void)initializeDataSource
{
    _words = @[@"fruit",@"vegetables",@"animal",@"life",@"sports"];
    _images = @[@"水果",@"蔬菜",@"动物.jpg",@"生活用品.jpg",@"运动"];
    //    NSDictionary * dic =
    self.currentIndex = arc4random() % 5;
}

- (void)initializeUserInterface
{
    [self.view addSubview:self.backGroundImageView];
    [self.view addSubview:self.remindLable];
    
    [self.view addSubview:self.imageView1];
    [self.view addSubview:self.imageView2];
    [self.view addSubview:self.imageView3];
    [self.view addSubview:self.imageView4];
    
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.nextButton];
    //读取单词
    _array = @[@(self.currentIndex),@(self.index1),@(self.index2),@(self.index3)];
    self.index = arc4random() % 4;
    NSLog(@"index = %ld",self.index);
    [self.view addSubview:self.wordLable];
}

#pragma mark -- privateMethod

- (NSInteger)arcMethod
{
    
    for (int i = 0; ; i ++) {
        NSInteger index = arc4random() % 5;
        if (index != self.currentIndex) {
            return index;
        }
    }
    //    return index;
}
#pragma mark -- clickOnTheEvents

- (void)returnToTheFontController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextController:(UIButton *)sender
{
    SimpleViewController * simpleViewController = [[SimpleViewController alloc] init];
    [self.navigationController pushViewController:simpleViewController animated:YES];
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
        _remindLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 280, 100)];
        _remindLable.numberOfLines = 0;
        _remindLable.text = @"简单模式：请选择正确的图片或英文单词与之进行匹配，全部答完则会对您的测试进行分数统计。小朋友，加油哦！全部答对有奖励哦！";
        
        _remindLable.textColor = [UIColor whiteColor];
        _remindLable.backgroundColor = [UIColor redColor];
        [_remindLable.layer addAnimation:[self positionOfAnimation:CGPointMake(self.view.center.x, - 200)] forKey:@"position"];
        [_remindLable.layer addAnimation:[self scaleAnimation] forKey:@"scale"];
    }
    return _remindLable;
}

- (UILabel *)textLable
{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 230, 320, 40)];
        _textLable.textColor = [UIColor whiteColor];
        _textLable.backgroundColor = [UIColor orangeColor];
        _textLable.text = @"小朋友，请根据提示选择正确的选项：";
        [_textLable.layer addAnimation:[self positionOfAnimation:CGPointMake(-200, 270)] forKey:nil];
        
    }
    return _textLable;
}

- (UILabel *)wordLable
{
    if (!_wordLable) {
        _wordLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 280, 180, 40)];
        _wordLable.backgroundColor = [UIColor grayColor];
        _wordLable.textAlignment = NSTextAlignmentCenter;
        NSInteger i = [self.array[self.index] intValue];
        NSLog(@"i = %ld",i);
        _wordLable.text = self.words[i];
    }
    return _wordLable;
}

- (UIImageView *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 340, 80, 80)];
        [_imageView1 setImage:[UIImage imageNamed:self.images[self.currentIndex]]];
        NSLog(@"self.currentindex = %ld",self.currentIndex);
        
    }
    return _imageView1;
}

- (UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 340, 80, 80)];
        self.index1 = [self arcMethod];
        [_imageView2 setImage:[UIImage imageNamed:self.images[self.index1]]];
        NSLog(@"index = %ld",self.index1);
        
    }
    return _imageView2;
}

- (UIImageView *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 440, 80, 80)];
        for (int i = 0; ; i ++) {
            self.index2 = [self arcMethod];
            if (self.index2 != self.index1) {
                break;
            }
        }
        [_imageView3 setImage:[UIImage imageNamed:self.images[self.index2]]];
        NSLog(@"index2 = %ld",self.index2);
    }
    return _imageView3;
}

-(UIImageView *)imageView4
{
    if (!_imageView4) {
        _imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 440, 80, 80)];
        for (int i = 0; ; i ++) {
            self.index3 = [self arcMethod];
            if ((self.index3 != self.index1) && (self.index3 != self.index2)) {
                break;
            }
        }
        [_imageView4 setImage:[UIImage imageNamed:self.images[self.index3]]];
        NSLog(@"index3 = %ld",self.index3);
    }
    return _imageView4;
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
        _nextButton.frame = CGRectMake(200, 500, 100, 40);
        _nextButton.backgroundColor = [UIColor purpleColor];
        [_nextButton setTitle:@"下一页" forState:0];
        [_nextButton addTarget:self action:@selector(nextController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        [_backGroundImageView setImage:[UIImage imageNamed:@"简单模式背景"]];
    }
    return _backGroundImageView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
