//
//  FairyFallsLayout.h
//  FairyFallsDemo
//
//  Created by Fairy on 17/4/26.
//  Copyright © 2017年 Fairy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FairyFallsLayout;

@protocol FairyFallsLayoutDelegate <NSObject>

@optional
/// 列数
- (CGFloat)columnCountInFallsLayout:(FairyFallsLayout *)fallsLayout;
/// 列间距
- (CGFloat)columnMarginInFallsLayout:(FairyFallsLayout *)fallsLayout;
/// 行间距
- (CGFloat)rowMarginInFallsLayout:(FairyFallsLayout *)fallsLayout;
/// collectionView边距
- (UIEdgeInsets)edgeInsetsInFallsLayout:(FairyFallsLayout *)fallsLayout;



@end

@interface FairyFallsLayout : UICollectionViewLayout

@property (nonatomic, weak) id<FairyFallsLayoutDelegate> delegate;
@property (nonatomic,assign) int i ;
@end
