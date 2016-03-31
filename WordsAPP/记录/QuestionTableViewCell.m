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
    
    [self.contentView addSubview:self.typeImage];
    [self.contentView addSubview:self.groups];
    [self.contentView addSubview:self.date];
    
}

#pragma mark - getter
- (UIImageView *)typeImage{
    if (!_typeImage) {
        _typeImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
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
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.bounds) + 10, 30, 60, 40)];
            //            label.backgroundColor= [UIColor redColor];
            label.font = [UIFont systemFontOfSize:20];
            label.textColor = [UIColor greenColor];
            label;
        });
    }
    return _groups;
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
