//
//  FairyShopCell.m
//  FairyFallsDemo
//
//  Created by Fairy on 17/4/26.
//  Copyright © 2017年 Fairy. All rights reserved.
//

#import "FairyShopCell.h"
#import "FairyShop.h"
#import <UIImageView+WebCache.h>

@interface FairyShopCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FairyShopCell

- (void)setShop:(FairyShop *)shop
{
    _shop = shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.priceLabel.text = shop.price;
}

@end
