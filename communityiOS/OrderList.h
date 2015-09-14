//
//  OrderList.h
//  communityiOS
//
//  Created by tjufe on 15/9/10.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusTool.h"

@interface OrderList : NSObject

@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

@property (nonatomic,strong)NSArray *MainOrderList;


+(OrderList *)initWithparametes:(NSDictionary*)dic;

//加载订单信息列表
+ (void)LoadOrderListWithCustID:(NSString *)cust_id  page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure;


@end
