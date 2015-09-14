//
//  DetailOrderInfo.m
//  communityiOS
//
//  Created by tjufe on 15/9/10.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "DetailOrderInfo.h"
#import "KZPropertyMapper.h"

@implementation DetailOrderInfo

+(DetailOrderInfo *)initWithparametes:(NSDictionary *)dic{
    DetailOrderInfo *list = [DetailOrderInfo new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[DetailOrderInfo mapDictionary]];
    
    return list;
}


+ (NSDictionary*)mapDictionary
{
    return @{
             @"detailorder_id" : @"detailorder_id",
             @"mainorder_id" : @"mainorder_id",
             @"commodity_id" :@"commodity_id",
             @"comm_unit":@"comm_unit",
             @"comm_price":@"comm_price",
             @"commodity_name":@"commodity_name",
             @"buy_amount":@"buy_amount",
             @"shop_id":@"shop_id",
             @"comm_pic":@"comm_pic"
             
             };
    
}

@end
