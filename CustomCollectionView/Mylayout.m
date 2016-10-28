//
//  Mylayout.m
//  CustomCollectionView
//
//  Created by mac1 on 16/10/24.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "Mylayout.h"
#define itemWidth 50
@interface Mylayout(){
    int _itemCount;
    NSMutableArray *_attributeArray;
    
}
@end
@implementation Mylayout
-(void)prepareLayout{
    [super prepareLayout];
    /*获取item的个数*/
    _itemCount = (int)[self.collectionView numberOfItemsInSection:0];
    _attributeArray = [[NSMutableArray alloc] init];
    
}
//设置内容区域的大小
-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width * 3,self.collectionView.frame.size.height);
}
//通过所在的indexPath 确定位置
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = CGSizeMake(itemWidth, itemWidth);
    
    /*设置大圆的半径，取长款最短*/
    CGFloat radius = MIN(self.collectionView.frame.size.width *3, self.collectionView.frame.size.height * 0.5 )
    ;
    /*计算大圆心位置*/
    CGPoint center = CGPointMake(self.collectionView.frame.size.width * 0.5+ self.collectionView.contentOffset.x, self.collectionView.frame.size.height * 0.5);
    /*获得每个item之间的间距  (角度)*/
    CGFloat angelMargin = M_PI / (_itemCount - 1);
    //计算每个item中心的坐标
    //算出的x y值还要减去item自身的半径大小
    float x = center.x+cosf(angelMargin*indexPath.item   + M_PI)*(radius +self.collectionView.contentOffset.x);
    float y = center.y+sinf(angelMargin*indexPath.item + M_PI)*(radius * 0.5 -self.collectionView.contentOffset.x / itemWidth * 0.25);
    NSLog(@"y------------->  %f  indexpath:  %ld",y,(long)indexPath.item);
    attribute.center = CGPointMake(x, y);
    //    attribute.frame = [self getRectForItem:(int)indexPath.item];
    return attribute;
}
-(CGRect)getRectForItem:(int)item{
    double newIndex = item - self.collectionView.contentOffset.x / itemWidth;
    float scaleFactor = fmax(0.6, 1 - fabs( newIndex *0.25));
    float deltaX = self.collectionView.frame.size.height * 0.5;
    float rX = cosf(newIndex *M_PI/180) * ( (deltaX*scaleFactor));
    float rY = sinf(newIndex *M_PI/180) * ((deltaX*scaleFactor));
    float oX =  (0.5 * itemWidth) - self.collectionView.contentOffset.x / itemWidth - 0.5* self.collectionView.frame.size.height;
    float oY = self.collectionView.bounds.size.width/2 + self.collectionView.contentOffset.x - (0.5 * self.collectionView.frame.size.height);
    //    float x =cosf(item * M_PI / 180)
    
    
    
    CGRect itemFrame = CGRectMake(oX + rX, oY + rY, itemWidth, itemWidth);
    
    return itemFrame;
}

//返回设置数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    for (int i = 0; i < _itemCount; i++) {
        NSIndexPath *indexPath= [NSIndexPath indexPathForItem:i inSection:0];
        [_attributeArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return _attributeArray;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
//
//    return CGPointZero;
//}
//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//
//    return CGPointZero;
//}
@end
