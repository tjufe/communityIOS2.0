//
//  CommodityInfo.m
//  communityiOS
//
//  Created by tjufe on 15/6/23.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "CommodityInfo.h"

@implementation CommodityInfo

+(CommodityInfo *)initWithparametes:(NSDictionary *)dic{
    
    CommodityInfo *commodity = [CommodityInfo new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:commodity usingMapping:[CommodityInfo mapDictionary]];
    return commodity;
    
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"commodity_id":@"commodity_id",
             @"comm_name":@"comm_name",
             @"comm_unit":@"comm_unit",
             @"comm_price":@"comm_price",
             @"comm_state":@"comm_state",
             @"comm_regdate":@"comm_regdate",
             @"comm_desc":@"comm_desc",
             @"comm_photo":@"comm_photo",
             @"comm_sequence":@"comm_sequence",
             @"shop_id":@"shop_id"
             };
}




@end
