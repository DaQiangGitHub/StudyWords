//
//  ModelView.h
//  WordsAPP
//
//  Created by rimi on 16/3/29.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompleteView.h"

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


@property (nonatomic, strong)CompleteView * completeView;

@property (nonatomic, assign)NSInteger nameType;
@property (nonatomic, assign)NSInteger imageType;

@property (nonatomic, assign)NSInteger isRecord;

- (instancetype)initWithFrame:(CGRect)frame imageType:(NSInteger)imageType nameType:(NSInteger)nameType isRecord:(NSInteger)isRecord dic:(NSDictionary *)dic;
- (instancetype)initWithFrame:(CGRect)frame imageType:(NSInteger)imageType nameType:(NSInteger)nameType;
- (void)netWorkingImageType:(NSInteger)type;
- (void)netWorkingNameType:(NSInteger)type;

@end
