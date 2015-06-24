//
//  CommodityList.m
//  communityiOS
//
//  Created by tjufe on 15/6/23.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "CommodityList.h"
#import "HttpTool.h"

@implementation CommodityList

+(CommodityList *)initWithparametes:(NSDictionary *)dic{
    
    CommodityList *list = [CommodityList new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[CommodityList mapDictionary]];
    
    return list;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"CommodityList":@"CommodityList"
                     
                     }
             };
    
}

+(void)LoadCommodityListWithShopID:(NSString *)shop_id page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:shop_id forKey:@"shop_id"];
    [firstDic setValue:page forKey:@"page"];
    [firstDic setValue:rows forKey:@"rows"];
    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"LoadCommodityList" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         CommodityList *list = [CommodityList initWithparametes:dic];
                         
                         success(list);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];
    
    
    
}




@end
