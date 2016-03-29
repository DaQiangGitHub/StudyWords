//
//  QuestionsView.m
//  WordsAPP
//
//  Created by rimi on 16/3/29.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "QuestionsView.h"
#import "Networking.h"

@interface QuestionsView ()

@property (nonatomic, retain) UIImageView * questionImage;
@property (nonatomic, retain) UILabel * tabA;
@property (nonatomic, retain) UILabel * tabB;
@property (nonatomic, retain) UILabel * tabC;
@property (nonatomic, retain) UILabel * tabD;
@property (nonatomic, assign) Networking * networking;


@end

@implementation QuestionsView


-(void)avgreger{
    
    
}



#pragma mark - getter
- (UIImageView *)questionImage{
    if (!_questionImage) {
        _questionImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _questionImage.center = CGPointMake(self.center.x, 200);
        
        
        [self.networking getimageType:animals index:arc4random() % 30 success:^(UIImage *image) {
            _questionImage.image = image;
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }
    return _questionImage;
}
- (UILabel *)tabA{
    if (!_tabA) {
        _tabA = ({
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, 100, 50)];
            lable.backgroundColor = [UIColor redColor];
            lable;
        });
    }
    return _tabA;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
