//
//  SimpleViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/24.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "SimpleViewController.h"
#import "Networking.h"

@interface SimpleViewController ()

@property (nonatomic, strong)UILabel * remindLable;
@property (nonatomic, strong)UILabel * textLable;
@property (nonatomic, strong)UILabel * wordLable;
@property (nonatomic, strong)UIImageView * backGroundImageView;

@property (nonatomic, strong)NSArray * array;

@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)NSInteger index1;
@property (nonatomic, assign)NSInteger index2;
@property (nonatomic, assign)NSInteger index3;
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)UIButton * imageView1;
@property (nonatomic, strong)UIButton * imageView2;
@property (nonatomic, strong)UIButton * imageView3;
@property (nonatomic, strong)UIButton * imageView4;

@property (nonatomic, strong)UIButton * backButton;
@property (nonatomic, strong)UIButton * rightButton;

@property (nonatomic, strong)UIImageView * judgleImage;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
    
}

- (void)initializeDataSource
{
    self.currentIndex = arc4random() % 30;
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
    [self.view addSubview:self.rightButton];
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
        NSInteger index = arc4random() % 30;
        if (index != self.currentIndex) {
            return index;
        }
    }
}
#pragma mark -- clickOnTheEvents

- (void)returnToTheFontController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightOfTheAnswer:(UIButton *)sender
{
    NSInteger i = [self.array[self.index] intValue];
    UIButton * button = (UIButton *)[self.view viewWithTag:100 + i];
    self.judgleImage.frame = button.frame;
    [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
    [self.judgleImage.layer addAnimation:[self positionOfAnimation:CGPointMake(400, -200)] forKey:nil];
}

- (void)buttonPressed_ChoiceSelection:(UIButton *)sender
{
    NSLog(@"sender.tag = %ld",sender.tag);
    [[Networking alloc] getNameWithType:fruitWords index:(sender.tag - 100) successBlock:^(NSString *name) {
        if ([self.wordLable.text isEqualToString:name]) {
            
            [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
            self.judgleImage.frame = sender.frame;
            [self.view addSubview:self.judgleImage];
            [self.judgleImage.layer addAnimation:[self positionOfAnimation:CGPointMake(400, -200)] forKey:nil];
        }else{
            
            [self.judgleImage setImage:[UIImage imageNamed:@"错"]];
            [self.view addSubview:self.judgleImage];
            self.judgleImage.frame = sender.frame;
            [self.judgleImage.layer addAnimation:[self positionOfAnimation:CGPointMake(0, -200)] forKey:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
        _wordLable.textColor = [UIColor orangeColor];
        _wordLable.font = [UIFont systemFontOfSize:24];
        _wordLable.textAlignment = NSTextAlignmentCenter;
        NSInteger i = [self.array[self.index] intValue];
        [[Networking alloc] getNameWithType:fruitWords index:i successBlock:^(NSString *name) {
            _wordLable.text = name;
       } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
//        NSLog(@"i = %ld",i);
//        _wordLable.text = self.words[i];
    }
    return _wordLable;
}

- (UIButton *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [UIButton buttonWithType:0];
        _imageView1.frame = CGRectMake(50, 340, 120, 120);
        _imageView1.center = CGPointMake(110, 400);
        [[Networking alloc] getimageType:fruit index:self.currentIndex success:^(UIImage *image) {
            [_imageView1 setImage:image forState:0];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [_imageView1 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView1.tag = 100 + self.currentIndex;
        NSLog(@"self.currentindex = %ld",self.currentIndex);
        
    }
    return _imageView1;
}

- (UIButton *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [UIButton buttonWithType:0];
        _imageView2.frame = CGRectMake(260, 340, 120, 120);
        _imageView2.center = CGPointMake(320, 400);
        self.index1 = [self arcMethod];
        [[Networking alloc] getimageType:fruit index:self.index1 success:^(UIImage *image) {
            [_imageView2 setImage:image forState:0];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [_imageView2 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView2.tag = 100 + self.index1;
        NSLog(@"index1 = %ld",self.index1);
        
    }
    return _imageView2;
}

- (UIButton *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [UIButton buttonWithType:0];
        _imageView3.frame = CGRectMake(50, 480, 120, 120);
        _imageView3.center = CGPointMake(110, 540);
        for (int i = 0; ; i ++) {
            self.index2 = [self arcMethod];
            if (self.index2 != self.index1) {
                break;
            }
        }
        [[Networking alloc] getimageType:fruit index:self.index2 success:^(UIImage *image) {
            [_imageView3 setImage:image forState:0];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [_imageView3 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView3.tag = 100 + self.index2;
        NSLog(@"index2 = %ld",self.index2);
    }
    return _imageView3;
}

-(UIButton *)imageView4
{
    if (!_imageView4) {
        _imageView4 = [UIButton buttonWithType:0];
        _imageView4.frame = CGRectMake(260, 480, 120, 120);
        _imageView4.center = CGPointMake(320,540);
        for (int i = 0; ; i ++) {
            self.index3 = [self arcMethod];
            if ((self.index3 != self.index1) && (self.index3 != self.index2)) {
                break;
            }
        }
        [[Networking alloc] getimageType:fruit index:self.index3 success:^(UIImage *image) {
            [_imageView4 setImage:image forState:0];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [_imageView4 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView4.tag = 100 + self.index3;
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

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:0];
        _rightButton.frame = CGRectMake(200, 650, 100, 40);
        [_rightButton setTitle:@"查看\n正确答案" forState:0];
        _rightButton.titleLabel.numberOfLines = 0;
        _rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_rightButton addTarget:self action:@selector(rightOfTheAnswer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        [_backGroundImageView setImage:[UIImage imageNamed:@"简单模式背景"]];
    }
    return _backGroundImageView;
}

- (UIImageView *)judgleImage
{
    if (!_judgleImage) {
        _judgleImage = [[UIImageView alloc] initWithFrame:CGRectMake(400, -200, 80, 80)];
    }
    return _judgleImage;
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
