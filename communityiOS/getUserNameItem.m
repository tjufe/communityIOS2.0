//
//  getUserNameItem.m
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "getUserNameItem.h"
#import "KZPropertyMapper.h"

@implementation getUserNameItem

+(getUserNameItem *)createItemWitparametes:(NSDictionary*)dic
{
    getUserNameItem *item = [getUserNameItem new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:item usingMapping:[getUserNameItem mapDictionary]];
    return item;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"user_name":@"user_name",
                     @"user_address":@"user_address"
                     }
             };
    
}



@end
