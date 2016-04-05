//
//  ModelView.m
//  WordsAPP
//
//  Created by rimi on 16/3/29.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "ModelView.h"
#import "Networking.h"
#import "CompleteView.h"

@interface ModelView ()

@property (nonatomic, strong)UIImageView * textImageview;
@property (nonatomic, strong)UIImageView * backGroundImageView;
@property (nonatomic, strong)NSMutableArray * words;
@property (nonatomic, strong)UIButton * rightButton;
@property (nonatomic, strong)UIButton * nextButton;
@property (nonatomic, strong)UIButton * completeButton;
@property (nonatomic, strong)UIImageView * judgleImage;

@property (nonatomic, strong)UILabel * scoreLable;
@property (nonatomic, assign)NSInteger score;

@property (nonatomic, assign)NSInteger isTure;

@property (nonatomic,strong)UIButton *returnButton;

@property (nonatomic, strong)NSDictionary * dictionary;
@property (nonatomic, strong)NSDictionary * dictionary1;
@property (nonatomic, strong)NSMutableArray * answerArray;
@property (nonatomic, strong)NSArray * answerArray1;

@property (nonatomic, strong)NSDictionary * wrongDictionary;
@property (nonatomic, strong)NSArray * wrongArray;
@property (nonatomic, assign)NSInteger i;
@property (nonatomic, strong)NSString * stringIndex;




@end

@implementation ModelView

- (instancetype)initWithFrame:(CGRect)frame imageType:(NSInteger)imageType nameType:(NSInteger)nameType
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameType = nameType;
        _imageType = imageType;
        [self initializeDataSource];
        [self initializeUserInterface];
        
    }
    return self;
}

- (void)initializeDataSource
{
    
    _words = [NSMutableArray array];
    _score = 0;
    _isTure = 0;
    _currentNumber = 1;
    
    _dictionary = [NSDictionary dictionary];
    _dictionary1 = [NSDictionary dictionary];
    _answerArray = [NSMutableArray array];
    _answerArray1 = [NSArray array];
    _wrongDictionary = [NSDictionary dictionary];
    _wrongArray = [NSArray array];
}

- (void)initializeUserInterface
{
    
    [self addSubview:self.backGroundImageView];
    [self addSubview:self.rightButton];
    [self addSubview:self.textImageview];
    
    
    [self netWorkingImageType:self.imageType];
    [self netWorkingNameType:self.nameType];
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
    NSLog(@"self.currentindex = %ld",(long)self.currentIndex);
    [[Networking alloc] getimageType:self.imageType index:self.currentIndex success:^(UIImage *image) {
        [self.imageView1 setImage:image forState:0];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    self.index1 = [self arcMethod];
    NSLog(@"index1 = %ld",(long)self.index1);
    self.imageView2.tag = 100 + self.index1;
    [[Networking alloc] getimageType:self.imageType index:self.index1 success:^(UIImage *image) {
        [self.imageView2 setImage:image forState:0];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    self.index2 = [self arcMethod];
    for (int i = 0; ; i ++) {
        self.index2 = [self arcMethod];
        if (self.index2 != self.index1) {
            break;
        }
    }
    NSLog(@"index2 = %ld",(long)self.index2);
    self.imageView3.tag = 100 + self.index2;
    [[Networking alloc] getimageType:self.imageType index:self.index2 success:^(UIImage *image) {
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
    NSLog(@"index3 = %ld",(long)self.index3);
    self.imageView4.tag = 100 + self.index3;
    [[Networking alloc] getimageType:self.imageType index:self.index3 success:^(UIImage *image) {
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
    NSLog(@"index = %ld",(long)self.index);
    NSInteger index = [self.array[self.index] intValue];
    self.i = index;
    self.stringIndex = [NSString stringWithFormat:@"%ld",index];
    for (int i = 0; i < _words.count; i ++) {
        if (index  == [_words[i] intValue]) {
            self.currentNumber --;
            [self buttonPressed_NextTopic:nil];
            return;
        }
    }
    [_words addObject:@(index)];
    NSLog(@"_words = %@",_words);
    NSLog(@"i = %ld",(long)index);
    [[Networking alloc] getNameWithType:type index:index successBlock:^(NSString *name) {
        self.wordLable.text = name;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //数据处理
    self.answerArray1 = @[@(self.currentIndex),@(self.index1),@(self.index2),@(self.index3)];
    self.dictionary1 = @{self.stringIndex:self.answerArray1};
    [self.answerArray addObject:self.dictionary1];
    self.dictionary = @{@"type":@(self.nameType),@"level":@(0),@"score":@(self.score),@"questions":self.answerArray};
    NSLog(@"dictionary = %@",self.dictionary);
    
}
#pragma mark -- clickOnTheEvents

- (void)rightOfTheAnswer:(UIButton *)sender
{
    NSInteger i = [self.array[self.index] intValue];
    UIButton * button = (UIButton *)[self viewWithTag:100 + i];
    self.judgleImage.center = CGPointMake(button.center.x + 55 * MAINSCREEN_RATE, button.center.y + 30 * MAINSCREEN_RATE);
    [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
    self.judgleImage.hidden = NO;
}

- (void)buttonPressed_ChoiceSelection:(UIButton *)sender
{
    if (self.isTure == 1) {
        return;
    }
    NSLog(@"sender.tag = %ld",(long)sender.tag);
    [[Networking alloc] getNameWithType:self.nameType index:(sender.tag - 100) successBlock:^(NSString *name) {
        if ([self.wordLable.text isEqualToString:name]) {
            
            [self.judgleImage setImage:[UIImage imageNamed:@"对"]];
            self.judgleImage.hidden = NO;
            self.judgleImage.center = CGPointMake(sender.center.x + 55 * MAINSCREEN_RATE, sender.center.y + 30 * MAINSCREEN_RATE);
            self.score = self.score + 10;
            NSString * string = @"分数：";
            NSString * string2 = [NSString stringWithFormat:@"%ld",(long)self.score];
            NSString * scoreString = [string stringByAppendingString:string2];
            self.scoreLable.text = scoreString;
            if (self.currentNumber != 10) {
                [self performSelector:@selector(buttonPressed_NextTopic:) withObject:nil afterDelay:1];
            }
        }else{
            
            [self.judgleImage setImage:[UIImage imageNamed:@"错"]];
            self.judgleImage.hidden = NO;
            self.judgleImage.center = CGPointMake(sender.center.x + 55 * MAINSCREEN_RATE, sender.center.y + 30 * MAINSCREEN_RATE);
            
            //数据处理
            self.wrongArray = @[@(self.currentIndex),@(self.index1),@(self.index2),@(self.index3)];
            self.wrongDictionary = @{@"type":@(self.nameType),@"level":@(0),self.stringIndex:self.wrongDictionary};
            NSLog(@"wrongArray = %@",self.wrongDictionary);
            [[Networking alloc] addMistakeWithQuestion:self.wrongDictionary successBlock:^(BOOL succeed) {
                NSLog(@"succeed!");
            } failure:^(NSError *error) {
                NSLog(@"ERROR!");
            }];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    self.isTure = 1;
}

- (void)buttonPressed_NextTopic:(UIButton *)sender
{
    if (self.isTure == 0) {
        //保存数据
        self.wrongArray = @[@(self.currentIndex),@(self.index1),@(self.index2),@(self.index3)];
        self.wrongDictionary = @{@"type":@(self.nameType),@"level":@(0),self.stringIndex:self.wrongArray};
        NSLog(@"wrongArray = %@",self.wrongArray);
        [[Networking alloc] addMistakeWithQuestion:self.wrongDictionary successBlock:^(BOOL succeed) {
            NSLog(@"succeed!");
        } failure:^(NSError *error) {
            NSLog(@"ERROR!");
        }];
    }
    self.isTure = 0;
    self.currentNumber ++;
    [self netWorkingImageType:self.imageType];
    [self netWorkingNameType:self.nameType];
    NSLog(@"currentIndex = %ld",(long)self.currentNumber);
    NSString * number = [NSString stringWithFormat:@"%ld",(long)self.currentNumber];
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
    [[Networking alloc] addRecordWithQuestions:self.dictionary successBlock:^(BOOL succeed) {
        NSLog(@"succeed!");
    } failure:^(NSError *error) {
        NSLog(@"ERROR!");
    }];
    [self addSubview:self.completeView];
    self.completeView.scoreLable.text = self.scoreLable.text;
    if (self.score < 60) {
        [self.completeView.courageImageview setImage:[UIImage imageNamed:@"未及格"]];
    }else if (self.score < 80){
        [self.completeView.courageImageview setImage:[UIImage imageNamed:@"及格"]];
    }else if (self.score < 100){
        [self.completeView.courageImageview setImage:[UIImage imageNamed:@"优秀"]];
    }else{
        [self.completeView.courageImageview setImage:[UIImage imageNamed:@"棒"]];
    }
    
}
#pragma mark -- animation
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
    [self.imageView1.layer addAnimation:[self positionOfAnimation:CGPointMake(-100 * MAINSCREEN_RATE, self.imageView1.center.y)] forKey:nil];
    [self.imageView2.layer addAnimation:[self positionOfAnimation:CGPointMake(600 * MAINSCREEN_RATE, self.imageView2.center.y)] forKey:nil];
    [self.imageView3.layer addAnimation:[self positionOfAnimation:CGPointMake(-100 * MAINSCREEN_RATE, self.imageView3.center.y)] forKey:nil];
    [self.imageView4.layer addAnimation:[self positionOfAnimation:CGPointMake(600 * MAINSCREEN_RATE, self.imageView4.center.y)] forKey:@"finally"];
}



#pragma mark -- getter

- (UIImageView *)textImageview
{
    if (!_textImageview) {
        _textImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"提示.png"]];
        _textImageview.frame = CGRectMake(90 * MAINSCREEN_RATE, 140 * MAINSCREEN_RATE, 300* MAINSCREEN_RATE, 50 * MAINSCREEN_RATE);
    }
    return _textImageview;
}
- (UILabel *)wordLable
{
    if (!_wordLable) {
        
        _wordLable = [[UILabel alloc] initWithFrame:CGRectMake(130 * MAINSCREEN_RATE, 210 * MAINSCREEN_RATE, 200 * MAINSCREEN_RATE, 40 * MAINSCREEN_RATE)];
        _wordLable.textColor = [UIColor orangeColor];
        _wordLable.font = [UIFont systemFontOfSize:30 * MAINSCREEN_RATE];
        _wordLable.textAlignment = NSTextAlignmentCenter;
        
    }
    return _wordLable;
}

- (UIButton *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [UIButton buttonWithType:0];
        _imageView1.frame = CGRectMake(50 * MAINSCREEN_RATE, 240 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _imageView1.center = CGPointMake(110 * MAINSCREEN_RATE, 330 * MAINSCREEN_RATE);
        _imageView1.layer.cornerRadius = 10;
        _imageView1.layer.masksToBounds = YES;
        [_imageView1 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView1.tag = 100 + self.currentIndex;
        
        
    }
    return _imageView1;
}

- (UIButton *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [UIButton buttonWithType:0];
        _imageView2.frame = CGRectMake(0,0, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _imageView2.center = CGPointMake(320 * MAINSCREEN_RATE, 330 * MAINSCREEN_RATE);
        _imageView2.layer.cornerRadius = 10;
        _imageView2.layer.masksToBounds = YES;
        [_imageView2 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _imageView2;
}

- (UIButton *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [UIButton buttonWithType:0];
        _imageView3.frame = CGRectMake(0,0, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _imageView3.center = CGPointMake(110 * MAINSCREEN_RATE, 520 * MAINSCREEN_RATE);
        for (int i = 0; ; i ++) {
            
            if (self.index2 != self.index1) {
                break;
            }
        }
        [_imageView3 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
        _imageView3.layer.cornerRadius = 10;
        _imageView3.layer.masksToBounds = YES;
    }
    return _imageView3;
}

-(UIButton *)imageView4
{
    if (!_imageView4) {
        _imageView4 = [UIButton buttonWithType:0];
        _imageView4.frame = CGRectMake(0, 0, 120 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE);
        _imageView4.center = CGPointMake(320 * MAINSCREEN_RATE,520 * MAINSCREEN_RATE);
        _imageView4.layer.cornerRadius = 10;
        _imageView4.layer.masksToBounds = YES;
        [_imageView4 addTarget:self action:@selector(buttonPressed_ChoiceSelection:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageView4;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:0];
        _rightButton.frame = CGRectMake(240 * MAINSCREEN_RATE, 650 * MAINSCREEN_RATE, 100 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
        [_rightButton setImage:[UIImage imageNamed:@"查看正确答案"] forState:UIControlStateNormal];
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
        _judgleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60 * MAINSCREEN_RATE, 60 * MAINSCREEN_RATE)];
    }
    return _judgleImage;
}

- (UILabel *)countLable
{
    if (!_countLable) {
        _countLable = [[UILabel alloc] initWithFrame:CGRectMake(300 * MAINSCREEN_RATE, 60 * MAINSCREEN_RATE, 100 * MAINSCREEN_RATE, 60 * MAINSCREEN_RATE)];
        _countLable.text = @"1  题";
        _countLable.textColor = [UIColor colorWithRed:82 / 255.0 green:35 / 255.0 blue:83 / 255.0 alpha:1];
        _countLable.font = [UIFont systemFontOfSize:28 * MAINSCREEN_RATE];
        _countLable.textAlignment = NSTextAlignmentCenter;
    }
    return _countLable;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:0];
        _nextButton.frame = CGRectMake(60 * MAINSCREEN_RATE, 650 * MAINSCREEN_RATE, 120 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
        [_nextButton setImage:[UIImage imageNamed:@"下一题"] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(buttonPressed_NextTopic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIButton *)completeButton
{
    if (!_completeButton) {
        _completeButton = [UIButton buttonWithType:0];
        _completeButton.frame = CGRectMake(100 * MAINSCREEN_RATE, 650 * MAINSCREEN_RATE, 100 * MAINSCREEN_RATE, 40 * MAINSCREEN_RATE);
        [_completeButton setImage:[UIImage imageNamed:@"完成并提交"] forState:UIControlStateNormal];
        
        [_completeButton addTarget:self action:@selector(buttonPressed_completeTheTopic:) forControlEvents:UIControlEventTouchUpInside];
        _completeButton.hidden = YES;
    }
    return _completeButton;
}
- (UILabel *)scoreLable
{
    if (!_scoreLable) {
        _scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(50 * MAINSCREEN_RATE, 60 * MAINSCREEN_RATE, 150 * MAINSCREEN_RATE, 60 * MAINSCREEN_RATE)];
        _scoreLable.text = @"分数：00";
        _scoreLable.font = [UIFont systemFontOfSize:28 * MAINSCREEN_RATE];
        _scoreLable.textColor = [UIColor colorWithRed:82 / 255.0 green:35 / 255.0 blue:83 / 255.0 alpha:1];
    }
    return _scoreLable;
}

- (CompleteView *)completeView
{
    if (!_completeView) {
        _completeView = [[CompleteView alloc] initWithFrame:self.frame];
        
    }
    return _completeView;
}

//- (UIButton *)returnButton{
//    if (!_returnButton) {
//        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _returnButton.frame = CGRectMake(30 * MAINSCREEN_RATE, 60 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE, 70 * MAINSCREEN_RATE);
//        [_returnButton setImage:[UIImage imageNamed:@"返回1"] forState:UIControlStateNormal];
//        [_returnButton addTarget:self action:@selector(returnButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _returnButton;
//}
@end



