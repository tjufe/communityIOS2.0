//
//  DetailOrderInfo.h
//  communityiOS
//
//  Created by tjufe on 15/9/10.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusTool.h"

@interface DetailOrderInfo : NSObject

@property (strong,nonatomic) NSString *detailorder_id;
@property (strong,nonatomic) NSString *mainorder_id;
@property (strong,nonatomic) NSString *commodity_id;
@property (strong,nonatomic) NSString *comm_pic;
@property (strong,nonatomic) NSString *comm_unit;
@property (assign,nonatomic) double comm_price;
@property (strong,nonatomic) NSString *commodity_name;
@property (assign,nonatomic) int buy_amount;
@property (strong,nonatomic) NSString *shop_id;
+(DetailOrderInfo *)initWithparametes:(NSDictionary*)dic;


//添加订单子项
+(void) AddDetailNewOrderInfowithMainorderID:(NSString *)mainorder_id CommID:(NSString *)comm_id CommUnit:(NSString *)comm_unit CommPrice:(NSNumber *)comm_price CommName:(NSString *)comm_name BuyAmount:(NSNumber *)buy_amount ShopID:(NSString *)shop_id Success:(StatusSuccess)success failurs:(StatusFailurs)failure;


@end
