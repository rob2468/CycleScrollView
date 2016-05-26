//
//  CSCycleScrollView.m
//  CycleScrollView
//
//  Created by chenjun on 5/26/16.
//  Copyright © 2016 chenjun. All rights reserved.
//

#import "CSCycleScrollView.h"
#import "CSCycleScrollCell.h"

@interface CSCycleScrollView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataList;

@end

@implementation CSCycleScrollView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.pagingEnabled = YES;
        [self addSubview:self.collectionView];
        
        [self.collectionView registerClass:[CSCycleScrollCell class] forCellWithReuseIdentifier:@"CustomCell"];
        
        // 约束
        // collectionView
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.collectionView
                                      attribute:(NSLayoutAttributeLeading)
                                      relatedBy:(NSLayoutRelationEqual)
                                         toItem:self
                                      attribute:(NSLayoutAttributeLeading)
                                     multiplier:1
                                       constant:0]];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.collectionView
                                      attribute:(NSLayoutAttributeTrailing)
                                      relatedBy:(NSLayoutRelationEqual)
                                         toItem:self
                                      attribute:(NSLayoutAttributeTrailing)
                                     multiplier:1
                                       constant:0]];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.collectionView
                                      attribute:(NSLayoutAttributeTop)
                                      relatedBy:(NSLayoutRelationEqual)
                                         toItem:self
                                      attribute:(NSLayoutAttributeTop)
                                     multiplier:1
                                       constant:0]];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.collectionView
                                      attribute:(NSLayoutAttributeBottom)
                                      relatedBy:(NSLayoutRelationEqual)
                                         toItem:self
                                      attribute:(NSLayoutAttributeBottom)
                                     multiplier:1
                                       constant:0]];
    }
    return self;
}

- (void)updateUIWithData:(NSArray *)dataList
{
    if (dataList != nil && [dataList count] > 0)
    {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:dataList];
        
        // 在头尾增加元素，以实现轮播
        NSString *first = [dataList firstObject];
        NSString *last = [dataList lastObject];
        [arr insertObject:[last copy] atIndex:0];
        [arr addObject:[first copy]];
        self.dataList = arr;
        
        // 定位到第一个view
        [self.collectionView reloadData];
        [self layoutIfNeeded];
        [self.collectionView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    NSInteger row = [indexPath item];
    NSString *title = [self.dataList objectAtIndex:row];
    cell.titleLabel.text = title;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastContentOffsetX = FLT_MIN;
    
    if (lastContentOffsetX == FLT_MIN)
    {
        lastContentOffsetX = scrollView.contentOffset.x;
        return;
    }
    
    // 原始布局数据
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGRect bounds = scrollView.bounds;
    CGFloat pageWidth = scrollView.frame.size.width;
    CGFloat offset = pageWidth * ([self.dataList count] - 2);
    
    if (currentOffsetX < pageWidth && currentOffsetX < lastContentOffsetX) // 右划
    {
        // 修改布局
        lastContentOffsetX = currentOffsetX + offset;
        bounds.origin.x = lastContentOffsetX;
        scrollView.bounds = bounds;
    }
    else if (currentOffsetX > offset && currentOffsetX > lastContentOffsetX) // 左划
    {
        // 修改布局
        lastContentOffsetX = currentOffsetX - offset;
        bounds.origin.x = lastContentOffsetX;
        scrollView.bounds = bounds;
    }
    else
    {
        lastContentOffsetX = currentOffsetX;
    }
}

@end
