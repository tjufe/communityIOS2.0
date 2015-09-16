//
//  DetailOrderInfo.m
//  communityiOS
//
//  Created by tjufe on 15/9/10.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "DetailOrderInfo.h"
#import "KZPropertyMapper.h"
#import "HttpTool.h"
#import "newPostItem.h"

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

+(void)AddDetailNewOrderInfowithMainorderID:(NSString *)mainorder_id CommID:(NSString *)comm_id CommUnit:(NSString *)comm_unit CommPrice:(NSNumber *)comm_price CommName:(NSString *)comm_name BuyAmount:(NSNumber *)buy_amount ShopID:(NSString *)shop_id Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
        NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
        [firstDic setValue:shop_id forKey:@"shop_id"];
        [firstDic setValue:comm_id forKey:@"comm_id"];
        [firstDic setValue:comm_unit forKey:@"comm_unit"];
        [firstDic setValue:comm_price forKey:@"comm_price"];
        [firstDic setValue:comm_name forKey:@"comm_name"];
        [firstDic setValue:buy_amount forKey:@"buy_amount"];
    
        NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
        [secondDic  setValue:firstDic forKey:@"Data"];
    
        NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
        [thirdDic setValue:secondDic forKey:@"param"];
        [thirdDic setValue:@"AddNewMainOrder" forKey:@"method"];
    
        [HttpTool postWithparams:thirdDic success:^(id responseObject) {
        //no response
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            newPostItem *result = [newPostItem createItemWitparametes:dic];
            success(result);
        
        } failure:^(NSError *error) {
            if (failure == nil) return;
            failure(error);
        }];

    


    
}

@end
