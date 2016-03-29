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
@property (nonatomic, strong)UILabel * wordLable;
@property (nonatomic, strong)UIImageView * backGroundImageView;



@property (nonatomic, strong)UIButton * imageView1;
@property (nonatomic, strong)UIButton * imageView2;
@property (nonatomic, strong)UIButton * imageView3;
@property (nonatomic, strong)UIButton * imageView4;

@property (nonatomic, strong)UIButton * rightButton;

@property (nonatomic, strong)UIImageView * judgleImage;

@end

@implementation ModelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeUserInterface];
        [self initializeDataSource];
    }
    return self;
}

- (void)initializeDataSource
{
    self.currentIndex = arc4random() % 30;
}

- (void)initializeUserInterface
{
    
    [self addSubview:self.backGroundImageView];
    [self addSubview:self.rightButton];
    [self addSubview:self.textLable];
    
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

- (void)rightOfTheAnswer:(UIButton *)sender
{
    NSInteger i = [self.array[self.index] intValue];
    UIButton * button = (UIButton *)[self viewWithTag:100 + i];
    self.judgleImage.center = CGPointMake(button.center.x, button.center.y + 90);
    [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
    [self addSubview:self.judgleImage];
    [self.judgleImage.layer addAnimation:[self positionOfAnimation:CGPointMake(button.center.x, -200)] forKey:nil];
}

- (void)buttonPressed_ChoiceSelection:(UIButton *)sender
{
    NSLog(@"sender.tag = %ld",sender.tag);
    [[Networking alloc] getNameWithType:fruitWords index:(sender.tag - 100) successBlock:^(NSString *name) {
        if ([self.wordLable.text isEqualToString:name]) {
            
            [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
            self.judgleImage.center = CGPointMake(sender.center.x, sender.center.y + 90);
            [self addSubview:self.judgleImage];
            [self.judgleImage.layer addAnimation:[self positionOfAnimation:CGPointMake(sender.center.x, -200)] forKey:nil];
        }else{
            
            [self.judgleImage setImage:[UIImage imageNamed:@"错"]];
            [self addSubview:self.judgleImage];
            self.judgleImage.center = CGPointMake(sender.center.x, sender.center.y + 90);
            [self.judgleImage.layer addAnimation:[self positionOfAnimation:CGPointMake(sender.center.x, -200)] forKey:nil];
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

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAAnimation * animation = [self.textLable.layer animationForKey:@"textLable"];
    if (animation == anim) {
        
        [self addSubview:self.imageView1];
        [self.imageView1.layer addAnimation:[self positionOfAnimation:CGPointMake(-100, self.imageView1.center.y)] forKey:nil];
        [self addSubview:self.imageView2];
        [self.imageView2.layer addAnimation:[self positionOfAnimation:CGPointMake(600, self.imageView2.center.y)] forKey:nil];
        [self addSubview:self.imageView3];
        [self.imageView3.layer addAnimation:[self positionOfAnimation:CGPointMake(-100, self.imageView3.center.y)] forKey:nil];
        [self addSubview:self.imageView4];
        [self.imageView4.layer addAnimation:[self positionOfAnimation:CGPointMake(600, self.imageView4.center.y)] forKey:@"finally"];
    }
    animation = [self.imageView4.layer animationForKey:@"finally"];
    if (animation == anim) {
        [self addSubview:self.wordLable];
        [self.wordLable.layer addAnimation:[self positionOfAnimation:CGPointMake(CGRectGetWidth(self.frame), - 200)] forKey:nil];
    }
    
}

#pragma mark -- getter

- (UILabel *)textLable
{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 320, 40)];
        _textLable.textColor = [UIColor whiteColor];
        _textLable.backgroundColor = [UIColor orangeColor];
        _textLable.text = @"小朋友，请根据提示选择正确的选项：";
        [_textLable.layer addAnimation:[self positionOfAnimation:CGPointMake(290, -200)] forKey:@"textLable"];
        
    }
    return _textLable;
}

- (UILabel *)wordLable
{
    if (!_wordLable) {
        //读取单词
        _array = @[@(self.currentIndex),@(self.index1),@(self.index2),@(self.index3)];
        self.index = arc4random() % 4;
        NSLog(@"index = %ld",self.index);
        _wordLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 180, 40)];
        _wordLable.textColor = [UIColor orangeColor];
        _wordLable.font = [UIFont systemFontOfSize:24];
        _wordLable.textAlignment = NSTextAlignmentCenter;
        NSInteger i = [self.array[self.index] intValue];
        NSLog(@"i = %ld",i);
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
        _imageView1.frame = CGRectMake(50, 240, 120, 120);
        _imageView1.center = CGPointMake(110, 300);
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
        _imageView2.frame = CGRectMake(260, 240, 120, 120);
        _imageView2.center = CGPointMake(320, 300);
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
        _imageView3.frame = CGRectMake(50,430, 120, 120);
        _imageView3.center = CGPointMake(110, 490);
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
        _imageView4.frame = CGRectMake(260, 430, 120, 120);
        _imageView4.center = CGPointMake(320,490);
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

@end



