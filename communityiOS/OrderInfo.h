//
//  OrderInfo.h
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"


@interface OrderInfo : NSObject

@property (strong,nonatomic) NSString *order_id;
@property (strong,nonatomic) NSString *cust_id;
@property (strong,nonatomic) NSString *cust_name;
@property (strong,nonatomic) NSString *order_state;
@property (strong,nonatomic) NSString *shop_id;
@property (strong,nonatomic) NSString *user_phone;
@property (strong,nonatomic) NSString *shop_phone;
@property (assign,nonatomic) double order_money;
@property (assign,nonatomic) double order_sendfee;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *pay_type;
@property (strong,nonatomic) NSString *order_date;
@property (strong,nonatomic) NSString *sendtime;
@property (strong,nonatomic) NSString *shop_name;
@property (strong,nonatomic) NSString *shop_head;
@property (strong,nonatomic) NSArray *detail_order_list;


+(OrderInfo *)initWithparametes:(NSDictionary*)dic;



@end
