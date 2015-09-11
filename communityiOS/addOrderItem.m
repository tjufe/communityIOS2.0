//
//  addOrderItem.m
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "addOrderItem.h"

@implementation addOrderItem

+(addOrderItem *)createItemWitparametes:(NSDictionary*)dic
{
    addOrderItem *item = [addOrderItem new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:item usingMapping:[addOrderItem mapDictionary]];
    return item;
}
+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                       @"mainorder_id":@"mainorder_id"
                     }
             };
}



@end
