//
//  BaseViewController.h
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>



#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define BAR_H 60
#define COLOR(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1]




@interface BaseViewController : UIViewController


@property (nonatomic, strong) UIView * barView;
@property (nonatomic, strong) UILabel * barLable;
@property (nonatomic, strong) UIButton * barLeftButton;
@property (nonatomic, strong) UIButton * barRightButton;




@end
