//
//  recordViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "recordViewController.h"
#import "Networking.h"

#define url @"http://ac-mc2fvx3y.clouddn.com/WjJOAHRljlXqwEibBq0oJWD.png"

@interface recordViewController ()


@property (nonatomic, retain) UIImageView * backImage;

@end

@implementation recordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.barLable.text = @"重新答题";
    self.barView.hidden = YES;
    self.barLable.hidden = YES;
    
    [self.view addSubview:self.backImage];
    
    
}

#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
            imageView.image = [UIImage imageNamed:@"背景6.jpg"];

            [[Networking alloc] getimageType:animals index:2 success:^(UIImage *image) {
                imageView.image = image;
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

            imageView;
        });
    }
    return _backImage;
}

@end
