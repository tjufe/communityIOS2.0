//
//  OrderList.m
//  communityiOS
//
//  Created by tjufe on 15/9/10.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderList.h"
#import "OrderInfo.h"
#import "KZPropertyMapper.h"
#import "HttpTool.h"


@implementation OrderList

+(OrderList *)initWithparametes:(NSDictionary *)dic{
    OrderList *list = [OrderList new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[OrderList mapDictionary]];
    
    return list;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"MainOrderList":@"MainOrderList"
                     
                     }
             };
    
}


+(void)LoadOrderListWithCustID:(NSString *)cust_id page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:cust_id forKey:@"cust_id"];
    [firstDic setValue:page forKey:@"page"];
    [firstDic setValue:rows forKey:@"rows"];
    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"LoadOrderList" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         OrderList *list = [OrderList initWithparametes:dic];
                         NSMutableArray *ListArray = [NSMutableArray array];
                         for(NSDictionary *dic in list.MainOrderList ){
                             OrderInfo *order_info = [OrderInfo initWithparametes:dic];
                             [ListArray addObject:order_info];
                         }
                         success(ListArray);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];

    
    
    
}




@end
