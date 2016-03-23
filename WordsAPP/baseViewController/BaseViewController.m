//
//  BaseViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "BaseViewController.h"

#define SCREEN_W self.view.bounds.size.width
#define SCREEN_H self.view.bounds.size.height
#define BAR_H self.barView.bounds.size.height
#define COLOR(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1]


@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = COLOR(233, 233, 233);
    
    [self initalizeInterface];
    
}

- (void)initalizeInterface{
    
    [self.view addSubview:self.barView];
    [self.view addSubview:self.barLable];
    [self.view addSubview:self.barLeftButton];
    [self.view addSubview:self.barRightButton];
}

#pragma mark - getter
- (UIView *)barView{
    if (!_barView) {
        _barView = ({
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, BAR_H)];
            view.backgroundColor = [UIColor whiteColor];
            
            view;
        });
    }
    return _barView;
}
- (UILabel *)barLable{
    if (!_barLable) {
        _barLable = ({
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
            lable.center = CGPointMake(self.view.center.x, 10);
            lable.backgroundColor = [UIColor blueColor];
            lable.font = [UIFont systemFontOfSize:25];
            
            lable;
        });
    }
    return _barLable;
}
- (UIButton *)barLeftButton{
    if (!_barLeftButton) {
        _barLeftButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 15, 40, 40);
            button.backgroundColor = [UIColor orangeColor];
            
            button;
        });
    }
    return _barLeftButton;
}
- (UIButton *)barRightButton{
    if (!_barRightButton) {
        _barRightButton = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(SCREEN_W - 50, 15, 40, 40);
            button.backgroundColor = [UIColor orangeColor];
            
            button;
        });
    }
    return _barRightButton;
}

@end
