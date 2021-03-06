//
//  RecoredTableViewCell.m
//  WordsAPP
//
//  Created by rimi on 16/3/29.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "RecoredTableViewCell.h"


@implementation RecoredTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    
    [self.contentView addSubview:self.typeImage];
    [self.contentView addSubview:self.levelImage];
    [self.contentView addSubview:self.beginButton];
    [self.contentView addSubview:self.score];
    [self.contentView addSubview:self.date];
    
}
#pragma mark - getter 
- (UIImageView *)typeImage{
    if (!_typeImage) {
        _typeImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 140, 60)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.layer.masksToBounds = YES;
            imageView;
        });
    }
    return _typeImage;
}
- (UIImageView *)levelImage{
    if (!_levelImage) {
        _levelImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 140, 60)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.layer.masksToBounds = YES;
            imageView;
        });
    }
    return _levelImage;
}
- (UILabel *)beginButton{
    if (!_beginButton) {
        _beginButton = ({
            UILabel * button = [[UILabel alloc] init];
            button.frame = CGRectMake(0, 0, 150, 150);
            button.center = self.contentView.center;
            button.text = @"开始\n答题";
            button.textColor = [UIColor redColor];
            button.font = [UIFont systemFontOfSize:30];
            button.numberOfLines = 2;
            button;
        });
    }
    return _beginButton;
}
- (UILabel *)score{
    if (!_score) {
        _score = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.bounds) + 10, 30, 60, 40)];
//            label.backgroundColor= [UIColor redColor];
            label.font = [UIFont systemFontOfSize:20];
            label.textColor = [UIColor greenColor];
            label;
        });
    }
    return _score;
}
- (UILabel *)date{
    if (!_date) {
        _date = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.bounds) - 20, CGRectGetHeight(self.contentView.bounds) + 50, 120, 40)];
            //            label.backgroundColor= [UIColor redColor];
            label.font = [UIFont systemFontOfSize:20];
            label;
        });
    }
    return _date;
}
@end
