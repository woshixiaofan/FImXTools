//
//  CollectionViewCell.m
//  FXTools
//
//  Created by 凡迅 on 2016/12/22.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (UILabel *)label {
    if (!_label) {
        _label=[[UILabel alloc]init];
    }
    return _label;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)setCellsNum:(NSInteger)num {
    if (num) {
        _label.text=@"阅阅阅阅阅阅阅阅阅阅阅阅阅阅阅阅阅阅阅";
        _label.frame=CGRectMake(0, 30, 250, 30);
        _label.backgroundColor=[UIColor orangeColor];
    }else {
        _label.text=@"艾美阅读";
        _label.frame=CGRectMake(0, 30, 80, 30);
        _label.backgroundColor=[UIColor magentaColor];
    }
}
@end
