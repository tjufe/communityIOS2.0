//
//  OrderInfo.m
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderInfo.h"


@implementation OrderInfo


+(OrderInfo *)initWithparametes:(NSDictionary *)dic{
    
    OrderInfo *orderInfo = [OrderInfo new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:orderInfo usingMapping:[OrderInfo mapDictionary]];
    return orderInfo;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"order_id":@"order_id",
             @"cust_id":@"cust_id",
             @"cust_name":@"cust_name",
             @"order_state":@"order_state",
             @"shop_id":@"shop_id",
             @"user_phone":@"user_phone",
             @"shop_phone":@"shop_phone",
             @"order_money":@"order_money",
             @"order_sendfee":@"order_sendfee",
             @"address":@"address",
             @"pay_type":@"pay_type",
             @"order_date":@"order_date",
             @"sendtime":@"sendtime",
             @"detail_order_list":@"detail_order_list"
             };
}




@end
