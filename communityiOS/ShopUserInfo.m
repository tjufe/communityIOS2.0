//
//  ShopUserInfo.m
//  communityiOS
//
//  Created by tjufe on 15/6/19.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopUserInfo.h"

@implementation ShopUserInfo

+(ShopUserInfo *)initWithparametes:(NSDictionary*)dic{
    
    ShopUserInfo *shopUserInfo = [ShopUserInfo new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:shopUserInfo usingMapping:[ShopUserInfo mapDictionary]];
    return shopUserInfo;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"community_id":@"community_id",
             @"shop_user_id":@"shop_user_id",
             @"shop_user_name":@"shop_user_name",
             @"shop_pass":@"shop_pass",
             @"shop_master":@"shop_master",
             @"shop_phone":@"shop_phone",
             @"shop_address":@"shop_address",
             @"shop_auth":@"shop_auth",
             @"shop_regdate":@"shop_regdate",
             @"shop_idcard":@"shop_idcard",
             @"shop_desc":@"shop_desc",
             @"shop_photo":@"shop_photo",
             @"shop_icon":@"shop_icon",
             @"shop_sequence":@"shop_sequence",
              @"shop_notice":@"shop_notice",
             @"commodity_num":@"commodity_num",
             @"estimate_num":@"estimate_num"
             };
}



@end
