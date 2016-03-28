//
//  recordViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "recordViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

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
            
            
           
            
            AVQuery *query = [AVQuery queryWithClassName:@"data"];
            [query whereKey:@"objectId" equalTo:DATAID];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects) {
                    NSArray<AVObject *> *priorityEqualsZeroTodos = objects;
                    NSArray * images = priorityEqualsZeroTodos[0][@"sport"];
                    NSString * imageTitle = images[1];
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageTitle]];
                    imageView.image = [UIImage imageWithData:data];

                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
                    NSArray * words = priorityEqualsZeroTodos[0][@"sportWords"];
                    label.text = words[1];
                    [_backImage addSubview:label];
                }
                
            }];
            
            
            imageView;
        });
    }
    return _backImage;
}

@end
