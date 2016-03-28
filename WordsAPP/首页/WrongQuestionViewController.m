//
//  WrongQuestionViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "WrongQuestionViewController.h"

@interface WrongQuestionViewController ()


@property (nonatomic, retain) UIImageView * backImage;


@end

@implementation WrongQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.barLable.text = @"错题";
    self.barView.hidden = YES;
    self.barLable.hidden = YES;
    
    [self.view addSubview:self.backImage];
}

#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
            imageView.image = [UIImage imageNamed:@"背景2.jpg"];
            imageView;
        });
    }
    return _backImage;
}
@end
