//
//  DYHeroCell.m
//  点击cell查看大图
//
//  Created by xudingyang on 16/8/21.
//  Copyright © 2016年 xudingyang. All rights reserved.
//

#import "DYHeroCell.h"
#import "DYHeroModel.h"

@interface DYHeroCell ()

@end

@implementation DYHeroCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        imageView.frame = self.contentView.bounds;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setHeroModel:(DYHeroModel *)heroModel {
    _heroModel = heroModel;
    _imageView.image = [UIImage imageNamed:heroModel.icon];
}

@end
