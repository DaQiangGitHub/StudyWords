//
//  ModelView.m
//  WordsAPP
//
//  Created by rimi on 16/3/29.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "ModelView.h"
#import "Networking.h"

@interface ModelView ()

@property (nonatomic, strong)UILabel * textLable;
@property (nonatomic, strong)UIImageView * backGroundImageView;
@property (nonatomic, strong)NSMutableArray * words;
@property (nonatomic, strong)UIButton * rightButton;
@property (nonatomic, strong)UIButton * nextButton;
@property (nonatomic, strong)UIButton * completeButton;
@property (nonatomic, strong)UIImageView * judgleImage;

@property (nonatomic, strong)UILabel * scoreLable;



@end

@implementation ModelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeDataSource];
        [self initializeUserInterface];
        
    }
    return self;
}

- (void)initializeDataSource
{
    
    _words = [NSMutableArray array];
}

- (void)initializeUserInterface
{
    
    [self addSubview:self.backGroundImageView];
    [self addSubview:self.rightButton];
    [self addSubview:self.textLable];
    
    
    [self netWorkingImageType:0];
    [self netWorkingNameType:0];
    [self addSubview:self.imageView1];
    [self addSubview:self.imageView2];
    [self addSubview:self.imageView3];
    [self addSubview:self.imageView4];
    [self addSubview:self.wordLable];
    
    [self addSubview:self.countLable];
    [self addSubview:self.nextButton];
    [self addSubview:self.completeButton];
    [self addSubview:self.judgleImage];
    [self begainAnimatinon];
    [self addSubview:self.scoreLable];
    
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

- (void)netWorkingImageType:(NSInteger)type
{
    self.currentIndex = arc4random() % 30;
    self.imageView1.tag = 100 + self.currentIndex;
    NSLog(@"self.currentindex = %ld",self.currentIndex);
    [[Networking alloc] getimageType:fruit index:self.currentIndex success:^(UIImage *image) {
        [self.imageView1 setImage:image forState:0];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    self.index1 = [self arcMethod];
    NSLog(@"index1 = %ld",self.index1);
    self.imageView2.tag = 100 + self.index1;
    [[Networking alloc] getimageType:fruit index:self.index1 success:^(UIImage *image) {
        [self.imageView2 setImage:image forState:0];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    self.index2 = [self arcMethod];
    NSLog(@"index2 = %ld",self.index2);
    self.imageView3.tag = 100 + self.index2;
    [[Networking alloc] getimageType:fruit index:self.index2 success:^(UIImage *image) {
        [self.imageView3 setImage:image forState:0];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    for (int i = 0; ; i ++) {
        self.index3 = [self arcMethod];
        if ((self.index3 != self.index1) && (self.index3 != self.index2)) {
            break;
        }
    }
    NSLog(@"index3 = %ld",self.index3);
    self.imageView4.tag = 100 + self.index3;
    [[Networking alloc] getimageType:fruit index:self.index3 success:^(UIImage *image) {
        [self.imageView4 setImage:image forState:0];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)netWorkingNameType:(NSInteger)type
{
    //读取单词
    _array = @[@(self.currentIndex),@(self.index1),@(self.index2),@(self.index3)];
    self.index = arc4random() % 4;
    NSLog(@"index = %ld",self.index);
    NSInteger index = [self.array[self.index] intValue];
    for (int i = 0; i < _words.count; i ++) {
        if (index  == [_words[i] intValue]) {
            self.currentNumber --;
            [self buttonPressed_NextTopic:nil];
            return;
        }
    }
    [_words addObject:@(index)];
    NSLog(@"_words = %@",_words);
    NSLog(@"i = %ld",index);
    [[Networking alloc] getNameWithType:fruitWords index:index successBlock:^(NSString *name) {
        self.wordLable.text = name;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -- clickOnTheEvents

- (void)rightOfTheAnswer:(UIButton *)sender
{
    NSInteger i = [self.array[self.index] intValue];
    UIButton * button = (UIButton *)[self viewWithTag:100 + i];
    self.judgleImage.center = CGPointMake(button.center.x, button.center.y + 90);
    [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
    self.judgleImage.hidden = NO;
}

- (void)buttonPressed_ChoiceSelection:(UIButton *)sender
{
    NSLog(@"sender.tag = %ld",sender.tag);
    [[Networking alloc] getNameWithType:fruitWords index:(sender.tag - 100) successBlock:^(NSString *name) {
        if ([self.wordLable.text isEqualToString:name]) {
            
            [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
            self.judgleImage.hidden = NO;
            self.judgleImage.center = CGPointMake(sender.center.x, sender.center.y + 90);
            NSInteger score ;
            score = score + 10;
            NSString * string = @"分数：";
            NSString * string2 = [NSString stringWithFormat:@"%ld",score];
            NSString * scoreString = [string stringByAppendingString:string2];
            self.scoreLable.text = scoreString;
        }else{
            
            [self.judgleImage setImage:[UIImage imageNamed:@"错"]];
            self.judgleImage.hidden = NO;
            self.judgleImage.center = CGPointMake(sender.center.x, sender.center.y + 90);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)buttonPressed_NextTopic:(UIButton *)sender
{
    self.currentNumber ++;
    [self netWorkingImageType:fruit];
    [self netWorkingNameType:fruit];
    NSLog(@"currentIndex = %ld",self.currentNumber);
    NSString * number = [NSString stringWithFormat:@"%ld",self.currentNumber];
    NSString * string = [number stringByAppendingString:@"   题"];
    self.countLable.text = string;
    self.judgleImage.hidden = YES;
    [self begainAnimatinon];
    if (self.currentNumber == 10) {
        self.nextButton.hidden = YES;
        self.completeButton.hidden = NO;
        
    }
    
}

- (void)buttonPressed_completeTheTopic:(UIButton *)sender
{
    NSLog(@"提交成功");
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

- (void)begainAnimatinon
{
    [self.imageView1.layer addAnimation:[self positionOfAnimation:CGPointMake(-100, self.imageView1.center.y)] forKey:nil];
    [self.imageView2.layer addAnimation:[self positionOfAnimation:CGPointMake(600, self.imageView2.center.y)] forKey:nil];
    [self.imageView3.layer addAnimation:[self positionOfAnimation:CGPointMake(-100, self.imageView3.center.y)] forKey:nil];
    [self.imageView4.layer addAnimation:[self positionOfAnimation:CGPointMake(600, self.imageView4.center.y)] forKey:@"finally"];
}

#pragma mark -- getter

- (UILabel *)textLable
{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 320, 40)];
        _textLable.textColor = [UIColor whiteColor];
        _textLable.backgroundColor = [UIColor orangeColor];
        _textLable.text = @"小朋友，请根据提示选择正确的选项：";
        
    }
    return _textLable;
}

- (UILabel *)wordLable
{
    if (!_wordLable) {
        
        _wordLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 180, 40)];
        _wordLable.textColor = [UIColor orangeColor];
        _wordLable.font = [UIFont systemFontOfSize:24];
        _wordLable.textAlignment = NSTextAlignmentCenter;
        
    }
    return _wordLable;
}

- (UIButton *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [UIButton buttonWithType:0];
        _imageView1.frame = CGRectMake(50, 240, 120, 120);
        _imageView1.center = CGPointMake(110, 300);
        [_imageView1 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView1.tag = 100 + self.currentIndex;
        
        
    }
    return _imageView1;
}

- (UIButton *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [UIButton buttonWithType:0];
        _imageView2.frame = CGRectMake(260, 240, 120, 120);
        _imageView2.center = CGPointMake(320, 300);
        [_imageView2 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _imageView2;
}

- (UIButton *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [UIButton buttonWithType:0];
        _imageView3.frame = CGRectMake(50,430, 120, 120);
        _imageView3.center = CGPointMake(110, 490);
        for (int i = 0; ; i ++) {
            
            if (self.index2 != self.index1) {
                break;
            }
        }
        [_imageView3 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _imageView3;
}

-(UIButton *)imageView4
{
    if (!_imageView4) {
        _imageView4 = [UIButton buttonWithType:0];
        _imageView4.frame = CGRectMake(260, 430, 120, 120);
        _imageView4.center = CGPointMake(320,490);
        [_imageView4 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageView4;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:0];
        _rightButton.frame = CGRectMake(200, 650, 100, 40);
        [_rightButton setTitle:@"    查看\n正确答案" forState:0];
        _rightButton.titleLabel.numberOfLines = 0;
        _rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_rightButton addTarget:self action:@selector(rightOfTheAnswer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [_backGroundImageView setImage:[UIImage imageNamed:@"简单模式背景"]];
    }
    return _backGroundImageView;
}

- (UIImageView *)judgleImage
{
    if (!_judgleImage) {
        _judgleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    }
    return _judgleImage;
}

- (UILabel *)countLable
{
    if (!_countLable) {
        _countLable = [[UILabel alloc] initWithFrame:CGRectMake(300, 60, 100, 60)];
        _countLable.backgroundColor = [UIColor greenColor];
        _countLable.text = @"1  题";
        _countLable.textAlignment = NSTextAlignmentCenter;
    }
    return _countLable;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:0];
        _nextButton.frame = CGRectMake(100, 650, 100, 40);
        [_nextButton setTitle:@"下一题" forState:0];
        [_nextButton addTarget:self action:@selector(buttonPressed_NextTopic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIButton *)completeButton
{
    if (!_completeButton) {
        _completeButton = [UIButton buttonWithType:0];
        _completeButton.frame = CGRectMake(100, 650, 100, 40);
        [_completeButton setTitle:@"完成并提交" forState:0];
        _completeButton.backgroundColor = [UIColor redColor];
        [_completeButton addTarget:self action:@selector(buttonPressed_completeTheTopic:) forControlEvents:UIControlEventTouchUpInside];
        _completeButton.hidden = YES;
    }
    return _completeButton;
}
- (UILabel *)scoreLable
{
    if (!_scoreLable) {
        _scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 60)];
        _scoreLable.text = @"分数：00";
        _scoreLable.backgroundColor = [UIColor redColor];
        _scoreLable.textColor = [UIColor whiteColor];
    }
    return _scoreLable;
}

@end



