//
//  CommSales.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "CommSales.h"

@implementation CommSales

+(CommSales *)createItemWitparametes:(NSDictionary*)dic
{
    CommSales *comm_sale = [CommSales new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:comm_sale usingMapping:[CommSales mapDictionary]];
    return comm_sale;
}
+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"comm_sales":@"comm_sales"
                     }
             };
}

@end
