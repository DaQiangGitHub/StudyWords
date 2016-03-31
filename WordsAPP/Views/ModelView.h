//
//  ModelView.h
//  WordsAPP
//
//  Created by rimi on 16/3/29.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelView : UIView

@property (nonatomic, strong)NSArray * array;

@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)NSInteger index1;
@property (nonatomic, assign)NSInteger index2;
@property (nonatomic, assign)NSInteger index3;
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)UILabel * wordLable;

@property (nonatomic, strong)UIButton * imageView1;
@property (nonatomic, strong)UIButton * imageView2;
@property (nonatomic, strong)UIButton * imageView3;
@property (nonatomic, strong)UIButton * imageView4;

@property (nonatomic, strong)UILabel * countLable;
@property (nonatomic, assign)NSInteger currentNumber;



- (void)netWorkingImageType:(NSInteger)type;
- (void)netWorkingNameType:(NSInteger)type;

@end
