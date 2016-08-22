//
//  DYHeroCell.h
//  点击cell查看大图
//
//  Created by xudingyang on 16/8/21.
//  Copyright © 2016年 xudingyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYHeroModel;

@interface DYHeroCell : UICollectionViewCell

/** heroModel */
@property (strong, nonatomic) DYHeroModel *heroModel;

/** 因为外界要用到imageView，所有暴露出来 */
@property (weak, nonatomic) UIImageView *imageView;

@end
