//
//  DYViewController.m
//  点击cell查看大图
//
//  Created by xudingyang on 16/8/21.
//  Copyright © 2016年 xudingyang. All rights reserved.
//

#import "DYViewController.h"
#import "DYHeroModel.h"
#import "DYHeroCell.h"
#import "DYBaseView.h"
@interface DYViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
/** 模型数组 */
@property (strong, nonatomic) NSArray *modelArray;
/** 图片url数组 */
@property (strong, nonatomic) NSArray *iconArray;
/** collectionView */
@property (weak, nonatomic) UICollectionView *collectionView;
/** rectArray 盛放位置的数组 */
@property (strong, nonatomic) NSArray<NSString *> *rectArray;
/** oldRectArray 盛放界面刚出来时候cell的位置 */
@property (strong, nonatomic) NSArray<NSString *> *oldRectArray;
/** columns 列数 */
@property (assign, nonatomic) NSInteger columns;
@end

static NSString * const identifier = @"collecitonViewCell";

@implementation DYViewController


#pragma mark - 懒加载
- (NSArray *)modelArray {
    if (_modelArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil];
        // 装cell模型的临时数组
        NSArray *tempModelArray = [NSArray arrayWithContentsOfFile:path];
        // 装模型的可变数组
        NSMutableArray *mutModelArray = [NSMutableArray array];
        // 装图片url的图片数组
        NSMutableArray *mutIconArray = [NSMutableArray array];
        for (NSDictionary *dict in tempModelArray) {
            DYHeroModel *hero = [DYHeroModel heroModelWithDict:dict];
            [mutModelArray addObject:hero];
            [mutIconArray addObject:hero.icon];
        }
        _modelArray = mutModelArray;
        _iconArray = mutIconArray;
    }
    return _modelArray;
}

- (NSArray<NSString *> *)rectArray {
    if (_rectArray == nil) {
        _rectArray = [NSArray array];
    }
    return _rectArray;
}

- (NSArray<NSString *> *)oldRectArray {
    if (_oldRectArray == nil) {
        _oldRectArray = [NSArray array];
    }
    return _oldRectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}

#pragma mark - 设置collectionView
- (void)setupCollectionView {
    // 实例化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);
    // item距离view的边距
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // 最小行间距
    layout.minimumLineSpacing = 20;
    // 最小列间距
    layout.minimumInteritemSpacing = 20;
    // 创建collectionView，绑定layout
    UICollectionView *colletionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [colletionView registerClass:[DYHeroCell class] forCellWithReuseIdentifier:identifier];
    colletionView.delegate = self;
    colletionView.dataSource = self;
    colletionView.backgroundColor = [UIColor whiteColor];
    _collectionView = colletionView;
    [self.view addSubview:colletionView];
    
    // 计算列数。本例只是计算了列数，并没有把该参数传到baseView中去。baseView中直接写死了column=4，到时候要记得修改。
    NSInteger columns = (colletionView.frame.size.width - 20*2 + 20) / 80;
    _columns = columns;
    NSLog(@"%@", [NSString stringWithFormat:@"%zd", columns]);
}
#pragma mark - 设置scrollView
- (void)setupScrollView {
    
}
#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

#pragma mark - 代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYHeroCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.heroModel = self.modelArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DYBaseView *baseView = [[DYBaseView alloc] initWithFrame:self.view.bounds];
    baseView.iconArray = self.iconArray;
    baseView.rectArray = self.rectArray;
    baseView.collectionView = self.collectionView;
    baseView.index = indexPath.row;
    [[UIApplication sharedApplication].keyWindow addSubview:baseView];
    baseView.backgroundColor = [UIColor blackColor];
}

// 计算滑动之时，cell的位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSMutableArray<NSString *> *array = [NSMutableArray<NSString *> array];
    for (NSInteger index = 0; index < self.modelArray.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        DYHeroCell *cell = (DYHeroCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        CGRect rectInWindow = [cell convertRect:cell.imageView.frame toView:window];
        [array addObject:NSStringFromCGRect(rectInWindow)];
    }
    self.rectArray = array;
}

// 此方法会在cell显示出来后再执行，所以这里可以计算滑动之前cell的位置
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableArray<NSString *> *array = [NSMutableArray<NSString *> array];
    for (NSInteger index = 0; index < self.modelArray.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        DYHeroCell *cell = (DYHeroCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        CGRect rectInWindow = [cell convertRect:cell.imageView.frame toView:window];
        [array addObject:NSStringFromCGRect(rectInWindow)];
    }
    self.oldRectArray = array;
    self.rectArray = array;
}


@end
