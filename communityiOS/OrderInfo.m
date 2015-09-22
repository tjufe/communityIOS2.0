//
//  OrderInfo.m
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderInfo.h"
#import "HttpTool.h"
#import "addOrderItem.h"


@implementation OrderInfo


+(OrderInfo *)initWithparametes:(NSDictionary *)dic{
    
    OrderInfo *orderInfo = [OrderInfo new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:orderInfo usingMapping:[OrderInfo mapDictionary]];
    return orderInfo;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"order_id":@"order_id",
             @"cust_id":@"cust_id",
             @"cust_name":@"cust_name",
             @"order_state":@"order_state",
             @"shop_id":@"shop_id",
             @"shop_user_name":@"shop_name",
             @"user_phone":@"user_phone",
             @"shop_phone":@"shop_phone",
             @"shop_icon":@"shop_head",
             @"order_money":@"order_money",
             @"order_sendfee":@"order_sendfee",
             @"address":@"address",
             @"pay_type":@"pay_type",
             @"order_date":@"order_date",
             @"sendtime":@"sendtime",
             @"detail_order_list":@"detail_order_list"
             };
}




+(void)AddNewMainOrderInfowithShopID:(NSString *)shop_id CustID:(NSString *)cust_id CustName:(NSString *)cust_name CustPhone:(NSString *)cust_phone ShopPhone:(NSString *)shop_phone OrderMoney:(NSNumber *)order_money OrderSendfee:(NSNumber *)order_sendfee OrderState:(NSString *)order_state OrderAddress:(NSString *)order_address PayType:(NSString *)pay_type CommID:(NSMutableArray *)comm_id CommUnit:(NSMutableArray *)comm_unit CommPrice:(NSMutableArray *)comm_price CommName:(NSMutableArray *)comm_name BuyAmount:(NSMutableArray *)buy_amount Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
        NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
        [firstDic setValue:shop_id forKey:@"shop_id"];
        [firstDic setValue:cust_id forKey:@"cust_id"];
        [firstDic setValue:cust_name forKey:@"cust_name"];
        [firstDic setValue:cust_phone forKey:@"cust_phone"];
        [firstDic setValue:shop_phone forKey:@"shop_phone"];
        [firstDic setValue:order_money forKey:@"order_money"];
        [firstDic setValue:order_sendfee forKey:@"order_sendfee"];
        [firstDic setValue:order_state forKey:@"order_state"];
        [firstDic setValue:order_address forKey:@"order_address"];
        [firstDic setValue:pay_type forKey:@"pay_type"];
    
    
    
    
        NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
        [secondDic  setValue:firstDic forKey:@"Data"];
    
        NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
        [thirdDic setValue:secondDic forKey:@"param"];
        [thirdDic setValue:@"AddNewMainOrder" forKey:@"method"];
    
        [HttpTool postWithparams:thirdDic success:^(id responseObject) {
            //no response
            
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            addOrderItem *result = [addOrderItem createItemWitparametes:dic];
            success(result.mainorder_id);
        
        } failure:^(NSError *error) {
            NSLog(@"%@",thirdDic);
            if (failure == nil) return;
            failure(error);
        }];
}


@end
