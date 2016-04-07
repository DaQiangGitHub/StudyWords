//
//  QuestionTableViewCell.m
//  WordsAPP
//
//  Created by rimi on 16/3/31.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "QuestionTableViewCell.h"

@implementation QuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews{
    self.contentView.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.6 alpha:1];
    [self.contentView addSubview:self.typeImage];
    [self.contentView addSubview:self.groups];
    [self.contentView addSubview:self.date];
    
}

#pragma mark - getter
- (UIImageView *)typeImage{
    if (!_typeImage) {
        _typeImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 240, 80)];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.layer.masksToBounds = YES;
            imageView;
        });
    }
    return _typeImage;
}
- (UILabel *)groups{
    if (!_groups) {
        _groups = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.bounds) - 40, 30, 120, 40)];
            //            label.backgroundColor= [UIColor redColor];
            label.font = [UIFont systemFontOfSize:25];
            label.textColor = [UIColor grayColor];
            label;
        });
    }
    return _groups;
}
- (UILabel *)date{
    if (!_date) {
        _date = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.bounds) - 40, CGRectGetHeight(self.contentView.bounds) + 50, 120, 40)];
            label.font = [UIFont systemFontOfSize:20];
            label;
        });
    }
    return _date;
}
@end
