//
//  EstimateInfo.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "EstimateInfo.h"
#import "KZPropertyMapper.h"

@implementation EstimateInfo

+(EstimateInfo *)initWithparametes:(NSDictionary*)dic{
    
    EstimateInfo *estimate_info = [EstimateInfo new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:estimate_info usingMapping:[EstimateInfo mapDictionary]];
    
    return estimate_info;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"estimate_id":@"estimate_id",
             @"shop_id":@"shop_id",
             @"user_id":@"user_id",
             @"user_name":@"user_name",
             @"user_head":@"user_head",
             @"content":@"content",
             @"score":@"score",
             @"estimate_date":@"estimate_date",
//             @"buy_date":@"buy_date"
             };
}

@end
