//
//  DYBaseView.h
//  点击cell查看大图
//
//  Created by xudingyang on 16/8/21.
//  Copyright © 2016年 xudingyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYBaseView : UIView

/** 图片url数组 */
@property (strong, nonatomic) NSArray *iconArray;
/** index 模型在数组中的下标；或者说cell的row */
@property (assign, nonatomic) NSInteger index;
/** collection 在获得下一个cell的时候，需要用到collection */
@property (strong, nonatomic) UICollectionView *collectionView;
/** rectArray */
@property (strong, nonatomic) NSArray<NSString *> *rectArray;
/** oldRectArray */
@property (strong, nonatomic) NSArray<NSString *> *oldRectArray;
/** columnCount cell的列数 */
//@property (assign, nonatomic) NSInteger columnCount;

@end
