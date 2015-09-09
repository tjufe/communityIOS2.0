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



+(void)AddNewOrderInfowithShopID:(NSString *)shop_id CustID:(NSString *)cust_id CustName:(NSString *)cust_name CustPhone:(NSString *)cust_phone ShopPhone:(NSString *)shop_phone OrderMoney:(NSNumber *)order_money OrderSendfee:(NSNumber *)order_sendfee OrderState:(NSString *)order_state OrderAddress:(NSString *)order_address PayType:(NSString *)pay_type CommID:(NSMutableArray *)comm_id CommUnit:(NSMutableArray *)comm_unit CommPrice:(NSMutableArray *)comm_price CommName:(NSMutableArray *)comm_name BuyAmount:(NSMutableArray *)buy_amount Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
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
        [firstDic setValue:comm_id forKey:@"comm_id"];
        [firstDic setValue:comm_unit forKey:@"comm_unit"];
        [firstDic setValue:comm_price forKey:@"comm_price"];
        [firstDic setValue:comm_name forKey:@"comm_name"];
        [firstDic setValue:buy_amount forKey:@"buy_amount"];
        
    
    
    
        NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
        [secondDic  setValue:firstDic forKey:@"Data"];
    
        NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
        [thirdDic setValue:secondDic forKey:@"param"];
        [thirdDic setValue:@"AddNewOrder" forKey:@"method"];
    
        [HttpTool postWithparams:thirdDic success:^(id responseObject) {
            //no response
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            addOrderItem *result = [addOrderItem createItemWitparametes:dic];
            success(result);
        
        } failure:^(NSError *error) {
            if (failure == nil) return;
            failure(error);
        }];

    
}
@end
