//
//  ShoppingCartCommodity.h
//  communityiOS
//
//  Created by tjufe on 15/6/25.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//  购物车

#import <Foundation/Foundation.h>

@interface ShoppingCartCommodity : NSObject
@property (strong,nonatomic) NSString *commodity_id;
@property (strong,nonatomic) NSString *comm_unit;
@property (assign,nonatomic) double comm_price;
@property (strong,nonatomic) NSString *comm_name;
@property (assign,nonatomic) double buy_amount;
@property (strong,nonatomic) NSString *comm_photo;
@property (strong,nonatomic) NSString *shop_id;


@end
