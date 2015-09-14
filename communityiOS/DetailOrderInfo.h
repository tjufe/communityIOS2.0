//
//  DetailOrderInfo.h
//  communityiOS
//
//  Created by tjufe on 15/9/10.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailOrderInfo : NSObject

@property (strong,nonatomic) NSString *detailorder_id;
@property (strong,nonatomic) NSString *mainorder_id;
@property (strong,nonatomic) NSString *commodity_id;
@property (strong,nonatomic) NSString *comm_pic;
@property (strong,nonatomic) NSString *comm_unit;
@property (assign,nonatomic) double comm_price;
@property (strong,nonatomic) NSString *commodity_name;
@property (assign,nonatomic) int buy_amount;
@property (strong,nonatomic) NSString *shop_id;

+(DetailOrderInfo *)initWithparametes:(NSDictionary*)dic;

@end
