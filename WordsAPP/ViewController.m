//
//  ViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UserViewController.h"


@interface ViewController ()


@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * nameLable;
@property (nonatomic, strong) UIButton * buttonIn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self initalizeInterface];
    
}

- (void)initalizeInterface{
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.nameLable];
    [self.view addSubview:self.buttonIn];
}

- (void)buttonInPressed{

}


#pragma mark - getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            
            imageView;
        });
    }
    return _backImageView;
}
- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = ({
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
            lable.center = CGPointMake(self.view.center.x, 100);
            lable.backgroundColor = [UIColor blueColor];
            
            lable;
        });
    }
    return _nameLable;
}
- (UIButton *)buttonIn{
    if (!_buttonIn) {
        _buttonIn = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 150, 50);
            button.center = CGPointMake(self.view.center.x, 500);
            button.backgroundColor = [UIColor orangeColor];
            [button addTarget:self action:@selector(buttonInPressed) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _buttonIn;
}

@end
